#!/usr/bin/env bash
#
# fwmenu.sh - Interactive firewalld menu for RHEL-based systems
# Categories: Status, Zones, Services/Ports, Rich Rules, Security/Hardening, NAT
#

FWCMD="sudo firewall-cmd"
SYSCMD="sudo systemctl"

pause() {
    read -rp "Press Enter to continue..." _
}

check_firewalld() {
    if ! command -v firewall-cmd >/dev/null 2>&1; then
        echo "firewall-cmd not found. Is firewalld installed?"
        exit 1
    fi
}

# --- CATEGORY 1: STATUS & INFO ----------------------------------------------

menu_status() {
    while true; do
        clear
        echo "=== Firewalld: Status & Information ==="
        echo "1) Show firewalld state"
        echo "2) Show firewalld systemd status"
        echo "3) Show firewalld version"
        echo "4) Show default zone"
        echo "5) Show all zones"
        echo "6) Show active zone details"
        echo "0) Back to main menu"
        echo
        read -rp "Choose an option: " ans
        case "$ans" in
            1) $FWCMD --state; pause ;;
            2) $SYSCMD status firewalld; pause ;;
            3) $FWCMD --version; pause ;;
            4) $FWCMD --get-default-zone; pause ;;
            5) $FWCMD --get-zones; pause ;;
            6) $FWCMD --list-all; pause ;;
            0) break ;;
            *) echo "Invalid choice"; pause ;;
        esac
    done
}

# --- CATEGORY 2: ZONES & INTERFACES -----------------------------------------

menu_zones() {
    while true; do
        clear
        echo "=== Firewalld: Zones & Interfaces ==="
        echo "1) List all zones with details (runtime)"
        echo "2) Show active zone details"
        echo "3) Show public zone details"
        echo "4) Change default zone"
        echo "5) Attach interface to zone"
        echo "0) Back to main menu"
        echo
        read -rp "Choose an option: " ans
        case "$ans" in
            1) $FWCMD --list-all-zones; pause ;;
            2) $FWCMD --list-all; pause ;;
            3) $FWCMD --zone=public --list-all; pause ;;
            4)
                read -rp "New default zone: " z
                $FWCMD --set-default-zone="$z"
                pause
                ;;
            5)
                read -rp "Interface (e.g. enp0s3): " iface
                read -rp "Zone (default: public): " z
                z=${z:-public}
                $FWCMD --zone="$z" --change-interface="$iface"
                pause
                ;;
            0) break ;;
            *) echo "Invalid choice"; pause ;;
        esac
    done
}

# --- CATEGORY 3: SERVICES & PORTS -------------------------------------------

menu_services_ports() {
    while true; do
        clear
        echo "=== Firewalld: Services & Ports ==="
        echo "1) List allowed services (current zone)"
        echo "2) List open ports (current zone)"
        echo "3) Add service"
        echo "4) Remove service"
        echo "5) Add port"
        echo "6) Remove port"
        echo "7) Runtime -> Permanent sync"
        echo "0) Back to main menu"
        echo
        read -rp "Choose an option: " ans
        case "$ans" in
            1) $FWCMD --list-services; pause ;;
            2) $FWCMD --list-ports; pause ;;
            3)
                read -rp "Service name (e.g. ssh, https): " srv
                read -rp "Zone (default: public): " z
                z=${z:-public}
                read -rp "Permanent? (y/N): " perm
                if [[ $perm =~ ^[Yy]$ ]]; then
                    $FWCMD --permanent --zone="$z" --add-service="$srv"
                else
                    $FWCMD --zone="$z" --add-service="$srv"
                fi
                pause
                ;;
            4)
                read -rp "Service name (e.g. ssh, https): " srv
                read -rp "Zone (default: public): " z
                z=${z:-public}
                read -rp "Permanent? (y/N): " perm
                if [[ $perm =~ ^[Yy]$ ]]; then
                    $FWCMD --permanent --zone="$z" --remove-service="$srv"
                else
                    $FWCMD --zone="$z" --remove-service="$srv"
                fi
                pause
                ;;
            5)
                read -rp "Port (e.g. 22/tcp, 443/tcp): " port
                read -rp "Zone (default: public): " z
                z=${z:-public}
                read -rp "Permanent? (y/N): " perm
                if [[ $perm =~ ^[Yy]$ ]]; then
                    $FWCMD --permanent --zone="$z" --add-port="$port"
                else
                    $FWCMD --zone="$z" --add-port="$port"
                fi
                pause
                ;;
            6)
                read -rp "Port (e.g. 22/tcp, 443/tcp): " port
                read -rp "Zone (default: public): " z
                z=${z:-public}
                read -rp "Permanent? (y/N): " perm
                if [[ $perm =~ ^[Yy]$ ]]; then
                    $FWCMD --permanent --zone="$z" --remove-port="$port"
                else
                    $FWCMD --zone="$z" --remove-port="$port"
                fi
                pause
                ;;
            7)
                $FWCMD --runtime-to-permanent
                echo "Runtime configuration saved as permanent."
                pause
                ;;
            0) break ;;
            *) echo "Invalid choice"; pause ;;
        esac
    done
}

