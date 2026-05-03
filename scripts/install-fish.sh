#!/bin/bash

# Fish Shell Installation and Configuration Script
# Installs Fish shell with modern features and configurations

set -e

# Source colors and functions
source "$(dirname "$0")/../setup.sh"

install_fish() {
    print_status "Installing Fish shell..."
    
    # Add Fish PPA for latest version
    sudo apt-add-repository ppa:fish-shell/release-3 -y
    sudo apt update
    sudo apt install -y fish
    
    print_success "Fish shell installed"
}

install_fisher() {
    print_status "Installing Fisher (Fish plugin manager)..."
    
    # Install Fisher
    fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
    
    print_success "Fisher installed"
}

install_fish_plugins() {
    print_status "Installing Fish plugins..."
    
    # Install popular Fish plugins
    fish -c "fisher install jethrokuan/z"                    # Directory jumping
    fish -c "fisher install jorgebucaran/autopair.fish"     # Auto-pairing brackets
    fish -c "fisher install PatrickF1/fzf.fish"             # FZF integration
    fish -c "fisher install franciscolourenco/done"         # Notifications when commands finish
    fish -c "fisher install decors/fish-colored-man"        # Colored man pages
    
    print_success "Fish plugins installed"
}

configure_fish() {
    print_status "Configuring Fish shell..."
    
    # Create Fish config directory
    mkdir -p "$HOME/.config/fish"
    
    # Copy Fish configuration
    cp "$(dirname "$0")/../configs/config.fish" "$HOME/.config/fish/config.fish"
    
    # Copy Fish functions
    cp -r "$(dirname "$0")/../configs/fish/functions" "$HOME/.config/fish/" 2>/dev/null || true
    
    print_success "Fish shell configured"
}

install_starship() {
    print_status "Installing Starship prompt..."
    
    # Install Starship
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    
    # Copy Starship configuration
    mkdir -p "$HOME/.config"
    cp "$(dirname "$0")/../configs/starship.toml" "$HOME/.config/starship.toml"
    
    print_success "Starship prompt installed"
}

main() {
    print_status "Starting Fish shell setup..."
    
    install_fish
    install_fisher
    install_fish_plugins
    configure_fish
    install_starship
    
    print_success "Fish shell setup completed!"
    print_status "Run 'fish' to start using Fish shell"
    print_status "To set as default: chsh -s $(which fish)"
}

# Run only if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi