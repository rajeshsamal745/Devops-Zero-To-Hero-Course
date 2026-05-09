#!/bin/bash

LOGFILE="all_in_one.log"

echo "=== Starting Combined Script ===" | tee -a $LOGFILE

# 1. Create a file
FILE="demo.txt"
touch "$FILE"
echo "File $FILE created." | tee -a $LOGFILE

# 2. List files and folders
echo "Listing files:" | tee -a $LOGFILE
ls -lh | tee -a $LOGFILE

# 3. man command (sample usage)
echo "Showing first 10 lines of 'ls' manual:" | tee -a $LOGFILE
man ls | head -10 | tee -a $LOGFILE

# 4. Write a file (vim equivalent)
echo "Hello World" > demo.txt
echo "Written content to demo.txt" | tee -a $LOGFILE

# 5. Difference between touch and vim
touch empty.txt
echo "This file has content" > content.txt
echo "Touch vs vim demo done." | tee -a $LOGFILE

# 6. Copy content
cp content.txt copy_content.txt
echo "Copied content.txt to copy_content.txt" | tee -a $LOGFILE

# 7. Shebang purpose
echo "This script runs with bash interpreter." | tee -a $LOGFILE

# 8. Shell differences
echo "Current shell: $SHELL" | tee -a $LOGFILE


# 7. Shebang purpose
echo "This script runs with bash interpreter." | tee -a $LOGFILE

# 8. Shell differences
echo "Current shell: $SHELL" | tee -a $LOGFILE

# 9. echo command
echo "welcome to devops automation" | tee -a $LOGFILE

# 10. Execute a script (self demonstration)
chmod +x "$0"
echo "Script is executable." | tee -a $LOGFILE

# 11. Grant Permission
chmod 777 demo.txt
ls -l demo.txt | tee -a $LOGFILE

# 12. History of commands
echo "Recent Commands:" | tee -a $LOGFILE
history | tail -5 | tee -a $LOGFILE

