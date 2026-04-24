#!/usr/bin/env bash
# common.sh - Shared utilities and functions for system-tools
# Provides reusable functions to avoid code duplication across scripts

set -o pipefail

# Ensure sudo access (ask once at the beginning)
ensure_sudo() {
    if ! sudo -n true 2>/dev/null; then
        sudo true
    fi
}

# Format bytes into human-readable format (B, KB, MB, GB)
format_size() {
    local bytes=$1
    numfmt --to=iec-i --suffix=B "$bytes" 2>/dev/null || printf "%dB" "$bytes"
}

# Format bytes per second for network/disk I/O
format_rate() {
    local bytes=$1
    if [ "$bytes" -gt 1073741824 ]; then
        printf "%dGB/s" "$((bytes / 1073741824))"
    elif [ "$bytes" -gt 1048576 ]; then
        printf "%dMB/s" "$((bytes / 1048576))"
    elif [ "$bytes" -gt 1024 ]; then
        printf "%dKB/s" "$((bytes / 1024))"
    else
        printf "%dB/s" "$bytes"
    fi
}

# Safely get APT package count
get_apt_count() {
    dpkg -l 2>/dev/null | grep -c "^ii" || echo 0
}

# Safely get Snap package count
get_snap_count() {
    snap list 2>/dev/null | tail -n +2 | grep -c . || echo 0
}

# Safely get APT upgradable packages
get_apt_upgradable() {
    apt list --upgradable 2>/dev/null | tail -n +2 | grep -c . || echo 0
}

# Safely get Snap upgradable packages
get_snap_upgradable() {
    snap refresh --list 2>/dev/null | tail -n +2 | grep -c . || echo 0
}

# Safely get firmware update count
get_firmware_updates() {
    if ! command -v fwupdmgr >/dev/null 2>&1; then
        echo "unavailable"
        return
    fi
    
    if fwupdmgr get-updates 2>/dev/null | grep -q "firmware updates available"; then
        fwupdmgr get-updates 2>/dev/null | grep -c "^•" || echo 0
    else
        echo "0"
    fi
}

# Get uptime in a portable way
get_uptime() {
    uptime -p 2>/dev/null || uptime | sed 's/.*up //' | sed 's/,.*$//'
}

# Safely get memory usage percentage
get_memory_usage() {
    free -b 2>/dev/null | awk 'NR==2 {printf "%.1f", ($3/$2)*100}' || echo "N/A"
}

# Safely parse disk statistics (accumulates all disks)
get_disk_io() {
    local read_count=0
    local write_count=0
    while read -r _ _ _ _ _ _ _ _ _ _ _ _ _ reads _ writes _; do
        read_count=$((read_count + reads))
        write_count=$((write_count + writes))
    done < /proc/diskstats
    printf "%s %s" "$read_count" "$write_count"
}

# Safely parse network statistics (skips loopback)
get_network_io() {
    local rx=0
    local tx=0
    while read -r line; do
        [[ $line =~ ^[[:space:]]*$ ]] && continue
        [[ $line =~ Inter- ]] && continue
        [[ $line =~ face ]] && continue
        
        local iface
        iface=$(echo "$line" | awk -F: '{print $1}' | sed 's/^[[:space:]]*//')
        [ "$iface" = "lo" ] && continue
        
        local line_rx line_tx
        line_rx=$(echo "$line" | awk '{print $2}')
        line_tx=$(echo "$line" | awk '{print $10}')
        
        rx=$((rx + line_rx))
        tx=$((tx + line_tx))
    done < /proc/net/dev
    printf "%s %s" "$rx" "$tx"
}

# Get CPU usage percentage
get_cpu_usage() {
    top -bn1 2>/dev/null | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf "%.0f", 100 - $1}' || echo "N/A"
}

# Singular/plural helper
pluralize() {
    local count=$1
    local singular=$2
    local plural=${3:-"${singular}s"}
    
    if [ "$count" -eq 1 ]; then
        echo "$singular"
    else
        echo "$plural"
    fi
}

# Format count with singular/plural
format_count() {
    local count=$1
    local item=$2
    local plural=${3:-"${item}s"}
    
    printf "%d %s" "$count" "$(pluralize "$count" "$item" "$plural")"
}

# Get directory size safely
get_dir_size() {
    local path=$1
    if [ -d "$path" ]; then
        du -sb "$path" 2>/dev/null | awk '{print $1}' || echo 0
    else
        echo 0
    fi
}

# Get orphaned package count
get_orphaned_packages() {
    apt autoremove -s 2>/dev/null | grep "^Remov" | wc -l | tr -d ' ' || echo 0
}

export -f format_size format_rate get_apt_count get_snap_count get_apt_upgradable
export -f get_snap_upgradable get_firmware_updates get_uptime get_memory_usage
export -f get_disk_io get_network_io get_cpu_usage pluralize format_count get_dir_size
export -f get_orphaned_packages ensure_sudo
