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
url=https://raw.githubusercontent.com/rajeshsamal745/Devops-Zero-To-Hero-Course/main/Day_06/data/app.log
if curl -s "$url" | grep -qi "Error"; then
	echo "❌ Errors found! Displaying first 5 occurrences:"
	curl -s "$url" | grep -i "Error" | head -5
else
	echo "✅ No errors found in the remote log file."
fi

# 4. Numbers divisible by 3 and 5 but not 15
echo "[4] Numbers divisible by 3 & 5 but not 15:"
for i in {1..20}; do
	if (( (i % 3 == 0 || i % 5 == 0) && i % 15 != 0 )); then
		echo $i
	fi
done

# 5. Count 's' in Mississippi
echo "[5] Count of 's' in Mississippi:"
echo "Mississippi" | grep -o "s" | wc -l

# 6. Debugging a script
echo "[6] Debugging demo:"
set -x
echo "Debug mode enabled"
set +x

# 7. Crontab usage (example only)
echo "[7] Crontab example: schedule backup at midnight"
echo "0 0 * * * /usr/local/bin/backup.sh"

# 8. Open file in read-only mode
echo "[8] Open file in read-only mode (vim -R or view)"
echo "Command: vim -R project/data/app.log"

# 9. Soft vs Hard links
echo "[9] Creating hard and soft links:"
rm -f hardlink.log softlink.log
ln data/app.log hardlink.log
ln -s data/app.log softlink.log
ls -lh hardlink.log softlink.log

# 10. Break vs Continue
echo "[10] Break vs Continue demo:"
for i in {1..10}; do
	if [ $i -eq 5 ]; then
		continue
	fi
	if [ $i -eq 8 ]; then
		break
	fi
	echo $i
done

# 11. Disadvantages of shell scripting
echo "[11] Disadvantages: dynamic typing, runtime errors, portability issues"

# 12. Different kinds of loops
echo "[12] Loop demo:"
count=1
while [ $count -le 5 ]; do
	echo "Iteration: $count"
	((count++))
done

# 13. Bash typing
echo "[13] Bash is dynamically typed:"
x=10
x="string"
echo "Variable x is now: $x"

# 14. Networking troubleshooting tools
echo "[14] Networking tools demo:"
echo "Traceroute google.com"
echo "Tracepath github.com"

# 15. Sort names in a file
echo "[15] Sorting names:"
echo -e "Rajesh\nAbhishek\nZebra\nKing" > names.txt
sort names.txt

# 16. Manage huge logs with logrotate
echo "[16] Logrotate example config:"
cat <<EOF
/data/app.log {
  daily
  rotate 7
  compress
  missingok
}
EOF

echo "=== Interview Toolkit Completed ==="
