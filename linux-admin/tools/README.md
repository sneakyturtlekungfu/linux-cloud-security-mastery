# 🔍 fsearch — Interactive Filesystem Search Tool (Linux Admin Toolkit)

**Date:** 2025-11-24  
**System:** Linux (RHEL / Arch / Ubuntu / Fedora)  
**Category:** Tools → Filesystem Utilities

---

## Problem

When working on a large Linux system, it’s common to need to locate files when you only know **part** of the name. The standard `find` command works, but requires remembering flags and typing long patterns.

---

## Solution

`fsearch.sh` is an interactive helper that lets you type only the **partial fragment** of the filename and automatically performs a case-insensitive system-wide search.

---

## Usage

```bash
fs
Search term (part of name): custom
