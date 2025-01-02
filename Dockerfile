# FROM ubuntu:22.04
FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# Set the environment variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages for running scripts
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # Install git. Resolve issue with ca-certificates
    git git-lfs ca-certificates \
    # Install Neovim Build essentials
    ninja-build gettext cmake unzip curl wget build-essential \
    # Install thing responsible for apt-add-repository
    software-properties-common \
    # Basic CLI tools
    vim ncdu \
    && \
    # Clean apt cache
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Setup environment variables
ENV PATH=$HOME/.pyenv/shims:$HOME/.pyenv/bin:$PATH
ENV COMFY_DIR=$HOME/comfyui

# Copy the setup scripts into the Docker image
COPY ./init.sh /init.sh
# COPY ./setup-scripts /setup-scripts

# Make scripts executable
RUN chmod +x /init.sh
# RUN chmod -R +x /setup-scripts/*

# python main.py --cpu --listen 0.0.0.0 --port 7860
