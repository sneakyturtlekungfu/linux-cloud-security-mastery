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
