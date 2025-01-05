#!/bin/bash

# Install essentials
apt-get update
apt-get install -y --no-install-recommends \
    # Install git. Resolve issue with ca-certificates
    git git-lfs ca-certificates \
    # Install Neovim Build essentials
    ninja-build gettext cmake unzip curl build-essential \
    # Install thing responsible for apt-add-repository
    software-properties-common \
    # Don't remember what this does
    gnupg

# Download dotfiles and symlink them
git clone https://github.com/poqushoi/my-dotfiles "$HOME/dotfiles"
git checkout remote-setup
ln -s "$HOME/dotfiles/.config" "$HOME/.config"

# Execute scripts
bash "$SETUP_SCRIPTS_DIR/setup-home/install-neovim.sh"
bash "$SETUP_SCRIPTS_DIR/setup-home/install-fish.sh"


# Clean apt cache
apt-get clean && rm -rf /var/lib/apt/lists/*
