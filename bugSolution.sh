#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create two files
touch file1.txt
touch file2.txt

# Use flock to acquire a lock on the file before writing
function write_to_file() {
  local process_name="$1"
  while true; do
    flock -n -x <(echo "Process $process_name") || continue
    echo "$process_name" >> file1.txt
    sleep 1
    flock -u <(echo "Process $process_name")
  done
}

# Run two processes concurrently
write_to_file "1" &
write_to_file "2" &

# Wait for a few seconds
sleep 5

# Kill the processes
killall write_to_file

# Check the contents of the file (the output should be more predictable)
cat file1.txt