#!/bin/bash

# Conditional script execution based on environment variables
if [ "$SETUP_HOME" == "1" ]; then
    echo "Running home setup..."
    bash /setup-scripts/setup-home/setup-home.sh
else
    echo "Skipping home setup..."
fi

if [ "$SETUP_PYTHON" == "1" ]; then
    echo "Running Python setup..."
    bash /setup-scripts/setup-python/install-python-pyenv.sh
else
    echo "Skipping Python setup..."
fi

if [ "$SETUP_COMFYUI" == "1" ]; then
    echo "Running ComfyUI setup..."
    bash /setup-scripts/setup-comfyui/setup-comfyui.sh
else
    echo "Skipping Python setup..."
fi

# Start the fish shell or any command
exec fish
