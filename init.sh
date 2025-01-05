#!/bin/bash

# Setup path for setup scripts
export INIT_DIR="$HOME/INIT"
export SETUP_SCRIPTS_DIR="$SETUP_SCRIPTS_DIR/setup-scripts"

# Clone the repository
git clone https://github.com/ti3c2/docker-setups.git "$INIT_DIR"

# Make scripts executable
chmod -R +x "$SETUP_SCRIPTS_DIR"

# Execute
cd "$SETUP_SCRIPTS_DIR" || exit
bash setup.sh
