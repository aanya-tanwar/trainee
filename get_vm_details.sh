#!/bin/bash

################################################################################
# VM Details Collection Script
# This script collects various system and VM information
################################################################################

echo "========================================"
echo "    VM DETAILS COLLECTION REPORT"
echo "========================================"
echo ""
echo "Generated on: $(date)"
echo ""

# System Information
echo "========================================"
echo "1. SYSTEM INFORMATION"
echo "========================================"
echo "Hostname: $(hostname)"
echo "Operating System: $(uname -s)"
echo "Kernel Version: $(uname -r)"
echo "Architecture: $(uname -m)"
if [ -f /etc/os-release ]; then
    echo "OS Details:"
    grep -E "^(NAME|VERSION)=" /etc/os-release | sed 's/^/  /'
fi
echo ""

# CPU Information
echo "========================================"
echo "2. CPU INFORMATION"
echo "========================================"
if [ -f /proc/cpuinfo ]; then
    CPU_MODEL=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)
    CPU_CORES=$(grep -c "^processor" /proc/cpuinfo)
    echo "CPU Model: $CPU_MODEL"
    echo "CPU Cores: $CPU_CORES"
else
    echo "CPU information not available"
fi
echo ""

# Memory Information
echo "========================================"
echo "3. MEMORY INFORMATION"
echo "========================================"
if command -v free &> /dev/null; then
    free -h
else
    echo "Memory information not available"
fi
echo ""

# Disk Usage Information
echo "========================================"
echo "4. DISK USAGE INFORMATION"
echo "========================================"
if command -v df &> /dev/null; then
    df -h | grep -E "^Filesystem|^/dev/"
else
    echo "Disk usage information not available"
fi
echo ""

# Network Information
echo "========================================"
echo "5. NETWORK INFORMATION"
echo "========================================"
echo "Network Interfaces:"
if command -v ip &> /dev/null; then
    ip -brief addr show | sed 's/^/  /'
elif command -v ifconfig &> /dev/null; then
    ifconfig | grep -E "^[a-z]|inet " | sed 's/^/  /'
else
    echo "  Network information not available"
fi
echo ""

# System Uptime
echo "========================================"
echo "6. SYSTEM UPTIME"
echo "========================================"
if command -v uptime &> /dev/null; then
    uptime
else
    echo "Uptime information not available"
fi
echo ""

# Process Information
echo "========================================"
echo "7. PROCESS INFORMATION"
echo "========================================"
if [ -d /proc ]; then
    PROCESS_COUNT=$(ls -d /proc/[0-9]* 2>/dev/null | wc -l)
    echo "Total Running Processes: $PROCESS_COUNT"
else
    echo "Process information not available"
fi
echo ""

# User Information
echo "========================================"
echo "8. USER INFORMATION"
echo "========================================"
echo "Current User: $(whoami)"
echo "User ID: $(id -u)"
echo "Group ID: $(id -g)"
if command -v who &> /dev/null; then
    echo "Logged in Users:"
    who | sed 's/^/  /'
fi
echo ""

# Load Average
echo "========================================"
echo "9. LOAD AVERAGE"
echo "========================================"
if [ -f /proc/loadavg ]; then
    echo "Load Average: $(awk '{print $1, $2, $3}' /proc/loadavg)"
else
    echo "Load average information not available"
fi
echo ""

# Docker Information (if applicable)
echo "========================================"
echo "10. DOCKER INFORMATION (if available)"
echo "========================================"
if command -v docker &> /dev/null; then
    echo "Docker Version:"
    docker --version
    echo ""
    echo "Running Containers:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" 2>/dev/null || echo "  Unable to connect to Docker daemon"
else
    echo "Docker is not installed"
fi
echo ""

echo "========================================"
echo "    END OF VM DETAILS REPORT"
echo "========================================"
