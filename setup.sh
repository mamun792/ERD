#!/bin/bash

# Ubuntu Terminal Setup - Main Installation Script
# This script sets up a professional terminal environment with performance optimizations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Ubuntu
check_ubuntu() {
    if [[ ! -f /etc/lsb-release ]] || ! grep -q "Ubuntu" /etc/lsb-release; then
        print_error "This script is designed for Ubuntu systems only."
        exit 1
    fi
    print_success "Ubuntu system detected"
}

# Update system packages
update_system() {
    print_status "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    print_success "System packages updated"
}

# Install essential packages
install_essentials() {
    print_status "Installing essential packages..."
    sudo apt install -y \
        curl \
        wget \
        git \
        build-essential \
        software-properties-common \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release \
        unzip \
        tree \
        htop \
        neofetch \
        bat \
        eza \
        fd-find \
        ripgrep \
        fzf \
        tmux \
        vim \
        neovim \
        zsh \
        fish
    print_success "Essential packages installed"
}

# Main installation function
main() {
    print_status "Starting Ubuntu Terminal Setup..."
    
    check_ubuntu
    update_system
    install_essentials
    
    print_success "Basic setup completed! Run specific configuration scripts for detailed customization."
    print_status "Available scripts:"
    echo "  - ./scripts/install-zsh.sh      # Install and configure Zsh with Oh My Zsh"
    echo "  - ./scripts/install-fish.sh     # Install and configure Fish shell"
    echo "  - ./scripts/optimize-terminal.sh # Terminal performance optimizations"
    echo "  - ./scripts/install-tools.sh    # Additional productivity tools"
    echo "  - ./configs/apply-configs.sh    # Apply all configuration files"
}

# Run main function
main "$@"