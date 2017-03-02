#!/bin/bash
cd "$(dirname $0)"
WORK_DIR="$(pwd)"

function not_running() {
	echo Not running
	exit 1
}

PID="$(cat ./.ipython.pid)"
ps -ef | grep -v grep | grep "$PID" ||
	ps -ef | grep -v grep | grep ipython | grep notebook ||
	not_running
