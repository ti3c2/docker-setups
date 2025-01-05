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
    #
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    # Face swap models. The package installs too many models, so maybe it is fine to stop it
    "https://github.com/Gourieff/comfyui-reactor-node"
    # Image side-by-side comparison, workspace bookmarks, etc
    "https://github.com/rgthree/rgthree-comfy"
    # Show text
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    # Inputs for Int, Float, String
    "https://github.com/M1kep/ComfyLiterals"
    # SDXL resolutions and math operations
    "https://github.com/evanspearman/ComfyMath"
    # Image size
    "https://github.com/cubiq/ComfyUI_essentials"
    # Switches
    "https://github.com/lquesada/ComfyUI-Interactive"
    # CLIP Segmentation
    "https://github.com/time-river/ComfyUI-CLIPSeg"
    # Unsampler
    "https://github.com/BlenderNeko/ComfyUI_Noise"
    # Tools and widgets
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
)

# Navigate to custom_nodes folder
mkdir -p "$COMFY_DIR/custom_nodes"
cd "$COMFY_DIR/custom_nodes"

# Iterate over the array and clone each repository
for repo in "${custom_nodes[@]}"; do
    git clone "$repo"
done

# Navigate back to comfy dir
cd "$COMFY_DIR"

# Install requirements for all the custom_nodes
echo "Installing requirements for custom nodes recursively..."
find . -name 'requirements.txt' -exec pip install -r {} \;

# Uninstall torch and install the right version
echo "Uninstalling torch and installing the right version..."
pip uninstall torch
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124
