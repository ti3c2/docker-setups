# Use the lightweight version of Ubuntu
FROM ubuntu:22.04

# Set the environment variable DEBIAN_FRONTEND to noninteractive
# This prevents prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Run update
RUN apt-get update

# Install essentials
RUN apt-get install -y --no-install-recommends \
    # Install git. Resolve issue with ca-certificates
    git ca-certificates \
    # Install Neovim Build essentials
    ninja-build gettext cmake unzip curl build-essential \
    # Install thing responsible for apt-add-repository
    software-properties-common \
    # Don't remember what this does
    gnupg \
    && \
    # Clean apt cache
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone dotfiles
RUN git clone https://github.com/poqushoi/my-dotfiles /root/dotfiles && \
    # Create a symlink from /root/.config to /root/dotfiles/.config
    ln -s /root/dotfiles/.config /root/.config

# Clone and build Neovim
RUN git clone https://github.com/neovim/neovim /tmp/neovim && \
    cd /tmp/neovim && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install && \
    rm -rf /tmp/neovim

# Install nerd-fonts
# RUN apt-get install getnf && getNF 26

# Install fish from the PPA
RUN apt-add-repository ppa:fish-shell/release-3 && \
    apt-get update && \
    apt-get install -y --no-install-recommends fish && \
    chsh -s $(which fish) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the default shell to bash
CMD ["fish"]
