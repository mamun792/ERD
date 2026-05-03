#!/bin/bash

# Terminal Performance Optimization Script
# Optimizes terminal performance and responsiveness

set -e

# Source colors and functions
source "$(dirname "$0")/../setup.sh"

optimize_terminal_settings() {
    print_status "Optimizing terminal settings..."
    
    # Create terminal profile backup
    dconf dump /org/gnome/terminal/ > "$HOME/gnome-terminal-backup.dconf"
    
    # Optimize GNOME Terminal settings
    gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
    gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
    
    # Get default profile ID
    local profile_id
    profile_id=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    local profile_path="/org/gnome/terminal/legacy/profiles:/:$profile_id/"
    
    # Performance optimizations
    gsettings set org.gnome.Terminal.Legacy.Profile:$profile_path scrollback-unlimited true
    gsettings set org.gnome.Terminal.Legacy.Profile:$profile_path use-transparent-background false
    gsettings set org.gnome.Terminal.Legacy.Profile:$profile_path background-transparency-percent 0
    
    print_success "Terminal settings optimized"
}

optimize_shell_performance() {
    print_status "Optimizing shell performance..."
    
    # Create shell performance config
    cat > "$HOME/.shell_performance" << 'EOF'
# Shell Performance Optimizations

# History settings for better performance
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups

# Faster directory operations
export LS_COLORS='di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33;40:cd=1;33;40:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

# Optimize less
export LESS='-R -M -i -j5'
export LESSHISTFILE=/dev/null

# Faster grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Performance aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Modern alternatives
if command -v exa &> /dev/null; then
    alias ls='exa --color=auto'
    alias ll='exa -la --git'
    alias tree='exa --tree'
fi

if command -v bat &> /dev/null; then
    alias cat='bat --paging=never'
    alias less='bat'
fi

if command -v fd &> /dev/null; then
    alias find='fd'
fi

if command -v rg &> /dev/null; then
    alias grep='rg'
fi
EOF
    
    print_success "Shell performance optimizations created"
}

install_performance_tools() {
    print_status "Installing performance monitoring tools..."
    
    # Install additional performance tools
    sudo apt install -y \
        htop \
        iotop \
        atop \
        glances \
        ncdu \
        dstat \
        sysstat \
        speedtest-cli
    
    print_success "Performance tools installed"
}

optimize_system_performance() {
    print_status "Applying system performance optimizations..."
    
    # Create system optimization script
    cat > "$HOME/system-optimize.sh" << 'EOF'
#!/bin/bash
# System performance optimizations (run with sudo)

# Optimize swappiness
echo 'vm.swappiness=10' >> /etc/sysctl.conf

# Optimize dirty ratio for better I/O
echo 'vm.dirty_ratio=15' >> /etc/sysctl.conf
echo 'vm.dirty_background_ratio=5' >> /etc/sysctl.conf

# Optimize network
echo 'net.core.rmem_max=134217728' >> /etc/sysctl.conf
echo 'net.core.wmem_max=134217728' >> /etc/sysctl.conf

# Apply settings
sysctl -p

echo "System optimizations applied. Reboot for full effect."
EOF
    
    chmod +x "$HOME/system-optimize.sh"
    
    print_success "System optimization script created at ~/system-optimize.sh"
    print_warning "Run 'sudo ~/system-optimize.sh' to apply system optimizations"
}

create_performance_aliases() {
    print_status "Creating performance monitoring aliases..."
    
    cat > "$HOME/.performance_aliases" << 'EOF'
# Performance Monitoring Aliases

# System monitoring
alias top10='ps aux | sort -nrk 3,3 | head -n 10'
alias top10mem='ps aux | sort -nrk 4,4 | head -n 10'
alias ports='netstat -tulanp'
alias diskusage='du -h --max-depth=1 | sort -hr'
alias meminfo='free -h && echo && cat /proc/meminfo | head -20'
alias cpuinfo='lscpu && echo && cat /proc/cpuinfo | grep "model name" | head -1'

# Quick system info
alias sysinfo='echo "=== System Information ===" && uname -a && echo && lsb_release -a && echo && df -h && echo && free -h'

# Network monitoring
alias speedtest='speedtest-cli'
alias netstat-listen='netstat -tuln'
alias iptraf='sudo iptraf-ng'

# Process management
alias pstree='pstree -p'
alias killall-chrome='killall chrome'
alias killall-firefox='killall firefox'

# Disk monitoring
alias iotop='sudo iotop'
alias iostat='iostat -x 1'
EOF
    
    print_success "Performance aliases created"
}

main() {
    print_status "Starting terminal performance optimization..."
    
    optimize_terminal_settings
    optimize_shell_performance
    install_performance_tools
    optimize_system_performance
    create_performance_aliases
    
    print_success "Terminal performance optimization completed!"
    print_status "Source ~/.shell_performance and ~/.performance_aliases in your shell config"
}

# Run only if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi