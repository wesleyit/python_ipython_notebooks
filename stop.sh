#!/bin/bash
cd "$(dirname $0)"
WORK_DIR="$(pwd)"

PID="$(cat ./.ipython.pid)"
echo "Killing ipython at PID $PID..."
kill "$PID" && echo 'Killed!' || echo 'Not killed.'

