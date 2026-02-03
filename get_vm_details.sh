#!/bin/bash

################################################################################
# Script Name: get_vm_details.sh
# Description: Retrieves and displays detailed information about the VM
# Author: Auto-generated
# Date: 2026-02-03
################################################################################

# Color codes for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# Function to print key-value pairs
print_info() {
    echo -e "${YELLOW}$1:${NC} $2"
}

# Main script starts here
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     VM DETAILS INFORMATION SCRIPT     ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"

# 1. HOSTNAME INFORMATION
print_header "HOSTNAME INFORMATION"
HOSTNAME=$(hostname)
FQDN=$(hostname -f 2>/dev/null || echo "N/A")
print_info "Hostname" "$HOSTNAME"
print_info "FQDN" "$FQDN"

# 2. OPERATING SYSTEM INFORMATION
print_header "OPERATING SYSTEM INFORMATION"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    print_info "OS Name" "$NAME"
    print_info "OS Version" "$VERSION"
    print_info "OS ID" "$ID"
    print_info "Version ID" "$VERSION_ID"
else
    print_info "OS" "$(uname -s)"
fi
print_info "Kernel Version" "$(uname -r)"
print_info "Architecture" "$(uname -m)"

# 3. CPU INFORMATION
print_header "CPU INFORMATION"
if command -v lscpu &> /dev/null; then
    CPU_MODEL=$(lscpu | grep "Model name" | cut -d ':' -f2 | xargs)
    CPU_CORES=$(lscpu | grep "^CPU(s):" | cut -d ':' -f2 | xargs)
    CPU_THREADS=$(lscpu | grep "Thread(s) per core" | cut -d ':' -f2 | xargs)
    print_info "CPU Model" "$CPU_MODEL"
    print_info "CPU Cores" "$CPU_CORES"
    print_info "Threads per Core" "$CPU_THREADS"
else
    CPU_INFO=$(grep -m1 "model name" /proc/cpuinfo | cut -d ':' -f2 | xargs)
    CPU_COUNT=$(grep -c ^processor /proc/cpuinfo)
    print_info "CPU Model" "$CPU_INFO"
    print_info "CPU Count" "$CPU_COUNT"
fi

# 4. MEMORY INFORMATION
print_header "MEMORY INFORMATION"
if command -v free &> /dev/null; then
    TOTAL_MEM=$(free -h | grep Mem | awk '{print $2}')
    USED_MEM=$(free -h | grep Mem | awk '{print $3}')
    FREE_MEM=$(free -h | grep Mem | awk '{print $4}')
    AVAILABLE_MEM=$(free -h | grep Mem | awk '{print $7}')
    print_info "Total Memory" "$TOTAL_MEM"
    print_info "Used Memory" "$USED_MEM"
    print_info "Free Memory" "$FREE_MEM"
    print_info "Available Memory" "$AVAILABLE_MEM"
fi

# 5. DISK INFORMATION
print_header "DISK INFORMATION"
if command -v df &> /dev/null; then
    echo ""
    df -h | grep -E "^/dev/" | awk '{printf "%-20s %-10s %-10s %-10s %-10s\n", $1, $2, $3, $4, $5}'
    echo ""
    TOTAL_DISK=$(df -h --total | grep total | awk '{print $2}')
    USED_DISK=$(df -h --total | grep total | awk '{print $3}')
    FREE_DISK=$(df -h --total | grep total | grep total | awk '{print $4}')
    print_info "Total Disk Space" "$TOTAL_DISK"
    print_info "Used Disk Space" "$USED_DISK"
    print_info "Free Disk Space" "$FREE_DISK"
fi

# 6. NETWORK INFORMATION
print_header "NETWORK INFORMATION"
if command -v ip &> /dev/null; then
    # Get IP addresses
    IP_ADDRESSES=$(ip -4 addr show | grep inet | grep -v "127.0.0.1" | awk '{print $2}' | cut -d '/' -f1)
    if [ -n "$IP_ADDRESSES" ]; then
        print_info "IP Address(es)" ""
        echo "$IP_ADDRESSES" | while read -r ip; do
            echo "  - $ip"
        done
    fi
    
    # Get network interfaces
    INTERFACES=$(ip link show | grep -E "^[0-9]+" | awk -F: '{print $2}' | xargs)
    print_info "Network Interfaces" "$INTERFACES"
elif command -v ifconfig &> /dev/null; then
    IP_ADDRESSES=$(ifconfig | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}')
    if [ -n "$IP_ADDRESSES" ]; then
        print_info "IP Address(es)" ""
        echo "$IP_ADDRESSES" | while read -r ip; do
            echo "  - $ip"
        done
    fi
fi

# Check for public IP (if internet is available)
if command -v curl &> /dev/null; then
    PUBLIC_IP=$(curl -s --max-time 5 ifconfig.me 2>/dev/null || echo "N/A")
    print_info "Public IP" "$PUBLIC_IP"
fi

# 7. SYSTEM UPTIME
print_header "SYSTEM UPTIME"
if command -v uptime &> /dev/null; then
    UPTIME_INFO=$(uptime -p 2>/dev/null || uptime | awk -F'( |,|:)+' '{print $6,$7",",$8,"hours,",$9,"minutes."}')
    print_info "Uptime" "$UPTIME_INFO"
    LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}')
    print_info "Load Average" "$LOAD_AVG"
fi

# 8. SYSTEM DATE AND TIME
print_header "DATE AND TIME INFORMATION"
print_info "Current Date/Time" "$(date '+%Y-%m-%d %H:%M:%S %Z')"
print_info "Timezone" "$(timedatectl show --property=Timezone --value 2>/dev/null || date +%Z)"

# 9. LOGGED IN USERS
print_header "LOGGED IN USERS"
if command -v who &> /dev/null; then
    USERS=$(who | wc -l)
    print_info "Number of Users" "$USERS"
    if [ "$USERS" -gt 0 ]; then
        echo ""
        who
    fi
fi

# 10. VIRTUALIZATION TYPE (if applicable)
print_header "VIRTUALIZATION INFORMATION"
if command -v systemd-detect-virt &> /dev/null; then
    VIRT_TYPE=$(systemd-detect-virt 2>/dev/null || echo "none")
    print_info "Virtualization Type" "$VIRT_TYPE"
elif [ -f /sys/class/dmi/id/product_name ]; then
    PRODUCT_NAME=$(cat /sys/class/dmi/id/product_name)
    print_info "Product Name" "$PRODUCT_NAME"
fi

# End of script
echo -e "\n${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║        END OF VM DETAILS REPORT        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}\n"
