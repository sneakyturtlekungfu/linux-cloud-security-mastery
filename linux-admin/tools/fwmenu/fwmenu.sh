#!/usr/bin/env bash
# fwmenu.sh — Interactive firewalld menu for RHEL-based systems
# Color UI using simple ANSI escape sequences.

FWCMD="sudo firewall-cmd"
SYSCMD="sudo systemctl"

# --------------------------------------------------------------------
# Color UI (ANSI)
# --------------------------------------------------------------------

COLOR_RESET="\033[0m"
COLOR_BOLD="\033[1m"
COLOR_DIM="\033[2m"

COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_BLUE="\033[34m"
COLOR_MAGENTA="\033[35m"
COLOR_CYAN="\033[36m"
COLOR_WHITE="\033[37m"

title_bar() {
    local text="$1"
    printf "\n${COLOR_BOLD}${COLOR_CYAN}%s${COLOR_RESET}\n" "$text"
    printf "${COLOR_DIM}%s${COLOR_RESET}\n" "$(printf '%.0s=' $(seq 1 ${#text}))"
}

menu_option() {
    local key="$1"
    local label="$2"
    printf "  ${COLOR_GREEN}[%s]${COLOR_RESET} %s\n" "$key" "$label"
}

warning_text() {
    printf "\n${COLOR_BOLD}${COLOR_RED}%s${COLOR_RESET}\n" "$1"
}

info_text() {
    printf "\n${COLOR_DIM}%s${COLOR_RESET}\n" "$1"
}

pause() {
    read -rp "Press Enter to continue..."
}

check_firewalld() {
    if ! command -v firewall-cmd >/dev/null 2>&1; then
        warning_text "firewall-cmd not found. Is firewalld installed?"
        exit 1
    fi
}

# --------------------------------------------------------------------
# MENU: Status & Information
# --------------------------------------------------------------------
status_info_menu() {
    while true; do
        clear
        title_bar "Firewalld: Status & Information"

        menu_option 1 "Show firewalld state"
        menu_option 2 "Show firewalld systemd status"
        menu_option 3 "Show firewalld version"
        menu_option 4 "Show default zone"
        menu_option 5 "Show all zones"
        menu_option 6 "Show active zone details"
        menu_option 0 "Back to main menu"

        printf "\n"
        read -rp "Choose an option: " opt
        printf "\n"

        case "$opt" in
            1) $FWCMD --state; pause;;
            2) $SYSCMD status firewalld; pause;;
            3) $FWCMD --version; pause;;
            4) $FWCMD --get-default-zone; pause;;
            5) $FWCMD --get-zones; pause;;
            6) $FWCMD --get-active-zones; pause;;
            0) return;;
            *) warning_text "Invalid option.";;
        esac
    done
}

# --------------------------------------------------------------------
# MENU: Zones & Interfaces
# --------------------------------------------------------------------
zones_menu() {
    while true; do
        clear
        title_bar "Firewalld: Zones & Interfaces"

        menu_option 1 "List all zones with details (runtime)"
        menu_option 2 "Show active zone details"
        menu_option 3 "Show public zone details"
        menu_option 4 "Change default zone"
        menu_option 5 "Attach interface to zone"
        menu_option 0 "Back to main menu"

        printf "\n"
        read -rp "Choose an option: " opt
        printf "\n"

        case "$opt" in
            1) $FWCMD --list-all-zones; pause;;
            2) $FWCMD --get-active-zones; pause;;
            3) $FWCMD --zone=public --list-all; pause;;
            4)
                read -rp "Enter new default zone: " zone
                printf "\n"
                $FWCMD --set-default-zone="$zone"
                pause
                ;;
            5)
                read -rp "Interface (e.g. enp0s3): " iface
                read -rp "Zone (e.g. public): " zone
                printf "\n"
                $FWCMD --zone="$zone" --change-interface="$iface"
                pause
                ;;
            0) return;;
            *) warning_text "Invalid option.";;
        esac
    done
}

# --------------------------------------------------------------------
# MENU: Services & Ports
# --------------------------------------------------------------------
services_menu() {
    while true; do
        clear
        title_bar "Firewalld: Services & Ports"

        menu_option 1 "List active services"
        menu_option 2 "Enable a service (permanent)"
        menu_option 3 "Disable a service (permanent)"
        menu_option 4 "Open a port (permanent)"
        menu_option 5 "Close a port (permanent)"
        menu_option 0 "Back to main menu"

        printf "\n"
        read -rp "Choose an option: " opt
        printf "\n"

        case "$opt" in
            1) $FWCMD --list-services; pause;;
            2)
                read -rp "Service name (e.g. ssh, https): " svc
                printf "\n"
                $FWCMD --permanent --add-service="$svc"
                pause
                ;;
            3)
                read -rp "Service name (e.g. ssh, https): " svc
                printf "\n"
                $FWCMD --permanent --remove-service="$svc"
                pause
                ;;
            4)
                read -rp "Port/protocol (e.g. 8080/tcp): " port
                printf "\n"
                $FWCMD --permanent --add-port="$port"
                pause
                ;;
            5)
                read -rp "Port/protocol (e.g. 8080/tcp): " port
                printf "\n"
                $FWCMD --permanent --remove-port="$port"
                pause
                ;;
            0) return;;
            *) warning_text "Invalid option.";;
        esac
    done
}

