#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Run two processes concurrently that write to the same file
pid1=$(bash -c 'while true; do echo "Process 1" >> file1.txt; sleep 1; done & echo $!')
pid2=$(bash -c 'while true; do echo "Process 2" >> file1.txt; sleep 1; done & echo $!')

# Wait for a few seconds
sleep 5

# Kill the processes
kill $pid1
kill $pid2

# Check the contents of the file (the output will be unpredictable due to the race condition)
cat file1.txt