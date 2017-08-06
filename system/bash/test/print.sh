#!/bin/bash
# Created by Rui Rafael Rosillas
# Simple Output Text command

if [ $# -lt 1 ]; then
    echo "No input was found!"
else
    echo $@
fi

