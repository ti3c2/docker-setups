#!/bin/bash

# Clone the repository
git clone https://github.com/ti3c2/docker-setups.git /INIT

# Create a symlink to setup-scripts in the root directory
ln -s /INIT/setup-scripts /setup-scripts

# Make scripts executable
chmod -R +x /setup-scripts/

# Execute
cd /setup-scripts
bash setup.sh
