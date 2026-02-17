#!/bin/bash

# Minimal Terminal Setup - Basic optimizations only
# For users who want minimal changes with maximum compatibility

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Minimal package installation
install_minimal_packages() {
    print_status "Installing minimal essential packages..."
    sudo apt update
    sudo apt install -y \
        curl \
        wget \
        git \
        vim \
        htop \
        tree \
        unzip
    print_success "Minimal packages installed"
}

# Basic shell optimizations only
apply_basic_optimizations() {
    print_status "Applying basic shell optimizations..."
    
    # Create minimal performance config
    cat > "$HOME/.minimal_shell_config" << 'EOF'
# Minimal Shell Performance Config

# Basic history settings
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth

# Basic aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias grep='grep --color=auto'

# Simple prompt enhancement
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
EOF

    # Add to bashrc
    if ! grep -q "source ~/.minimal_shell_config" "$HOME/.bashrc" 2>/dev/null; then
        echo "source ~/.minimal_shell_config" >> "$HOME/.bashrc"
    fi
    
    print_success "Basic optimizations applied"
}

# Create simple system info command
create_simple_sysinfo() {
    print_status "Creating simple system info command..."
    
    mkdir -p "$HOME/.local/bin"
    cat > "$HOME/.local/bin/info" << 'EOF'
#!/bin/bash
echo "System: $(lsb_release -d | cut -f2)"
echo "Uptime: $(uptime -p)"
echo "Memory: $(free -h | grep 'Mem:' | awk '{print $3"/"$2}')"
echo "Disk: $(df -h / | tail -1 | awk '{print $3"/"$2" ("$5")"}')"
EOF
    chmod +x "$HOME/.local/bin/info"
    
    print_success "Simple system info created (use 'info' command)"
}

main() {
    print_status "Starting minimal terminal setup..."
    
    install_minimal_packages
    apply_basic_optimizations
    create_simple_sysinfo
    
    print_success "Minimal setup completed!"
    print_status "Restart terminal or run 'source ~/.bashrc' to apply changes"
    print_status "Available commands: info, ll, la"
}

main "$@"