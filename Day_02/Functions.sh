#!/bin/bash

#Greeting function
greet() {
echo "Hello $1"
}

#Function to add numbers
add() {
echo "Addition of $1 and $2 is: $(($1 +$2))"
}

#Function to check disk usage
disk_usage() {
  usage=$(df -h | grep "$1" | awk '{print $5}')
  echo "Disk usage $1: $usage"
} 

#Calling the function
greet Rajesh
add 10 15
disk_usage "/"
