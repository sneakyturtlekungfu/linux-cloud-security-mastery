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
- **fs** → Runs the `fsearch` filesystem search tool.  
  Full tool documentation: [fsearch tool](../tools/README.md)

## Purpose

This folder is where I keep small, repeatable command-line helpers that I actually use during daily work on this project. As I add more useful aliases or small scripts, I will update `custom_aliases.sh` and this README.
