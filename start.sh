#!/bin/bash
cd "$(dirname $0)"
WORK_DIR="$(pwd)"
echo "" > ./ipython.log

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
	virtualenv -p /usr/bin/python3 env &&
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
	pip install --upgrade -r ./requirements.txt &> ./ipython.log &&
	echo Upgrade done.
else
	echo No, we are offline. Not upgrading PIP modules.
fi

echo Enabling the Jupyter NBExtensions...
jupyter contrib nbextension install --sys-prefix &> ./ipython.log &&
	echo Extensions enabled. ||
	exit 1

echo Starting the Jupyter Notebook...
ipython notebook $IPYTHON_OPTIONS &> ./ipython.log &
PID="$!"
disown
echo iPython Notebook is started and running at PID $PID
echo $PID > ./.ipython.pid

