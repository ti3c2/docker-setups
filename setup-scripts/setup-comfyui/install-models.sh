#!/bin/bash

# Load the model names from the environment variable (comma-separated)
LOAD_MODELS=${LOAD_MODELS:-"SDXL"}  # Default to SDXL if not set

# Convert the comma-separated string into an array
IFS=',' read -r -a models <<< "$LOAD_MODELS"

MODELS_PATH="$HOME/comfyui/models"

# Function to load SDXL model
load_sdxl() {
    echo "Loading SDXL model..."
    wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors \
        -P "$MODELS_PATH/checkpoints/SDXL"

    echo "Performing SDXL model-specific steps..."
    wget https://huggingface.co/ByteDance/Hyper-SD/resolve/main/Hyper-SDXL-4steps-lora.safetensors \
        -P "$MODELS_PATH/loras/HyperSD/SDXL"
}

# Function to load FLUX model
load_flux() {
    echo "Loading FLUX model..."

    echo "Performing FLUX model-specific steps..."
}

# Iterate through the models and load them
for model in "${models[@]}"; do
    case "$model" in
        "SDXL")
            load_sdxl
            ;;
        "FLUX")
            load_flux
            ;;
        *)
            echo "Unknown model name: $model"
            echo "Please set LOAD_MODELS to valid model names (e.g., 'SDXL FLUX')."
            ;;
    esac
done
