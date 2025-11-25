🚀 sgit — One-Command Git Auto Commit & Push Tool (Linux Admin Toolkit)

Date: 2025-11-24
System: Linux (RHEL / Arch / Ubuntu / Fedora)
Category: Tools → Git Automation

Problem

During fast-paced Linux administration, scripting, documentation, and lab development, Git workflows can become repetitive. Running separate commands for checking status, staging files, writing commit messages, and pushing changes interrupts focus and slows down rapid iteration.

Solution

sgit is a one-command Git helper that automates the full workflow. It:

• Shows the current branch
• Displays a short, clean Git status
• Stages all new/modified/deleted files
• Creates a timestamped commit message
• Pushes the commit to origin/<branch>
• Produces clean, readable output

This tool is ideal for personal repos, lab work, and rapid documentation.

Usage

From inside any Git repository:

sgit

Example:

=== Super Git ===
Current branch: main

== Status ==

main...origin/main

== Adding all changes ==

== Committing ==
Message: Auto-commit on 2025-11-24 21:24:20

== Pushing to origin/main ==

=== Done! 🚀 ===

Features

• Automatic staging of all changes
• Timestamp-based commit messages
• Clean status output using git status -sb
• Direct push to the current branch
• Fast workflow for Linux learning, notes, and scripts
• Simple Bash implementation, easy to modify

Script Location

Repository path:

linux-admin/tools/supergit.sh

Alias

Define the shortcut:

alias sgit="$HOME/linux-cloud-security-mastery/linux-admin/tools/supergit.sh"

This gives you a quick single-word Git automation command.

Implementation

supergit.sh performs the following steps:

• Validates that the current directory is a Git repo
• Shows branch and short status
• Stages all changes
• Exits cleanly if nothing is staged
• Generates a timestamped commit message
• Pushes to origin/<branch>

It is intentionally simple, readable, and maintainable.

Script (Reference)

#!/usr/bin/env bash
echo -e "\n=== Super Git ==="
if ! git rev-parse --git-dir > /dev/null 2>&1; then
echo "Error: Not inside a Git repository."
exit 1
fi
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $BRANCH"
echo
echo "== Status =="
git status -sb
echo
echo "== Adding all changes =="
git add -A
if git diff --cached --quiet; then
echo "No changes to commit."
exit 0
fi
MESSAGE="Auto-commit on $(date '+%Y-%m-%d %H:%M:%S')"
echo
echo "== Committing =="
echo "Message: $MESSAGE"
git commit -m "$MESSAGE"
echo
echo "== Pushing to origin/$BRANCH =="
git push origin "$BRANCH"
echo -e "\n=== Done! 🚀 ==="
