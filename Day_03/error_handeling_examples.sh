#!/bin/bash

# Error Handling Examples in Shell Scripting
echo "==== Example 1: File Existance Check ===="
# Before
echo "Before:"
cat myfile.txt
# After
echo "After:"
if [ -f "myfile.txt" ]; then
	cat myfile.txt
else
	echo "Error: myfile.txt not found"
fi

echo "==== Example 2: Division by Zero ===="
# Befor
num1=10
num2=0
# Before
echo "Before:"
echo $((num1/num2))
# After
echo "After:"
if [ "$num2" -eq 0 ]; then
	echo "Error: Division by zero"
else
	echo $((num1/num2))
fi

echo "==== Example 3: Command line failure ===="
# Before
echo "Before"
mkdir /root/testdir
# After
echo "After:"
mkdir /root/testdir 2>/dev/null
if [ $? -ne 0 ]; then
	echo "Error: Cannot create directory, permission denied"
fi

echo "===== Example 4: Network Connectivity ====="
# Before
echo "Before:"
ping -c 1 google.com
# After
echo "After:"
if ping -c 1 google.com &>/dev/null; then
	echo "Internet is avaiable"
else
	echo "Error: No Internet Connection"
fi

echo "===== Example 5: Service Monitoring ====="
# Before
echo "Before:"
systemctl status nginx
# After
echo "After:"
if systemctl is-active --quiet nginx; then
	echo "Nginx is running"
else
	echo "Error: Nginx not running"
fi
