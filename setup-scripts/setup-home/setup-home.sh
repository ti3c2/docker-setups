#!/bin/bash

# Install essentials
apt update && apt install -y --no-install-recommends \
    # Install git. Resolve issue with ca-certificates
    git git-lfs ca-certificates \
    # Install Neovim Build essentials
    ninja-build gettext cmake unzip curl build-essential \
    # Install thing responsible for apt-add-repository
    software-properties-common \
    # Plugins essentials
    fzf ripgrep \
    # Other useful things
    ncdu \
    # Don't remember what this does
    gnupg

# Download dotfiles and symlink them
if [ -n "${DOTFILES_REPO}" ]; then
    git clone $DOTFILES_REPO "$HOME/dotfiles"
    git -C "$HOME/dotfiles" checkout remote-setup
    ln -s "$HOME/dotfiles/.config" "$HOME/.config"
    # cd $HOME/dotfiles || exit
    # stow .
fi

# Execute scripts
bash $SETUP_SCRIPTS_DIR/setup-home/install-neovim.sh
bash $SETUP_SCRIPTS_DIR/setup-home/install-fish.sh

# Clean apt cache
apt-get clean && rm -rf /var/lib/apt/lists/*
