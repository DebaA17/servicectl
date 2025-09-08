#!/bin/bash

# servicectl.sh - A simple Bash CLI to manage systemd services

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

VERSION="1.0.0"

usage() {
    echo -e "${YELLOW}servicectl - systemd service manager${NC}"
    echo -e "\nUsage:"
    echo "  servicectl list"
    echo "  servicectl status <service>"
    echo "  servicectl start <service>"
    echo "  servicectl stop <service>"
    echo "  servicectl restart <service>"
    echo "  servicectl enable <service>"
    echo "  servicectl disable <service>"
    echo "  servicectl failed"
    echo "  servicectl --help"
    echo "  servicectl --version"
    echo -e "\nOptions:"
    echo "  --help       Show this help message"
    echo "  --version    Show version information"
    exit 0
}

check_service_name() {
    if [[ -z "$2" ]]; then
        echo -e "${RED}Error: Service name required.${NC}"
        usage
    fi
}

list_services() {
    echo -e "${YELLOW}🔧 Active Services:${NC}"
    echo "----------------------------------------"
    systemctl list-units --type=service --state=running | awk 'NR>1 && NF {print "✓ " $1 "\t(" $4 ")"}'
}

show_status() {
    check_service_name "$@"
    service=$2
    echo -e "${YELLOW}Status of $service:${NC}"
    systemctl status "$service"
}

start_service() {
    check_service_name "$@"
    sudo systemctl start "$2" && echo -e "${GREEN}[✓]${NC} $2 started." || echo -e "${RED}[✗] Failed to start $2${NC}"
}

stop_service() {
    check_service_name "$@"
    sudo systemctl stop "$2" && echo -e "${GREEN}[✓]${NC} $2 stopped." || echo -e "${RED}[✗] Failed to stop $2${NC}"
}

restart_service() {
    check_service_name "$@"
    sudo systemctl restart "$2" && echo -e "${GREEN}[✓]${NC} $2 restarted." || echo -e "${RED}[✗] Failed to restart $2${NC}"
}

enable_service() {
    check_service_name "$@"
    sudo systemctl enable "$2" && echo -e "${GREEN}[✓]${NC} $2 enabled on boot." || echo -e "${RED}[✗] Failed to enable $2${NC}"
}

disable_service() {
    check_service_name "$@"
    sudo systemctl disable "$2" && echo -e "${GREEN}[✓]${NC} $2 disabled from boot." || echo -e "${RED}[✗] Failed to disable $2${NC}"
}

list_failed() {
    echo -e "${RED}⚠️  Failed Services:${NC}"
    echo "----------------------------------------"
    systemctl --failed --type=service | awk 'NR>1 && NF {print "✗ " $1 "\t(" $4 ")"}'
}


case "$1" in
    list)
        list_services
        ;;
    status)
        show_status "$@"
        ;;
    start)
        start_service "$@"
        ;;
    stop)
        stop_service "$@"
        ;;
    restart)
        restart_service "$@"
        ;;
    enable)
        enable_service "$@"
        ;;
    disable)
        disable_service "$@"
        ;;
    failed)
        list_failed
        ;;
    --help|-h|help)
        usage
        ;;
    --version|-v|version)
        echo "servicectl version $VERSION"
        exit 0
        ;;
    *)
        usage
        ;;
esac

