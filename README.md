Jupyter - iPython Notebooks
===========================

Hi! I am a Linux user studying statistics and data science.

A few days ago I found Jupyter, the iPython Notebook.

It is a wonderful piece of software, very easy to use and very powerful.

You can write using markdown, Latex and create very nice graphs.

![](http://jupyter.org/assets/jupyterpreview.png)

![](http://i.imgur.com/eo2SqS9.png)


Requirements
------------

This setup includes the default Python3 kernel, a R kernel, a Ruby kernel
and a Bash kernel. But you have to prepare some things before install
Jupyter.

### Python3

You will need to have Python 3 previously installed. It is necessary to
have the virtualenv and pip packeges installed somehow. You can use
the operating system Python 3 packages, Anaconda, Pyenv, any of them.

### Bash

You don't need to install additional packages, the `start.sh` script already
install the bash_kernel using pip.

### R

I will assume you already have R installed and running (if not, just do an
  `sudo apt install r-base libcurl4-openssl-dev libssl-dev`).
You will need a R console. Install the IRkernel using devtools:

```r
install.packages('devtools')
devtools::install_github('IRkernel/IRkernel')
```

### Ruby

You will need some Ruby packages:
```
sudo apt install libtool libffi-dev ruby ruby-dev make
sudo gem install cztop

sudo apt install git libzmq-dev autoconf pkg-config
git clone https://github.com/zeromq/czmq
cd czmq
./autogen.sh && ./configure && sudo make && sudo make install

sudo gem install iruby
```

 Install
-------

Just clone the repo and execute the start script.
The browser window will open showing the Jupyter screen.

```
sudo apt install python3-dev python3-pip python-virtualenv
git clone https://github.com/wesleyit/python_ipython_notebooks.git iPython
cd iPython
./start.sh
```
It will take some minutes in the first time you run, then it will be
faster.

To stop using, just execute the stop script.

```
./stop.sh
```

Thanks for using :)
