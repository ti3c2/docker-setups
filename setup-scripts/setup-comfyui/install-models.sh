#!/bin/bash

# Help message function
show_help() {
    local available_models="$*"
    cat << EOF
Usage:
    Required environment variables:
    - COMFY_DIR: path to ComfyUI installation
    - LOAD_MODELS: space-separated list of models to install

    1. Run using defined environment variables:
    Check it with 'echo $VAR'
    Set it with 'export VAR="M1 M2"'

    2. Run using inplace definition of environment variables:
    COMFY_DIR="/path/to/comfyui" LOAD_MODELS="M1 M2" ./install-models.sh

Available models: $available_models
Use 'ALL' to load all models

Note: Models will be downloaded in parallel
EOF
    exit 1
}

# Define an associative array to map model names to loading functions
declare -A model_functions

wget_to_folder() {
    # Usage: wget_to_folder <folder> <url>
    # -nc: skip loading if the file already there
    # -P: specify directory
    wget -nc -P "$1" "${@:1}"
}

# Function to load SDXL model
load_sdxl() {
    model_name="SDXL"
    echo "Loading $model_name model..."
    # -nc to prevent loading of existing file
    wget_to_folder "$MODELS_PATH/checkpoints/SDXL" https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors

    echo "Performing $model_name model-specific steps..."
    wget_to_folder "$MODELS_PATH/loras/HyperSD/SDXL" https://huggingface.co/ByteDance/Hyper-SD/resolve/main/Hyper-SDXL-4steps-lora.safetensors

    # Controlnet Adapters
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/TencentARC/t2i-adapter-depth-midas-sdxl-1.0
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/TencentARC/t2i-adapter-depth-midas-sdxl-1.0
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/TencentARC/t2i-adapter-depth-zoe-sdxl-1.0
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/TencentARC/t2i-adapter-depth-midas-sdxl-1.0
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/TencentARC/t2i-adapter-sketch-sdxl-1.0
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/TencentARC/t2i-adapter-lineart-sdxl-1.0

    # Controlnet Loras
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/stabilityai/control-lora/raw/main/control-LoRAs-rank256/control-lora-canny-rank256.safetensors
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/stabilityai/control-lora/raw/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/stabilityai/control-lora/raw/main/control-LoRAs-rank256/control-lora-recolor-rank256.safetensors
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/stabilityai/control-lora/raw/main/control-LoRAs-rank256/control-lora-sketch-rank256.safetensors
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/stabilityai/control-lora/raw/main/control-LoRAs-rank128/control-lora-canny-rank256.safetensors
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/stabilityai/control-lora/raw/main/control-LoRAs-rank128/control-lora-depth-rank256.safetensors
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/stabilityai/control-lora/raw/main/control-LoRAs-rank128/control-lora-recolor-rank256.safetensors
    wget_to_folder "$MODELS_PATH/controlnet/SDXL" https://huggingface.co/stabilityai/control-lora/raw/main/control-LoRAs-rank128/control-lora-sketch-rank256.safetensors

    # IP-Adapters
    wget_to_folder "$MODELS_PATH/loras/ipadapter" https://huggingface.co/h94/IP-Adapter-FaceID/raw/main/ip-adapter-faceid_sdxl_lora.safetensors
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter-FaceID/raw/main/ip-adapter-faceid-plusv2_sdxl_lora.safetensors
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter-FaceID/raw/main/ip-adapter-faceid-portrait_sdxl.safetensors

    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter-FaceID/raw/main/ip-adapter-faceid-portrait_sdxl_unnorm.bin
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter-FaceID/raw/main/ip-adapter-faceid_sdxl.bin
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter-FaceID/raw/main/ip-adapter-faceid-plusv2_sdxl.bin
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter-FaceID/raw/main/ip-adapter-faceid-portrait_sdxl.bin

    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter/raw/main/sdxl_models/ip-adapter_sdxl.safetensors
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter/raw/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter/raw/main/sdxl_models/ip-adapter-plus-face_sdxl_vit-h.safetensors
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter/raw/main/sdxl_models/ip-adapter_sdxl.safetensors
    wget_to_folder "$MODELS_PATH/ipadapter" https://huggingface.co/h94/IP-Adapter/raw/main/sdxl_models/ip-adapter_sdxl.safetensors

}
model_functions["SDXL"]=load_sdxl

