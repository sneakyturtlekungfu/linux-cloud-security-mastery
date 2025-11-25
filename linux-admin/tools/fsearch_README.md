# 🔍 fsearch — Interactive Filesystem Search Tool (Linux Admin Toolkit)

**Date:** 2025-11-24  
**System:** Linux (RHEL / Arch / Ubuntu / Fedora)  
**Category:** Tools → Filesystem Utilities  

---

## Problem

When working on a large Linux system, it’s common to need to locate files when you only know **part** of the name. The standard `find` command works, but requires remembering flags, paths, and typing long patterns.

---

## Solution

`fsearch.sh` is an interactive helper that lets you type only the **partial fragment** of the filename and automatically performs a case-insensitive system-wide search using `find`.

---

## Usage

From any shell session (after your alias is loaded):

    fs
    Search term (part of name): custom

This runs the equivalent of:

    sudo find / -iname "*custom*" 2>/dev/null

You can also pass the search term as an argument:

    fs custom

---

## Features

- 🔎 Partial-match search using wildcards (`*term*`)
- 🔤 Case-insensitive matching via `-iname`
- 🌎 Searches the entire filesystem from `/`
- 🙈 Hides permission errors for clean output (`2>/dev/null`)
- ⌨️ Accepts either an argument or interactive input
- 🧰 Implemented as a simple Bash script for easy reuse and extension

---

## Script Location

Repository path:

    linux-admin/tools/fsearch.sh

Installed symlink (on your system):

    ~/bin/fsearch -> ~/linux-cloud-security-mastery/linux-admin/tools/fsearch.sh

---

## Alias

Your shell alias (loaded from your custom alias file):

    alias fs="$HOME/bin/fsearch"

This makes `fs` a short, memorable entry point to the tool.

---

## Implementation

`fsearch.sh` is implemented as:

- A small Bash script with an optional CLI argument
- A prompt if no argument is supplied
- A guard that exits cleanly if the user enters nothing
- A `find` call that searches the full filesystem tree

This keeps the tool:
- Easy to read
- Easy to maintain
- Easy to extend for future options (e.g., depth limits, path filters, non-sudo mode)

---

## Notes

- The tool uses `sudo find / ...`, so you will be prompted for your password if your `sudo` session is not cached.
- For large filesystems, the search may take time; you can refine it later by adding options (e.g., starting path, file types, or max depth).
