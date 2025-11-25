🚀 sgit — Super Git Automation Tool (Linux Admin Toolkit)

Date: 2025-11-24
System: Linux (RHEL / Arch / Ubuntu / Fedora)
Category: Tools → Git / Automation

Problem

During fast-paced Linux administration, scripting, documentation, and lab development, Git workflows can become repetitive and slow:

Checking status

Staging files

Writing commit messages

Pushing changes

Running these as separate commands interrupts your flow and slows down rapid learning and documentation.

Solution

sgit is a one-command Git helper that automates the full workflow.
It:

Shows the current branch

Displays a short, clean Git status (git status -sb)

Automatically stages all modified/new/deleted files

Creates a timestamped commit message

Pushes the commit to origin/<branch>

Produces clean, readable output

Perfect for personal repos, rapid lab notes, and fast Git documentation.

Usage

From inside any Git repository, simply run:

sgit

Example Output
=== Super Git ===
Current branch: main

== Status ==
## main...origin/main

== Adding all changes ==

== Committing ==
Message: Auto-commit on 2025-11-24 21:24:20

== Pushing to origin/main ==

=== Done! 🚀 ===

Features

⚡ Automatic staging of all changes

🕒 Timestamp-based commit messages

🧼 Clean status output using git status -sb

📤 Direct push to current branch

🏎️ Fast workflow for notes, scripts, and admin repos

💡 Simple Bash implementation, easy to modify

Script Location

Repository path:

linux-admin/tools/supergit.sh


Installed alias on your system:

alias sgit="$HOME/linux-cloud-security-mastery/linux-admin/tools/supergit.sh"


This gives you a one-word Git automation command.

Implementation

supergit.sh performs the following steps:

Detects the active Git branch

Prints branch + clean status

Stages all changed files (git add -A)

Commits with an automatic timestamp message

Pushes directly to origin/<current branch>

Prints a success confirmation banner

Full Script
#!/usr/bin/env bash

echo "=== Super Git ==="

# Current branch
branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $branch"
echo

echo "== Status =="
git status -sb
echo

echo "== Adding all changes =="
git add -A
echo

echo "== Committing =="
msg="Auto-commit on $(date '+%Y-%m-%d %H:%M:%S')"
echo "Message: $msg"
git commit -m "$msg"
echo

echo "== Pushing to origin/$branch =="
git push origin "$branch"
echo

echo "=== Done! 🚀 ==="
