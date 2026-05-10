#!/bin/bash
# Node Health & DevOps Utility Toolkit
# Author: Rajesh
# Date: 2026-05-09
# Purpose: Demonstrate production-level shell scripting concepts
# Version: v1

# === Best Practices ===
set -euo pipefail  # Exit on error, undefined vars, or pipe failures
trap 'echo "[ERROR] Script Interrupted Stopping..."; exit 1' SIGINT

echo " === Node Health Toolkit Started === "

# === Monitoring Node Health ===
echo "[INFO] Checking disk, memory, and CPU..."
df -h
free -h
nproc

# === Process Management ===
echo "Listening process ..."
ps -ef | head -5

echo "Filtering process with grep (example: ssh)"
ps -ef | grep ssh

# === Pipe & Command Chaining ===
echo "[INFO] Demonstrating pipe usage..."
ps -ef | grep ssh | awk '{print $2}'

# Interview Q: Why does `date | echo` fail?
echo "[NOTE] echo does not accept stdin, so 'date | echo' fails."

# === Text Processing with awk ===
echo "[INFO] Using awk to print usernames from ps:"
ps -ef | awk '{print $1}' | sort | uniq

# === DevOps Use-Case: Log Analysis ===
echo "[INFO] Searching errors in remote logfile..."
# Example: ssh user@remote "grep -i error /var/log/app.log"
echo "[SIMULATION] Remote log search would run here."

# === curl ===
echo "Fetching headers of GitHub log file with curl..."
curl -I https://github.com/rajeshsamal745/Devops-Zero-To-Hero-Course/blob/main/Day_06/all_in_one.log

url="https://github.com/rajeshsamal745/Devops-Zero-To-Hero-Course/blob/main/Day_06/all_in_one.log"
if curl -s "$url" | grep -qi "error"; then
	echo "❌ Errors detected in log file"
	curl -s "$url" | grep -i "error"
else
	echo "✅ No error found in log file"
fi

# === wget ===
github_url="https://github.com/rajeshsamal745/Devops-Zero-To-Hero-Course/blob/main/Day_06/all_in_one.log"
DEST="data/logFile.log"

# Create directory
mkdir -p data
echo "Starting download..."
if wget "$github_url" -O "$DEST"; then
	echo "✅ Downloaded successfully!"
else
	echo "❌ Download failed! Stopping script."
        exit 1
fi




# === Signal Handling with trap ===
trap 'echo "[ERROR] Script interrupted. Cleaning up..."; exit 1' SIGINT

echo "Script Started"

while true
do
	echo "Running..."
	sleep 2
done

