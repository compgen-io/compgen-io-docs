#!/bin/bash

if [ -d venv ]; then
	echo "venv directory exists! Aborting!!!!"
	exit 1
fi
python3 -m venv venv
venv/bin/pip install -r requirements.txt
