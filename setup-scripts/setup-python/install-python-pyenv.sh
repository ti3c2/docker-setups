#!/bin/bash

# Install dependencies
apt-get update && apt-get install -y \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
    libffi-dev liblzma-dev git git-lfs \
    ffmpeg libsm6 libxext6 cmake libgl1-mesa-glx && \
    rm -rf /var/lib/apt/lists/* && \
    git lfs install

# Set up pyenv for Python version management
curl https://pyenv.run | bash
export PATH="$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH"

# Install Python version
PYTHON_VERSION=${1:-3.10.12}  # Default to 3.10.12 if no version is provided
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
pyenv rehash

# Upgrade pip and install necessary packages
pip install --no-cache-dir --upgrade pip setuptools wheel

# Check if Fish is installed and set up pyenv variables if it is
if command -v fish &> /dev/null; then
    echo "Fish shell is installed, configuring PYENV_ROOT for Fish..."

    # Set PYENV_ROOT and add it to the PATH in Fish
    fish -c 'set -Ux PYENV_ROOT $HOME/.pyenv'
    fish -c 'fish_add_path $PYENV_ROOT/bin'
    fish -c 'fish_add_path $HOME/.pyenv/shims'
else
    echo "Fish shell is not installed, skipping Fish configuration."
fi
