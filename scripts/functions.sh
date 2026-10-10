
#!/bin/bash

# Reusable logging function
log_message() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message"
}

# Check disk usage
check_disk() {
    local threshold="$1"
    local usage

    usage=$(df -P / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

    if [ -z "$usage" ]; then
        log_message "ERROR: Could not retrieve disk usage."
        return 1
    fi

    log_message "Disk usage: $usage%"

    if [ "$usage" -ge "$threshold" ]; then
        log_message "WARNING: Disk usage is high!"
        return 1
    fi

    log_message "Disk usage is within the safe limit."
    return 0
}

# Check memory pressure on macOS
check_memory() {
    local threshold="$1"
    local free_memory
    local usage

    free_memory=$(memory_pressure | awk '/System-wide memory free percentage/ {gsub(/%/, "", $NF); print $NF}')

    if [ -z "$free_memory" ]; then
        log_message "ERROR: Could not retrieve memory information."
        return 1
    fi

    usage=$((100 - free_memory))

    log_message "Estimated memory pressure: $usage%"

    if [ "$usage" -ge "$threshold" ]; then
        log_message "WARNING: Memory pressure is high!"
        return 1
    fi

    log_message "Memory pressure is within the safe limit."
    return 0
}
