#!/bin/bash
set -euo pipefail

cargo binstall -y mdbook mdbook-admonish

mdbook-admonish install
