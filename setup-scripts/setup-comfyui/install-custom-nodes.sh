#!/bin/bash

# Define an array of Git repository links for Custom Nodes
declare -a custom_nodes=(
    # ComfyUI Manager
    "https://github.com/ltdrdata/ComfyUI-Manager.git"
    # Pipes
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
    # ContolNet preprocessing node
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    # Text manipulation nodes: split, replace, select line, ...
    "https://github.com/WASasquatch/was-node-suite-comfyui"
    # Text input nodes and much more to research...
    "https://github.com/TinyTerra/ComfyUI_tinyterraNodes"
)

# Navigate to custom_nodes folder
mkdir -p "$HOME/comfyui/custom_nodes"
cd "$HOME/comfyui/custom_nodes"

# Iterate over the array and clone each repository
for repo in "${custom_nodes[@]}"; do
    git clone "$repo"
done

# Navigate back to comfyui
cd "$HOME/comfyui"

# Install requirements for all the custom_nodes
find . -name 'requirements.txt' -exec pip install -r {} \;
