# 🚀 sgit — Super Git Automation Tool (Linux Admin Toolkit)

**Date:** 2025-11-24  
**System:** Linux (RHEL / Arch / Ubuntu / Fedora)  
**Category:** Tools → Git / Automation  

---

## Problem

During fast-paced Linux administration, scripting, documentation, and lab development, Git workflows can become repetitive and slow:

- Checking status
- Staging files
- Writing commit messages
- Pushing changes

Running these as separate commands interrupts your flow and makes it harder to stay focused on the actual work (labs, configs, notes) instead of Git plumbing.

---

## Solution

`sgit` is a **one-command Git helper** that automates the entire workflow. It:

- Shows the current branch
- Displays a short, clean status view (`git status -sb`)
- Stages **all** modified / new / deleted files
- Creates a **timestamped commit message**
- Pushes the commit to `origin/<branch>`
- Prints clear, readable output

This makes `sgit` ideal for personal repos, lab environments, and rapid documentation commits.

---

## Usage

From inside any Git repository, run:

    sgit

Example output:

    === Super Git ===
    Current branch: main

    == Status ==
    ## main...origin/main

    == Adding all changes ==

    == Committing ==
    Message: Auto-commit on 2025-11-24 21:24:20

    == Pushing to origin/main ==

    === Done! 🚀 ===

---

## Features

- ⚡ One-command workflow: status → add → commit → push
- 🕒 Timestamp-based commit messages
- 🧹 Clean status output using `git status -sb`
- 📤 Direct push to the current branch
- 🏎️ Fast workflow for notes, scripts, and admin repos
- 🧰 Simple Bash script, easy to read and extend

---

## Script Location

Repository path:

    linux-admin/tools/supergit.sh

---

## Alias

To use `sgit` as a shortcut on your system, define:

    alias sgit="$HOME/linux-cloud-security-mastery/linux-admin/tools/supergit.sh"

This gives you a quick one-word Git automation command.

---

## Implementation

`supergit.sh` performs the following steps:

- Detects the active Git branch
- Prints the branch name and a clean status
- Stages all changed files (`git add -A`)
- Exits cleanly if there is nothing to commit
- Builds an automatic timestamped commit message
- Pushes directly to `origin/<current branch>`
- Prints a final success banner

This keeps the tool:

- Easy to maintain
- Easy to understand at a glance
- Safe and convenient for personal and lab workflows

---

## Full Script (Reference)

    #!/usr/bin/env bash

    echo -e "\n=== Super Git ==="

    # Ensure we're inside a Git repo
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not inside a Git repository."
        exit 1
    fi

    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    echo "Current branch: $BRANCH"

    echo
    echo "== Status =="
    git status -sb

    # Auto-add all changes
    echo
    echo "== Adding all changes =="
    git add -A

    # If nothing changed, stop
    if git diff --cached --quiet; then
        echo "No changes to commit."
        exit 0
    fi

    # Auto-commit with timestamp
    MESSAGE="Auto-commit on $(date '+%Y-%m-%d %H:%M:%S')"
    echo
    echo "== Committing =="
    echo "Message: $MESSAGE"
    git commit -m "$MESSAGE"

    # Auto-push
    echo
    echo "== Pushing to origin/$BRANCH =="
    git push origin "$BRANCH"

    echo -e "\n=== Done! 🚀 ==="
