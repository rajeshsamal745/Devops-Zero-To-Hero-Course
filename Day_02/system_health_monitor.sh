#!/bin/bash

# Variables
threshold=80
service=$1
disk=$2

# Functions
check_service() {
	if systemctl is-active --quiet "$service"; then
		echo "$service is running"
	else
		echo "$service is stopped"
	fi
}

check_disk() {
	usage=$(df -h "$disk" | awk 'NR==2 {print $5}' | tr -d '%')
	if [ "$usage" -gt "$threshold" ]; then
		echo "Disk $disk usage high: $usage%"
	else
		echo "Disk $disk usage normal: $usage%"
	fi
}

# Loop for continuous monitoring
while true; do
	echo "-----System Health Check-----"
	check_service
	check_disk
	sleep 10
done
