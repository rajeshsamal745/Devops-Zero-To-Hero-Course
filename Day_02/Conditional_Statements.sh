#!/bin/bash

#Check if a file exists

if [ -f "$1" ]; then
	echo "File exists"
else
	echo "File not found"
fi
