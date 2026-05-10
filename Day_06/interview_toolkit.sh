#!/bin/bash
# Shell Scripting & Linux Interview Toolkit
# Author: Rajesh
# Date: 10th May,2026
# Purpose: Demonstrate solutions to 16 common interview questions
# Version: v1

set -euo pipefail
trap 'echo "[Error] Script Interrupted. Exiting..."; exit 1' SIGINT

# 1. Most commonly used shell commands
echo "[1] Common commands demo:"
touch data/app.log
ls -lh data
echo "Error: Disk full" > data/app.log
grep "Error" data/app.log

# 2. List all process
echo "[2] Listing all processes (PID only):"
ps -ef | head -5
ps -ef | awk '{print $2}' | head -5

# 3. Print only errors from remote log
echo "[3] Fetching errors from remote log (GitHub example):"
url=

