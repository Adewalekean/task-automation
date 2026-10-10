
#!/bin/bash

# Stop on errors, unset variables and failed pipelines
set -e
set -u
set -o pipefail

# Handle interruptions
cleanup() {
    echo ""
    echo "Script interrupted. Cleaning up..."
    exit 130
}

trap cleanup INT

# Check if a directory path was provided
if [ "$#" -ne 1 ]; then
    echo "ERROR: Please provide one directory path."
    echo "Usage: $0 <directory>"
    exit 1
fi

# Store the directory path
TARGET_DIR="$1"

# Reject empty paths
if [ -z "$TARGET_DIR" ]; then
    echo "ERROR: Directory path cannot be empty."
    exit 1
fi

# Create directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
    echo "Directory created: $TARGET_DIR"
else
    echo "Directory already exists: $TARGET_DIR"
fi

# Create a file without overwriting existing content
FILE="$TARGET_DIR/automation.txt"

if [ ! -e "$FILE" ]; then
    echo "Safe automation completed at $(date)" > "$FILE"
    echo "File created successfully."
else
    echo "File already exists. No changes made."
fi

echo "Automation completed successfully."
