#!/bin/bash

# Install Neovim and its dependencies
apt-get update
apt-get install -y --no-install-recommends \
    ninja-build gettext cmake unzip curl build-essential git ca-certificates

# Clone Neovim repository and build it
git clone https://github.com/neovim/neovim /tmp/neovim
cd /tmp/neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
rm -rf /tmp/neovim

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install 22
