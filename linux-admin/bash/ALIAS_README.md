# Bash CLI Toolkit

This folder contains my personal command-line aliases and small tools that I use while working on this repository.

## Files in this folder

- `custom_aliases.sh`  
  This file defines the aliases I use most often.

## Git aliases

These aliases shorten common Git commands:

- `gs` → `git status`  
  Show the current repository status.

- `ga` → `git add .`  
  Stage all modified and new files in the current repository.

- `gc` → `git commit -m`  
  Start a commit with a message. Example: `gc "Update README"`.

- `gp` → `git push`  
  Push the current branch to the remote repository.

- `gl` → `git pull`  
  Pull the latest changes from the remote repository.

- `gcd` → `cd ~/linux-cloud-security-mastery`  
  Jump directly into this repository from anywhere.

## Utility aliases

- `clearsnaps`  
  Runs a script that clears all files from `~/Pictures/Screenshots` so the screenshot folder stays clean.

- `fs`  
  Runs the `fsearch` filesystem search tool.  
  Full tool documentation: [fsearch tool](../tools/README.md)

## Firewall aliases

These aliases manage `firewalld` and common RHEL security hardening tasks.

**Core control**

- `fw` → `sudo firewall-cmd`  
- `fwr` → `sudo firewall-cmd --reload`  
- `fws` → `sudo firewall-cmd --state`  
- `fwb` → `sudo firewall-cmd --get-backend`  
- `fwstart` → `sudo systemctl start firewalld`  
- `fwstop` → `sudo systemctl stop firewalld`  
- `fwenable` → `sudo systemctl enable firewalld`  
- `fwdisable` → `sudo systemctl disable firewalld`  
- `fwsys` → `sudo systemctl status firewalld`  

**Zones, services, and ports**

- `fwz` → show default zone  
- `fwza` → list all zones  
- `fwzl` → list rules for current zone  
- `fwzlp` → list rules for the `public` zone  
- `fwzlc` → list allowed services in `public`  
- `fwports` → list open ports  
- `fwservices` → list allowed services  
- `fwif` → attach interface to the `public` zone  

**Add / remove services**

- `fwas` / `fwasperm` → add service (runtime / permanent)  
- `fwrms` / `fwrmsperm` → remove service  

**Add / remove ports**

- `fwap` / `fwapperm` → add port (runtime / permanent)  
- `fwrmp` / `fwrmpperm` → remove port  

**Rich rules (advanced allow/deny/log)**

- `fwrich` / `fwrichperm` → add rich rule  
- `fwrichrm` / `fwrichrmperm` → remove rich rule  
- `fwrichlist` / `fwrichlistperm` → list rich rules  

**Hardening & troubleshooting**

- `fwpanic` / `fwpanicoff` → enable/disable panic mode  
- `fwpanicstat` → panic status  
- `fwlock` / `fwlockoff` → enable/disable lockdown mode  
- `fwlockstat` → lockdown status  
- `fwmasqon` / `fwmasqonperm` → enable masquerading  
- `fwmasqoff` / `fwmasqoffperm` → disable masquerading  
- `fwtest` → validate firewalld config  
- `fwruntime` → save runtime rules as permanent  

## Alias management helpers

These aliases control the alias system itself and act as a quick cheat sheet.

- `aedit` → open alias file (`~/.config/custom_aliases.sh`)  
- `areload` → reload alias file  
- `alist` → list all aliases in `custom_aliases.sh`  

## Purpose

This folder is where I keep small, repeatable command-line helpers that I actually use during daily work on this project. As I add more useful aliases or small scripts, I will update `custom_aliases.sh` and this README.
EOF