# --- CATEGORY 4: RICH RULES (ADVANCED POLICY) -------------------------------

menu_rich_rules() {
    while true; do
        clear
        echo "=== Firewalld: Rich Rules (Advanced Policy) ==="
        echo "1) List rich rules (runtime)"
        echo "2) List rich rules (permanent)"
        echo "3) Add rich rule (runtime)"
        echo "4) Add rich rule (permanent)"
        echo "5) Remove rich rule (runtime)"
        echo "6) Remove rich rule (permanent)"
        echo "0) Back to main menu"
        echo
        read -rp "Choose an option: " ans
        case "$ans" in
            1) $FWCMD --list-rich-rules; pause ;;
            2) $FWCMD --permanent --list-rich-rules; pause ;;
            3)
                echo "Enter rich rule (example:"
                echo "  rule family=\"ipv4\" source address=\"10.0.0.0/24\" service name=\"ssh\" accept"
                read -rp "Rule: " rule
                $FWCMD --add-rich-rule="$rule"
                pause
                ;;
            4)
                echo "Enter rich rule (permanent):"
                read -rp "Rule: " rule
                $FWCMD --permanent --add-rich-rule="$rule"
                pause
                ;;
            5)
                echo "Enter exact rich rule to remove (runtime):"
                read -rp "Rule: " rule
                $FWCMD --remove-rich-rule="$rule"
                pause
                ;;
            6)
                echo "Enter exact rich rule to remove (permanent):"
                read -rp "Rule: " rule
                $FWCMD --permanent --remove-rich-rule="$rule"
                pause
                ;;
            0) break ;;
            *) echo "Invalid choice"; pause ;;
        esac
    done
}

# --- CATEGORY 5: SECURITY / HARDENING CONTROLS ------------------------------

menu_security() {
    while true; do
        clear
        echo "=== Firewalld: Security / Hardening Controls ==="
        echo "1) Enable panic mode (drop all traffic)"
        echo "2) Disable panic mode"
        echo "3) Show panic mode status"
        echo "4) Enable lockdown mode"
        echo "5) Disable lockdown mode"
        echo "6) Show lockdown status"
        echo "7) Validate configuration (check-config)"
        echo "0) Back to main menu"
        echo
        read -rp "Choose an option: " ans
        case "$ans" in
            1) $FWCMD --panic-on; pause ;;
            2) $FWCMD --panic-off; pause ;;
            3) $FWCMD --query-panic; pause ;;
            4) $FWCMD --lockdown-on; pause ;;
            5) $FWCMD --lockdown-off; pause ;;
            6) $FWCMD --query-lockdown; pause ;;
            7) $FWCMD --check-config; pause ;;
            0) break ;;
            *) echo "Invalid choice"; pause ;;
        esac
    done
}

# --- CATEGORY 6: NAT / MASQUERADING ----------------------------------------

menu_nat() {
    while true; do
        clear
        echo "=== Firewalld: NAT / Masquerading ==="
        echo "1) Enable masquerading (runtime)"
        echo "2) Disable masquerading (runtime)"
        echo "3) Enable masquerading (permanent)"
        echo "4) Disable masquerading (permanent)"
        echo "0) Back to main menu"
        echo
        read -rp "Choose an option: " ans
        case "$ans" in
            1) $FWCMD --add-masquerade; pause ;;
            2) $FWCMD --remove-masquerade; pause ;;
            3) $FWCMD --permanent --add-masquerade; pause ;;
            4) $FWCMD --permanent --remove-masquerade; pause ;;
            0) break ;;
            *) echo "Invalid choice"; pause ;;
        esac
    done
}

# --- MAIN MENU --------------------------------------------------------------

main_menu() {
    check_firewalld
    while true; do
        clear
        echo "=========== Firewalld Admin Menu ==========="
        echo "1) Status & Information"
        echo "2) Zones & Interfaces"
        echo "3) Services & Ports"
        echo "4) Rich Rules (Advanced Policy)"
        echo "5) Security / Hardening Controls"
        echo "6) NAT / Masquerading"
        echo "0) Exit"
        echo "============================================"
        echo
        read -rp "Choose a category: " choice
        case "$choice" in
            1) menu_status ;;
            2) menu_zones ;;
            3) menu_services_ports ;;
            4) menu_rich_rules ;;
            5) menu_security ;;
            6) menu_nat ;;
            0) clear; exit 0 ;;
            *) echo "Invalid choice"; pause ;;
        esac
    done
}

main_menu
