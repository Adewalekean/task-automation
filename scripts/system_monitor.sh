
#!/bin/bash

# Task 2: System Health Monitor

echo "================================"
echo "       SYSTEM HEALTH REPORT"
echo "================================"

# Display current date and time
echo "Date: $(date)"

# Display system hostname
echo "Hostname: $(hostname)"

# Check disk usage
echo ""
echo "----- DISK USAGE -----"
df -h /

# Set disk usage threshold
DISK_THRESHOLD=80

# Get disk usage percentage
DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

echo "Current disk usage: $DISK_USAGE%"

# Compare usage against threshold
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "WARNING: Disk usage is above the threshold!"
else
    echo "OK: Disk usage is within the safe limit."
fi

# Check memory information on macOS
echo ""
echo "----- MEMORY INFORMATION -----"
memory_pressure | tail -n 5


# Set memory threshold
MEMORY_THRESHOLD=80

# Get free memory percentage
FREE_MEMORY=$(memory_pressure | awk '/System-wide memory free percentage/ {gsub(/%/, "", $NF); print $NF}')

# Check if memory information was retrieved
if [ -z "$FREE_MEMORY" ]; then
    echo "ERROR: Unable to retrieve memory information."
else
    # Calculate estimated memory pressure
    MEMORY_USAGE=$((100 - FREE_MEMORY))

    echo "System-wide free memory: $FREE_MEMORY%"
    echo "Estimated memory pressure: $MEMORY_USAGE%"

    if [ "$MEMORY_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
        echo "WARNING: Memory pressure is high!"
    else
        echo "OK: Memory pressure is within the safe limit."
    fi
fi


# Display the top 5 processes by CPU usage
echo ""
echo "----- TOP 5 CPU PROCESSES -----"
ps -A -o pid,%cpu,comm -r | head -n 6

echo ""

# Check whether the hostname command succeeds
echo ""
echo "----- COMMAND STATUS CHECK -----"

hostname > /dev/null
STATUS=$?

if [ "$STATUS" -eq 0 ]; then
    echo "SUCCESS: Hostname command executed successfully."
else
    echo "ERROR: Hostname command failed."
    exit 1
fi

echo ""
echo "System health check completed successfully."
exit 0

