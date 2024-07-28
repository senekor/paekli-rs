_default:
    just --list --unsorted

setup:
    ./dev/scripts/setup.sh

serve:
    mdbook serve

build:
    mdbook build

zellij:
    zellij --layout dev/zellij/default.kdl
