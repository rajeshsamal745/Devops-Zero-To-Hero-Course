#!/bin/bash

LOGFILE="all_in_one.log"

echo "=== Starting Combined Script ===" | tee -a $LOGFILE

# 1. Create a file
FILE="demo.txt"
touch "$FILE"
echo "File $FILE created." | tee -a $LOGFILE
