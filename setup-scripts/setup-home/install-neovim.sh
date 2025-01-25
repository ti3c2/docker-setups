#!/bin/bash

INSTALL_NEOVIM="${INSTALL_NEOVIM:-1}"
if (( "$INSTALL_NEOVIM" == "0" )); then
    exit 1
fi

# Install Neovim and its dependencies
apt-get update
apt-get install -y --no-install-recommends \
    ninja-build gettext cmake unzip curl build-essential git ca-certificates \
    fzf ripgrep

VERSION="v0.10.2"
PACKAGE_NAME="nvim-linux64"
TAR_NAME="$PACKAGE_NAME.tar.gz"
wget -nc -P /tmp https://github.com/neovim/neovim/releases/download/$VERSION/$TAR_NAME
rm -rf /opt/nvim*
tar -C /opt -xzvf /tmp/$TAR_NAME
ln -s /opt/$PACKAGE_NAME/bin/nvim /bin/nvim
rm -rf /tmp/$TAR_NAME


# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install 22
