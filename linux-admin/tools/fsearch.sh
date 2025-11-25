#!/usr/bin/env bash
#
# fsearch.sh - Interactive filesystem search helper
# Author: Benjamin Panzer (sneakyturtlekungfu)
# Repo: linux-cloud-security-mastery/linux-admin/tools
#
# Usage:
#   fsearch.sh [search-term]
#   - If search-term is not provided, you will be prompted.
#
# Behavior:
#   * Case-insensitive search (-iname)
#   * Partial match using wildcards: *term*
#   * Starts at filesystem root (/)
#   * Suppresses permission errors (2>/dev/null)

term="$1"

# If no CLI argument, prompt the user
if [ -z "$term" ]; then
    read -rp "Search term (part of name): " term
fi

# If still empty, bail out
if [ -z "$term" ]; then
    echo "No search term provided. Exiting."
    exit 1
fi

# Run case-insensitive partial search from /
sudo find / -iname "*${term}*" 2>/dev/null
