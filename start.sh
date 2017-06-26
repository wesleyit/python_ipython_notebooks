#!/bin/bash
cd "$(dirname $0)" || exit 1
export LOG="./ipython.log"

case "$1" in
  -d)export LOG="$(tty)";;
  *)echo "Use -d to enable debug."; echo "" > "$LOG";;
esac

IPYTHON_OPTIONS+=' --config=./jupyter_notebook_config.py '
IPYTHON_OPTIONS+=' --notebook-dir=./notebooks '
IPYTHON_OPTIONS+=' --NotebookApp.password="" '
IPYTHON_OPTIONS+=' --NotebookApp.token="" '

echo Stopping previous notebook, if exists
./status.sh &> /dev/null && ./stop.sh

echo Checking or creating the Python Virtual Environment...
if [ -e ./env/bin/activate ]
then
  echo Found a valid environment.
else
  virtualenv -p python3 env &&
  echo Created a new Python Virtual Environment at env. ||
  exit 1
fi

echo Importing the Python Virtual Environment...
source ./env/bin/activate &&
echo Environment imported. ||
exit 1

echo Checking if we have an internet connection...
if ping -c 4 -W 1 www.google.com.br &> /dev/null
then
  echo Yes, we have! Upgrading PIP modules...
  pip install --upgrade -r ./requirements.txt &> "$LOG" &&
  echo Upgrade done.
else
  echo No, we are offline. Not upgrading PIP modules.
fi

echo Enabling the Jupyter NBExtensions...
jupyter contrib nbextension install --sys-prefix &> "$LOG" &&
jupyter nbextension enable --py --sys-prefix widgetsnbextension &> "$LOG" &&
echo Extensions enabled. ||
exit 1

echo Linking the kernel directory...
desired="$(pwd)/kernels"
found="$(file env/share/jupyter/kernels | rev | cut -d " " -f 1 | rev)"
if [ "$desired" == "$found" ]
then
  echo Already linked.
else
  echo Linking...
  rm -rf env/share/jupyter/kernels
  ln -s "$desired" env/share/jupyter/kernels
fi
echo done.

echo Starting the Jupyter Notebook...
jupyter notebook $IPYTHON_OPTIONS &> "$LOG" &
PID="$!"
disown
echo iPython Notebook is started and running at PID $PID
echo $PID > ./.ipython.pid
