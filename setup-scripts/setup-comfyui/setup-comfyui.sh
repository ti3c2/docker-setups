#!/bin/bash

# Upgrade pip and install initial dependencies
pip install --no-cache-dir --upgrade pip setuptools wheel
pip install --no-cache-dir datasets huggingface-hub "protobuf<4" "click<8.1"

# Set the working directory for ComfyUI
export COMFY_DIR="{$COMFY_DIR:-$HOME/ComfyUI}"
mkdir -p "$COMFY_DIR"
cd "$COMFY_DIR" || exit

# Clone ComfyUI repository
git clone https://github.com/comfyanonymous/ComfyUI .

# Install required Python packages for ComfyUI
pip install xformers!=0.0.18 --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121

# Execute installation scripts for components in parallel
bash $SETUP_SCRIPTS_DIR/setup-comfyui/install-custom-nodes.sh &
bash $SETUP_SCRIPTS_DIR/setup-comfyui/install-models.sh "{$LOAD_MODELS}" &
wait
