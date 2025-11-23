# linux-admin/bash/custom_aliases.sh
# -------------------------------------------------------------------
# Custom CLI aliases for day-to-day Linux, Git, and housekeeping.
# This file is version-controlled in linux-cloud-security-mastery so
# it can be reused across machines.
#
# Usage:
#   1. Copy or symlink this file to: ~/.config/custom_aliases.sh
#   2. Source it from ~/.bashrc or ~/.bash_profile, for example:
#        if [ -f "$HOME/.config/custom_aliases.sh" ]; then
#          . "$HOME/.config/custom_aliases.sh"
#        fi
# -------------------------------------------------------------------

# --- Git quality-of-life aliases -----------------------------------

# Quick status
alias gs='git status'

# Stage everything in the current repo
alias ga="git add ."

# Commit with a message, e.g.:
#   gc "Update README"
alias gc="git commit -m"

# Push current branch to origin
alias gp="git push"

# Pull latest changes from origin
alias gl="git pull"

# Jump into this repo from anywhere
alias gcd='cd "$HOME/linux-cloud-security-mastery"'


# --- Housekeeping / utilities --------------------------------------

# Clear recent screenshots from the default GNOME screenshots folder.
# Assumes:
#   - Your screenshots are saved under:  ~/Pictures/Screenshots
#   - You have a clearsnaps script at:   $HOME/bin/clearsnaps.sh
#
# Example clearsnaps.sh implementation:
#   #!/usr/bin/env bash
#   SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
#   if [ ! -d "$SCREENSHOT_DIR" ]; then
#     echo "Screenshot directory not found: $SCREENSHOT_DIR"
#     exit 1
#   fi
#   read -rp "Delete ALL screenshots in $SCREENSHOT_DIR? [y/N] " ans
#   case "$ans" in
#     y|Y) find "$SCREENSHOT_DIR" -maxdepth 1 -type f -print -delete ;;
#     *)   echo "Aborted." ;;
#   esac
#
alias clearsnaps="$HOME/bin/clearsnaps.sh"
