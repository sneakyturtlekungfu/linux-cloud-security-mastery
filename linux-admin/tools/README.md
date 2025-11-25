# 🔍 `fsearch` — Interactive Filesystem Search Tool

A lightweight, interactive Linux admin helper script that performs **case-insensitive, partial-match searches** across the entire filesystem. Perfect for tracking down files, config snippets, or directories when you only know **part** of the name.

## Usage
\`\`\`bash
fs
Search term (part of name): custom
\`\`\`

## What it does
Runs:
\`\`\`bash
sudo find / -iname "*custom*" 2>/dev/null
\`\`\`

## Features
- 🔎 Partial name matching (\*term\*)
- 🔤 Case-insensitive search (-iname)
- 🌎 Full system scan from /
- 🙈 Suppresses permission errors for clean output
- ⚡ Quickly locates configs, scripts, services, logs, etc.

## Location
\`\`\`
linux-admin/tools/fsearch.sh
\`\`\`

## Alias
\`\`\`
fs → ~/bin/fsearch → fsearch.sh
\`\`\`
