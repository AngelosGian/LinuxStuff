#!/usr/bin/env expect

# Set timeout for expect
set timeout -1

# Start the nala fetch process
spawn nala fetch

# Define the expected prompt and the response
expect "Mirrors you want to keep, separated by space or comma (1..16):"
send "1 2 3\r"

# Allow the process to complete
expect eof
