#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to source repo...\033[0m\n"

# Build the project.
hugo -D

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

printf "\033[0;32mDeploying updates to GitHub website...\033[0m\n"

yes | cp -rf ./public/* ../abhijeet-chouhan.github.io

# Update main dir.
cd ../abhijeet-chouhan.github.io

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

printf "\033[0;32mDone\033[0m\n"