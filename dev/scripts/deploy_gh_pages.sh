#!/bin/bash
set -euo pipefail

# Deploy the lab instructions to GitHub Pages.
# This script is normally run by GitHub Actions.

git fetch ; git checkout gh-pages ; git reset --hard origin/main

# the tools are already installed in the self-hosted runner
cargo binstall -y mdbook mdbook-admonish mdbook-catppuccin
mdbook-admonish install
mdbook-catppuccin install
mdbook build

# GitHub Pages expects the static website to be in the docs folder
rm -rf docs
mv book docs

git config --global user.email "gh-pages@invalid.local"
git config --global user.name "gh-pages bot"

git add --all ; git commit --message "deploy" ; git push --force
