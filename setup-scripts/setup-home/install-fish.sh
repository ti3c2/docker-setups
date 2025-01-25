#!/bin/bash

# Add the Fish shell PPA and install Fish
apt-add-repository ppa:fish-shell/release-3 -y
apt update && apt install -y --no-install-recommends \
    software-properties-common gnupg \
    fish

# Set Fish to be default shell
chsh -s "$(which fish)"
