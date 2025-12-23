#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Git Squash All Commits ===${NC}"
echo ""
echo "This script will:"
echo "  1. Squash all commits on the main branch into one"
echo "  2. Force push to origin/main"
echo ""
echo -e "${RED}WARNING: This rewrites git history!${NC}"
echo ""

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${RED}Error: You have uncommitted changes.${NC}"
    echo "Please commit or stash your changes before running this script."
    exit 1
fi

# Confirmation
read -p "Are you sure you want to continue? (yes/no): " confirmation
if [ "$confirmation" != "yes" ]; then
    echo "Aborted."
    exit 0
fi

echo ""
echo -e "${YELLOW}Starting squash process...${NC}"

# Get commit message
read -p "Enter commit message for squashed commit (default: 'enjoy the flow'): " commit_msg
commit_msg=${commit_msg:-"enjoy the flow"}

# Create orphan branch
echo "Creating orphan branch..."
git checkout --orphan temp-squash

# Add all files
echo "Adding all files..."
git add -A

# Commit
echo "Creating squashed commit..."
git commit -m "$commit_msg"

# Delete old main and rename
echo "Replacing main branch..."
git branch -D main
git branch -m main

# Force push
echo "Force pushing to remote..."
if git push -f origin main; then
    echo ""
    echo -e "${GREEN}✓ Success!${NC}"
    echo "All commits have been squashed into one and pushed to origin/main"
else
    echo -e "${RED}Error: Failed to push to remote${NC}"
    exit 1
fi
