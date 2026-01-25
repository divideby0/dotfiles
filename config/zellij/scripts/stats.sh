#!/usr/bin/env bash
# System stats for zjstatus - cross-platform (macOS/Linux)
# Usage: stats.sh [cpu|mem|disk|batt]

OS="$(uname -s)"

case "$1" in
    cpu)
        if [[ "$OS" == "Darwin" ]]; then
            top -l 1 -n 0 2>/dev/null | awk '/CPU usage/ {printf "%.0f", $3}'
        else
            # Linux: use /proc/stat
            grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}'
        fi
        ;;
    mem)
        if [[ "$OS" == "Darwin" ]]; then
            ps -A -o %mem 2>/dev/null | awk '{s+=$1} END {printf "%.0f", s}'
        else
            # Linux: use free
            free | awk '/Mem:/ {printf "%.0f", $3/$2*100}'
        fi
        ;;
    disk)
        df -h / 2>/dev/null | awk 'NR==2 {gsub(/%/,""); print $5}'
        ;;
    batt)
        if [[ "$OS" == "Darwin" ]]; then
            pmset -g batt 2>/dev/null | grep -Eo '[0-9]+%' | head -1 | tr -d '%'
        else
            # Linux: check /sys/class/power_supply
            if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
                cat /sys/class/power_supply/BAT0/capacity
            elif [[ -f /sys/class/power_supply/BAT1/capacity ]]; then
                cat /sys/class/power_supply/BAT1/capacity
            else
                echo "–"  # No battery
            fi
        fi
        ;;
    *)
        echo "Usage: $0 [cpu|mem|disk|batt]"
        exit 1
        ;;
esac
