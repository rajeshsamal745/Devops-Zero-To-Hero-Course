#!/bin/bash

#Assign arguments to variable names

fileName=$1
number=$2
service=$3

#Check if a file exists

if [ -f "$fileName" ]; then
	echo "$fileName exists"
else
	echo "$fileName not found"
fi

#Check user input
if [ "$number" -eq 10 ]; then
	echo "$number is exactly 10"
elif [ "$number" -gt 10 ]; then
	echo "$number is greater than 10"
else
	echo "$number is smaller than 10"
fi

#Check a system service
if systemctl is-active --quiet "$service"; then
	echo "$service is running"
else
	echo "$service is not running"
fi