# --------------------------------------------------------------------
# MENU: Rich Rules
# --------------------------------------------------------------------
rich_rules_menu() {
    while true; do
        clear
        title_bar "Firewalld: Rich Rules"

        menu_option 1 "List rich rules"
        menu_option 2 "Add allow rule (source → service)"
        menu_option 3 "Add deny rule (source → service)"
        menu_option 4 "Remove rule (paste full rule)"
        menu_option 0 "Back to main menu"

        printf "\n"
        read -rp "Choose: " opt
        printf "\n"

        case "$opt" in
            1) $FWCMD --list-rich-rules; pause;;
            2)
                read -rp "Source CIDR (e.g. 10.0.0.0/24): " src
                read -rp "Service name (e.g. ssh): " svc
                printf "\n"
                $FWCMD --add-rich-rule="rule family='ipv4' source address='$src' service name='$svc' accept"
                pause
                ;;
            3)
                read -rp "Source CIDR (e.g. 0.0.0.0/0): " src
                read -rp "Service name (e.g. ssh): " svc
                printf "\n"
                $FWCMD --add-rich-rule="rule family='ipv4' source address='$src' service name='$svc' reject"
                pause
                ;;
            4)
                info_text "Tip: you can copy a rule from 'List rich rules' and paste it here."
                read -rp "Full rich rule to remove: " rule
                printf "\n"
                $FWCMD --remove-rich-rule="$rule"
                pause
                ;;
            0) return;;
            *) warning_text "Invalid option.";;
        esac
    done
}

# --------------------------------------------------------------------
# MENU: Security & Hardening
# --------------------------------------------------------------------
security_menu() {
    while true; do
        clear
        title_bar "Firewalld: Security & Hardening"

        menu_option 1 "Enable panic mode (drop ALL traffic)"
        menu_option 2 "Disable panic mode"
        menu_option 3 "Enable lockdown mode"
        menu_option 4 "Disable lockdown mode"
        menu_option 5 "Validate config (--check-config)"
        menu_option 6 "Save runtime config as permanent"
        menu_option 0 "Back to main menu"

        printf "\n"
        read -rp "Choose: " opt
        printf "\n"

        case "$opt" in
            1)
                warning_text "WARNING: Panic mode drops ALL traffic to and from this host."
                read -rp "Type YES to continue: " confirm
                if [[ "$confirm" == "YES" ]]; then
                    $FWCMD --panic-on
                else
                    info_text "Panic mode not enabled."
                fi
                pause
                ;;
            2) $FWCMD --panic-off; pause;;
            3) $FWCMD --lockdown-on; pause;;
            4) $FWCMD --lockdown-off; pause;;
            5) $FWCMD --check-config; pause;;
            6) $FWCMD --runtime-to-permanent; pause;;
            0) return;;
            *) warning_text "Invalid option.";;
        esac
    done
}

# --------------------------------------------------------------------
# MENU: NAT / Masquerading
# --------------------------------------------------------------------
nat_menu() {
    while true; do
        clear
        title_bar "Firewalld: NAT / Masquerading"

        menu_option 1 "Enable masquerading (permanent)"
        menu_option 2 "Disable masquerading (permanent)"
        menu_option 0 "Back to main menu"

        printf "\n"
        read -rp "Choose: " opt
        printf "\n"

        case "$opt" in
            1) $FWCMD --permanent --add-masquerade; pause;;
            2) $FWCMD --permanent --remove-masquerade; pause;;
            0) return;;
            *) warning_text "Invalid option.";;
        esac
    done
}

# --------------------------------------------------------------------
# MAIN MENU
# --------------------------------------------------------------------
main_menu() {
    check_firewalld

    while true; do
        clear
        title_bar "=== Firewalld Admin Menu ==="

        menu_option 1 "Status & Information"
        menu_option 2 "Zones & Interfaces"
        menu_option 3 "Services & Ports"
        menu_option 4 "Rich Rules"
        menu_option 5 "Security & Hardening"
        menu_option 6 "NAT / Masquerading"
        menu_option 0 "Exit"

        printf "\n"
        read -rp "Choose an option: " opt
        printf "\n"

        case "$opt" in
            1) status_info_menu;;
            2) zones_menu;;
            3) services_menu;;
            4) rich_rules_menu;;
            5) security_menu;;
            6) nat_menu;;
            0) clear; exit 0;;
            *) warning_text "Invalid option.";;
        esac
    done
}

main_menu
