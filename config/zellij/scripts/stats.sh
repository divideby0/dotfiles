#!/usr/bin/env bash
# System stats for zjstatus
# Usage: stats.sh [cpu|mem|disk|net|batt]

case "$1" in
    cpu)
        top -l 1 -n 0 2>/dev/null | awk '/CPU usage/ {printf "%.0f", $3}'
        ;;
    mem)
        ps -A -o %mem 2>/dev/null | awk '{s+=$1} END {printf "%.0f", s}'
        ;;
    disk)
        df -h / 2>/dev/null | awk 'NR==2 {gsub(/%/,""); print $5}'
        ;;
    net)
        # Show primary interface RX bytes in human-readable form
        netstat -ib 2>/dev/null | awk '/en0.*Link/ {
            bytes=$7
            if (bytes > 1073741824) printf "%.1fG", bytes/1073741824
            else if (bytes > 1048576) printf "%.0fM", bytes/1048576
            else if (bytes > 1024) printf "%.0fK", bytes/1024
            else print bytes"B"
        }'
        ;;
    batt)
        pmset -g batt 2>/dev/null | grep -Eo '[0-9]+%' | head -1 | tr -d '%'
        ;;
    *)
        echo "Usage: $0 [cpu|mem|disk|net|batt]"
        exit 1
        ;;
esac
