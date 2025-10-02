#!/usr/bin/env bash

# This script is designed to be run by the .desktop file.
# It ensures we are in the correct directory, starts the server,
# and opens the web browser.

# --- Get the absolute path of the directory where this script is located ---
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# --- Change to the script's directory ---
# This is crucial so that 'run_conda.sh' and 'app.py' can be found.
cd "$SCRIPT_DIR"

echo "Starting Flood Monitoring Dashboard..."
echo "Log file will be created at: $SCRIPT_DIR/dashboard.log"

# --- Run your main conda script in the background using its FULL PATH ---
# The '&' at the end makes it run in the background.
# 'nohup' ensures it keeps running even if you close the terminal.
# We redirect output to a log file so you can check for errors.
nohup bash "$SCRIPT_DIR/run.sh" > "$SCRIPT_DIR/dashboard.log" 2>&1 &

# Get the Process ID (PID) of the background job
SERVER_PID=$!
echo "Server process started with PID: $SERVER_PID"

echo "Server is starting... waiting a few seconds before opening browser."

# --- Wait for the server to initialize ---
sleep 8 # Increased wait time slightly for slower systems

# --- Open the web browser to the Streamlit app ---
# xdg-open is the standard command to open files/URLs on Linux
xdg-open http://127.0.0.1:8501

echo "Launch command issued. Check dashboard.log for server status."
exit 0

