#!/bin/bash

# Load the model names from the environment variable (comma-separated)
LOAD_MODELS=${LOAD_MODELS}

# Check if LOAD_MODELS is empty
if [ -z "$LOAD_MODELS" ]; then
    echo "No models specified in LOAD_MODELS. Exiting without loading any models."
    exit 0
fi

# Convert the comma-separated string into an array
IFS=',' read -r -a models <<< "$LOAD_MODELS"

# Define models path
MODELS_PATH="$HOME/comfyui/models"

# Define an associative array to map model names to loading functions
declare -A model_functions

# Function to load SDXL model
load_sdxl() {
    model_name="SDXL"
    echo "Loading $model_name model..."
    # -nc to prevent loading of existing file
    wget -nc -P "$MODELS_PATH/checkpoints/SDXL" https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors \

    echo "Performing $model_name model-specific steps..."
    wget -nc -P "$MODELS_PATH/loras/HyperSD/SDXL" https://huggingface.co/ByteDance/Hyper-SD/resolve/main/Hyper-SDXL-4steps-lora.safetensors \
}
model_functions["$model_name"]=load_sdxl

# Function to load FLUX model
load_flux() {
    echo "Loading FLUX model..."
    # This is checkpoint made by Comfy. It includes VAE and CLIP
    # The original BlackForest does not include them and requires
    # loading VAE and CLIP separately
    wget -nc -P "$MODELS_PATH/checkpoints/FLUX1" https://huggingface.co/Comfy-Org/flux1-dev/resolve/main/flux1-dev-fp8.safetensors \
}
model_functions["FLUX"]=load_flux

# Function to load JuggernautXL model
load_juggernautxl() {
    echo "Loading JuggernautXL v9..."
    wget -nc -P "$MODELS_PATH/checkpoints/JuggernautXL" https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors \
}
model_functions["JUGGERNAUTXL"]=load_juggernautxl

# Iterate through the models and load them
for model in "${models[@]}"; do
    if [[ -n "${model_functions[$model]}" ]]; then
        ${model_functions[$model]}  # Call the function associated with the model
    else
        echo "Unknown model name: $model"
        echo "Please set LOAD_MODELS to valid model names (e.g., 'SDXL,FLUX')."
    fi
done
