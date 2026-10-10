
#!/bin/bash

# Stop on unset variables and pipeline failures
set -uo pipefail

# Find the directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load our reusable functions
source "$SCRIPT_DIR/functions.sh"

# Set monitoring thresholds
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80

log_message "Starting system health checks..."

# Track overall monitoring status
STATUS=0

if ! check_disk "$DISK_THRESHOLD"; then
    STATUS=1
fi

if ! check_memory "$MEMORY_THRESHOLD"; then
    STATUS=1
fi

if [ "$STATUS" -eq 0 ]; then
    log_message "All system health checks passed."
else
    log_message "One or more health checks reported a problem."
fi

exit "$STATUS"
