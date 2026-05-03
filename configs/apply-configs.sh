#!/bin/bash

# Configuration Application Script
# Applies all configuration files to the system

set -e

# Source colors and functions
source "$(dirname "$0")/../setup.sh"

apply_shell_configs() {
    print_status "Applying shell configurations..."
    
    # Backup existing configurations
    backup_dir="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    # Backup existing configs
    [[ -f "$HOME/.zshrc" ]] && cp "$HOME/.zshrc" "$backup_dir/"
    [[ -f "$HOME/.bashrc" ]] && cp "$HOME/.bashrc" "$backup_dir/"
    [[ -f "$HOME/.config/fish/config.fish" ]] && cp "$HOME/.config/fish/config.fish" "$backup_dir/"
    [[ -f "$HOME/.config/starship.toml" ]] && cp "$HOME/.config/starship.toml" "$backup_dir/"
    
    # Apply new configurations
    cp "$(dirname "$0")/.zshrc" "$HOME/.zshrc"
    
    # Fish configuration
    mkdir -p "$HOME/.config/fish"
    cp "$(dirname "$0")/config.fish" "$HOME/.config/fish/config.fish"
    
    # Starship configuration
    cp "$(dirname "$0")/starship.toml" "$HOME/.config/starship.toml"
    
    print_success "Shell configurations applied"
    print_status "Backup created at: $backup_dir"
}

apply_git_config() {
    print_status "Applying Git configuration..."
    
    # Apply Git configuration if file exists
    if [[ -f "$(dirname "$0")/gitconfig" ]]; then
        cp "$(dirname "$0")/gitconfig" "$HOME/.gitconfig"
        print_success "Git configuration applied"
    else
        print_warning "Git configuration file not found, skipping..."
    fi
}

apply_tmux_config() {
    print_status "Applying Tmux configuration..."
    
    # Apply Tmux configuration if file exists
    if [[ -f "$(dirname "$0")/tmux.conf" ]]; then
        cp "$(dirname "$0")/tmux.conf" "$HOME/.tmux.conf"
        print_success "Tmux configuration applied"
    else
        print_warning "Tmux configuration file not found, skipping..."
    fi
}

apply_vim_config() {
    print_status "Applying Vim configuration..."
    
    # Apply Vim configuration if file exists
    if [[ -f "$(dirname "$0")/vimrc" ]]; then
        cp "$(dirname "$0")/vimrc" "$HOME/.vimrc"
        print_success "Vim configuration applied"
    else
        print_warning "Vim configuration file not found, skipping..."
    fi
}

create_custom_scripts() {
    print_status "Creating custom utility scripts..."
    
    # Create bin directory
    mkdir -p "$HOME/.local/bin"
    
    # Create system info script
    cat > "$HOME/.local/bin/sysinfo" << 'EOF'
#!/bin/bash
# Custom system information script

echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "OS: $(lsb_release -d | cut -f2)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Shell: $SHELL"
echo

echo "=== Hardware Information ==="
echo "CPU: $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "Memory: $(free -h | grep 'Mem:' | awk '{print $2}')"
echo "Disk: $(df -h / | tail -1 | awk '{print $2}')"
echo

echo "=== Network Information ==="
echo "IP Address: $(hostname -I | awk '{print $1}')"
echo "Public IP: $(curl -s ifconfig.me 2>/dev/null || echo 'N/A')"
echo

echo "=== Performance ==="
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "Memory Usage: $(free | grep Mem | awk '{printf("%.2f%%", $3/$2 * 100.0)}')"
echo "Disk Usage: $(df / | tail -1 | awk '{print $5}')"
EOF
    
    chmod +x "$HOME/.local/bin/sysinfo"
    
    print_success "Custom utility scripts created"
}

reload_configurations() {
    print_status "Reloading configurations..."
    
    # Source performance optimizations if they exist
    [[ -f "$HOME/.shell_performance" ]] && source "$HOME/.shell_performance"
    [[ -f "$HOME/.performance_aliases" ]] && source "$HOME/.performance_aliases"
    
    print_success "Configurations reloaded"
}

main() {
    print_status "Starting configuration application..."
    
    apply_shell_configs
    apply_git_config
    apply_tmux_config
    apply_vim_config
    create_custom_scripts
    reload_configurations
    
    print_success "All configurations applied successfully!"
    print_status "Restart your terminal or run 'exec \$SHELL' to use new configurations"
    print_status "Available custom commands:"
    echo "  - sysinfo           # Display system information"
    echo "  - source ~/.zshrc   # Reload Zsh configuration"
    echo "  - fish              # Switch to Fish shell"
}

# Run only if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi