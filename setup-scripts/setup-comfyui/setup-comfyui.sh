#!/bin/bash

# Upgrade pip and install initial dependencies
pip install --no-cache-dir --upgrade pip setuptools wheel
pip install --no-cache-dir datasets huggingface-hub "protobuf<4" "click<8.1"

# Set the working directory for ComfyUI
COMFY_DIR="$HOME/comfyui"
mkdir -p "$COMFY_DIR"
cd "$COMFY_DIR"

# Clone ComfyUI repository
git clone https://github.com/comfyanonymous/ComfyUI .

# Install required Python packages for ComfyUI
pip install xformers!=0.0.18 --no-cache-dir -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu121

# Execute installation scripts for components
bash /setup-scripts/setup-comfyui/install-custom-nodes.sh
bash /setup-scripts/setup-comfyui/install-models.sh
