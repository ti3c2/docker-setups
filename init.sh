#!/bin/bash

# Setup execution flow variables
export PYTHON_VERSION="3.10.12"
export SETUP_HOME=0
export SETUP_PYTHON=1
export SETUP_COMFYUI=1
export LOAD_MODELS="SDXL FLUX JUGGERNAUTXL"

# Setup path for setup scripts
export INIT_DIR="$HOME/INIT"
export SETUP_SCRIPTS_DIR="$INIT_DIR/setup-scripts"

# Clone the repository
[ -d "$SETUP_SCRIPTS_DIR" ] || git clone https://github.com/ti3c2/docker-setups.git "$INIT_DIR"

# Make scripts executable
chmod -R +x "$SETUP_SCRIPTS_DIR"

# Execute
cd "$SETUP_SCRIPTS_DIR" || exit
bash setup.sh
