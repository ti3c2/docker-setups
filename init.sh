#!/bin/bash

# Setup execution flow variables
export PYTHON_VERSION="3.10.12"
export SETUP_HOME=0
export SETUP_PYTHON=1
export SETUP_COMFYUI=1
export LOAD_MODELS="SDXL FLUX JUGGERNAUTXL"
export DOCKER_SETUP_REPO="https://github.com/ti3c2/docker-setups.git"
export DOTFILES_REPO=""

# Setup path for setup scripts
export INIT_DIR="$HOME/INIT"
export SETUP_SCRIPTS_DIR="$INIT_DIR/setup-scripts"

# Clone the repository if it does not exist else pull the changes
# TODO resolve case when directory exists and whether it is git
apt install tree -y && tree /root
if [ ! -d "$SETUP_SCRIPTS_DIR" ]; then
    rm -rf $INIT_DIR
fi
git clone "$DOCKER_SETUP_REPO" "$INIT_DIR"

# Make scripts executable
chmod -R +x "$SETUP_SCRIPTS_DIR"

# Execute
cd "$SETUP_SCRIPTS_DIR" || exit
bash setup.sh
