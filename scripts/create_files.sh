
#!/bin/bash

# Stop the script if a command fails
set -e

# Set the main directory
BASE_DIR="$HOME/Desktop/task-automation/workspace"

# Generate a timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Create directories
mkdir -p "$BASE_DIR/logs"
mkdir -p "$BASE_DIR/reports"
mkdir -p "$BASE_DIR/backups"

echo "Directories created successfully."

# Check if report.txt already exists
if [ ! -f "$BASE_DIR/reports/report.txt" ]; then
    touch "$BASE_DIR/reports/report.txt"
    echo "This is my first Bash automation report." > "$BASE_DIR/reports/report.txt"
    echo "Report file created successfully."
else
    echo "Report file already exists."
fi

# Create a timestamped log file
LOG_FILE="$BASE_DIR/logs/log_$TIMESTAMP.txt"

if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
    echo "Automation executed at $(date)" > "$LOG_FILE"
fi

echo "Log file: $LOG_FILE"
echo "Task 1 completed successfully."
