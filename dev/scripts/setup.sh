#!/bin/bash
set -euo pipefail

cargo binstall -y mdbook mdbook-admonish mdbook-catppuccin

mdbook-admonish install
mdbook-catppuccin install
