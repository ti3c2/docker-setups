#!/bin/bash

# Function to display error message and exit
error_exit() {
    echo "$1" 1>&2
    exit 1
}

# Parse command-line arguments
# TODO Remove this mess
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --from-env)
            # Load environment variables from .env file
            if [ -f ".env" ]; then
                export "$(grep -v '^#' .env | xargs)"
            else
                error_exit "Error: .env file not found. Please create it with the required variables."
            fi
            ;;
        *)
            error_exit "Unknown option: $1"
            ;;
    esac
    shift
done

# Set alias for setup-scripts directory
export SETUP_SCRIPTS_DIR="${SETUP_SCRIPTS_DIR:-$INIT_DIR/setup-scripts}"

# Conditional script execution based on environment variables
if [ "$SETUP_HOME" == "1" ]; then
    echo "Running home setup..."
    bash "$SETUP_SCRIPTS_DIR/setup-home/setup-home.sh"
else
    echo "Skipping home setup..."
fi

if [ "$SETUP_PYTHON" == "1" ]; then
    echo "Running Python setup..."
    bash "$SETUP_SCRIPTS_DIR/setup-python/install-python-pyenv.sh"
else
    echo "Skipping Python setup..."
fi

if [ "$SETUP_COMFYUI" == "1" ]; then
    echo "Running ComfyUI setup..."
    bash "$SETUP_SCRIPTS_DIR/setup-comfyui/setup-comfyui.sh"
else
    echo "Skipping Python setup..."
fi

# Start the fish shell or any command
exec fish
