#!/bin/bash

#For loop
for i in {1..5}; do
	echo "Number: $i"
done

#While loop
count=5
while [ $count -gt 0 ]; do
	echo "Countdown: $count"
	count=$((count-1))
done

#Monitor a cpu until it stops
iteration=1
while pgrep ssh > /dev/null && [ $iteration -le 3 ]; do
	echo "Monitoring ssh: is still running.. (Check $iteration)"
	sleep 2
	iteration=$((iteration+1))
done
echo "Monitoring complete"
