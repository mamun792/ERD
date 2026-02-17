#!/bin/bash

# Zsh Installation and Configuration Script
# Installs Zsh, Oh My Zsh, and popular plugins for enhanced productivity

set -e

# Source colors and functions
source "$(dirname "$0")/../setup.sh"

install_zsh() {
    print_status "Installing Zsh..."
    
    # Install Zsh if not already installed
    if ! command -v zsh &> /dev/null; then
        sudo apt install -y zsh
    fi
    
    print_success "Zsh installed"
}

install_oh_my_zsh() {
    print_status "Installing Oh My Zsh..."
    
    # Check if Oh My Zsh is already installed
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        print_warning "Oh My Zsh already installed, skipping..."
        return
    fi
    
    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    print_success "Oh My Zsh installed"
}

install_zsh_plugins() {
    print_status "Installing Zsh plugins..."
    
    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    # Install zsh-autosuggestions
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    fi
    
    # Install zsh-syntax-highlighting
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    fi
    
    # Install zsh-completions
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]]; then
        git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
    fi
    
    # Install powerlevel10k theme
    if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    fi
    
    print_success "Zsh plugins installed"
}

configure_zshrc() {
    print_status "Configuring .zshrc..."
    
    # Backup existing .zshrc
    if [[ -f "$HOME/.zshrc" ]]; then
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Copy our custom .zshrc
    cp "$(dirname "$0")/../configs/.zshrc" "$HOME/.zshrc"
    
    print_success ".zshrc configured"
}

set_default_shell() {
    print_status "Setting Zsh as default shell..."
    
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        chsh -s "$(which zsh)"
        print_success "Zsh set as default shell (restart terminal to take effect)"
    else
        print_warning "Zsh already set as default shell"
    fi
}

main() {
    print_status "Starting Zsh setup..."
    
    install_zsh
    install_oh_my_zsh
    install_zsh_plugins
    configure_zshrc
    set_default_shell
    
    print_success "Zsh setup completed!"
    print_status "Restart your terminal or run 'exec zsh' to start using Zsh"
}

# Run only if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi