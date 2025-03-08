#! /usr/bin/env bash

if [ ! -d "env" ]; then
    python3.10 -m venv env
    if [ $? -ne 0 ]; then
        echo "Failed to create virtual environment"
        exit 1
    fi
fi

. env/bin/activate

pip install -r requirements.txt
