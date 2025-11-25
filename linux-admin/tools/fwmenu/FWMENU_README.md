# 🔥 fwmenu — Firewalld Interactive Menu (Linux Admin Toolkit)

**Date:** 2025-11-25  
**System:** Linux (RHEL / Rocky / Alma / Fedora)  
**Category:** Tools – Security / Host Firewall / RHEL Administration

---

## Problem

Managing \`firewalld\` manually requires memorizing dozens of flags, rule formats, zone assignments, and permanent vs runtime modes.  
This is slow, repetitive, and prone to mistakes — especially when performing audits or hardening tasks in enterprise environments.

Admins, SOC analysts, and students commonly need to:

- Inspect firewall status  
- Modify services & ports  
- Assign zones to interfaces  
- Add rich rules  
- Enable NAT/masquerading  
- Validate configuration safety  

Doing all of this through raw \`firewall-cmd\` commands is powerful, but not efficient.

---

## Solution

\`fwmenu.sh\` is an **interactive menu-driven tool** that organizes all major firewalld features into clean categories.

It provides:

- A guided interface  
- Safe prompts  
- Reduced error risk  
- Faster administration  
- Easier learning curve  
- Automation-friendly structure  

It is built for both **learning** and **real-world sysadmin workflows**.

---

## Usage

From anywhere (after alias is loaded):

\`\`\`
fwmenu
\`\`\`

Or run manually from the repository:

\`\`\`
cd ~/linux-cloud-security-mastery/linux-admin/tools/fwmenu
./fwmenu.sh
\`\`\`

---

## Features

### 🔍 Status & Information
- Show firewalld state  
- Display firewalld version  
- Show systemd service status  
- Display default zone  
- List all zones  
- Show active zone details  

---

### 🌐 Zones & Interfaces
- List all zones with details  
- Inspect the public zone  
- Change the default zone  
- Attach an interface to a zone  

---

### 🛠 Services & Ports
- List allowed services  
- List open ports  
- Add/remove services (runtime/permanent)  
- Add/remove ports (runtime/permanent)  
- Save runtime configuration permanently  

---

### 🔒 Rich Rules (Advanced Policy)
- List rich rules  
- Add rich rules  
- Remove rich rules  

Example rich rule:

\`\`\`
rule family="ipv4" source address="10.0.0.0/24" service name="ssh" accept
\`\`\`

---

### 🧰 Security & Hardening
- Enable/disable panic mode  
- Enable/disable lockdown mode  
- Show panic/lockdown status  
- Validate configuration using \`--check-config\`  

---

### 🌐 NAT / Masquerading
- Enable masquerading (runtime/permanent)  
- Disable masquerading  
- Useful for lab networks and Podman routing  

---

## Script Location

Repository path:

\`\`\`
linux-admin/tools/fwmenu/fwmenu.sh
\`\`\`

Local path:

\`\`\`
~/linux-cloud-security-mastery/linux-admin/tools/fwmenu/fwmenu.sh
\`\`\`

---

## Alias

Add this alias for quick access:

\`\`\`
alias fwmenu="$HOME/linux-cloud-security-mastery/linux-admin/tools/fwmenu/fwmenu.sh"
\`\`\`

Reload:

\`\`\`
source ~/.config/custom_aliases.sh
\`\`\`

Run:

\`\`\`
fwmenu
\`\`\`

---

## Example Output

\`\`\`
=== Firewalld Menu ===
1) Status & Information
2) Zones & Interfaces
3) Services & Ports
4) Rich Rules
5) Security & Hardening
6) NAT / Masquerading
0) Exit
\`\`\`

---

## Notes

- Requires \`firewalld\` installed and running  
- Supports RHEL 8/9, Rocky, AlmaLinux, Fedora  
- Safe for labs and enterprise learning  
- No changes occur without confirmation  

---

## Author

Part of the **Linux-Cloud-Security-Mastery** project.  
Maintained by: **sneakyturtlekungfu**
EOF