# Function to load FLUX model
load_flux() {
    echo "Loading FLUX model..."
    # This is checkpoint made by Comfy. It includes VAE and CLIP
    # The original BlackForest does not include them and requires
    # loading VAE and CLIP separately
    wget_to_folder "$MODELS_PATH/checkpoints/FLUX1" https://huggingface.co/Comfy-Org/flux1-dev/resolve/main/flux1-dev-fp8.safetensors
}
model_functions["FLUX"]=load_flux

# Function to load JuggernautXL model
load_juggernautxl() {
    echo "Loading JuggernautXL v9..."
    wget_to_folder "$MODELS_PATH/checkpoints/JuggernautXL" https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors
}
model_functions["JUGGERNAUTXL"]=load_juggernautxl

# Function to load SD3.5 model
# TODO resolve unauthorized issue
load_sd35() {
    echo "Loading SD3.5 model..."
    wget_to_folder "$MODELS_PATH/checkpoints/SD35" https://huggingface.co/stabilityai/stable-diffusion-3.5-large/raw/main/sd3.5_large.safetensors

    echo "Loading CLIP models for SD3.5..."
    wget_to_folder "$MODELS_PATH/checkpoints/SD35" https://huggingface.co/stabilityai/stable-diffusion-3-medium/resolve/main/text_encoders/clip_g.safetensors
    wget_to_folder "$MODELS_PATH/checkpoints/SD35" https://huggingface.co/stabilityai/stable-diffusion-3-medium/resolve/main/text_encoders/clip_l.safetensors
    wget_to_folder "$MODELS_PATH/checkpoints/SD35" https://huggingface.co/stabilityai/stable-diffusion-3-medium/resolve/main/text_encoders/t5xxl_fp16.safetensors
}
model_functions["SD35"]=load_sd35

# Function to load CLIPs
load_clips() {
    echo "Loading CLIPs..."
    wget_to_folder "$MODELS_PATH/default" https://huggingface.co/comfyanonymous/flux_text_encoders/raw/main/clip_l.safetensors
    wget_to_folder "$MODELS_PATH/clip_vision" https://huggingface.co/stabilityai/control-lora/raw/main/revision/clip_vision_g.safetensors
    wget_to_folder "$MODELS_PATH/clip_vision" https://huggingface.co/openai/clip-vit-large-patch14/raw/main/model.safetensors
}
model_functions["CLIPs"]=load_clips

# Function to load single model
load_model() {
    model="$1"
    if [[ -n "${model_functions[$model]}" ]]; then
        ${model_functions[$model]}
    else
        echo "Unknown model name: '$model'"
        echo "Please set LOAD_MODELS to valid model names (e.g., '${!model_functions[*]}')."
    fi
}

# Show help
show_help_with_models() {
    show_help "${!model_functions[*]}"
}

if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    eval show_help_with_models
fi

# Check if required env variables are set
if [ -z "$LOAD_MODELS" ]; then
    echo "Error: LOAD_MODELS is not set"
    echo "Use -h or --help for usage information."
    exit 1
fi

if [ -z "$COMFY_DIR" ]; then
    echo "Error: COMFY_DIR is not set"
    echo "Use -h or --help for usage information."
    exit 1
fi

INSTALL_MODELS="$(INSTALL_MODELS:-1)"
if (( "$INSTALL_MODELS" == "0" )); then
    echo "INSTALL_MODELS=0. Skip installing models"
    exit 1
fi

# Define models path
export MODELS_PATH="$COMFY_DIR/models"

# Set models to all the keys if the flag is ALL
MODELS_TO_LOAD=$LOAD_MODELS
if [[ "${LOAD_MODELS[*]}" == "ALL" ]]; then
    MODELS_TO_LOAD="${!model_functions[*]}"
fi

# Iterate through the models and load them in parallel
for model in $MODELS_TO_LOAD; do
    eval load_model $model &
done
wait
