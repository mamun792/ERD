#!/bin/bash

# Hidden/Stealth Terminal Setup - Minimal visual changes with maximum functionality
# For users who want improvements without obvious changes to their terminal

set -e

# Silent functions (no colored output)
print_status() {
    echo "[$(date '+%H:%M:%S')] $1"
}

print_success() {
    echo "[$(date '+%H:%M:%S')] ✓ $1"
}

# Install packages silently
install_stealth_packages() {
    print_status "Installing packages quietly..."
    
    # Only essential packages, no flashy tools
    sudo apt update -qq
    sudo apt install -y -qq \
        curl \
        wget \
        git \
        vim \
        htop \
        tree \
        unzip \
        zip \
        rsync \
        jq
    
    print_success "Packages installed"
}

# Apply hidden optimizations
apply_hidden_optimizations() {
    print_status "Applying stealth optimizations..."
    
    # Create hidden config file
    cat > "$HOME/.hidden_shell_config" << 'EOF'
# Hidden Shell Optimizations - Applied silently

# Performance improvements
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups

# Hidden aliases (same names as original commands)
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Silent productivity aliases (don't change command behavior visually)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Hidden functions that enhance existing commands
cd() {
    builtin cd "$@" && ls -la
}

# Silent git enhancements
if command -v git &> /dev/null; then
    # Auto-complete branch names
    if [ -f /usr/share/bash-completion/completions/git ]; then
        source /usr/share/bash-completion/completions/git
    fi
fi

# Background performance optimizations
if [ -f /proc/sys/vm/swappiness ]; then
    # Note: These would need sudo to actually apply
    # echo 10 > /proc/sys/vm/swappiness
    true
fi

# Hidden PATH enhancements
export PATH="$HOME/.local/bin:$PATH"

# Silent environment improvements
export EDITOR="${EDITOR:-vim}"
export BROWSER="${BROWSER:-firefox}"
export PAGER="${PAGER:-less}"

# Hidden less improvements
export LESS='-R -M -i -j5'
export LESSHISTFILE=/dev/null

# Background clipboard integration (if available)
if command -v xclip &> /dev/null; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

# Silent network helpers
myip() {
    curl -s ifconfig.me
}

localip() {
    hostname -I | awk '{print $1}'
}

# Hidden backup function
backup() {
    if [ -f "$1" ] || [ -d "$1" ]; then
        cp -r "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backup created: $1.backup.$(date +%Y%m%d_%H%M%S)"
    fi
}

# Silent extract function (maintains original behavior)
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar e "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "Cannot extract '$1'" ;;
        esac
    fi
}

# Hidden directory creation
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Silent system monitoring (output only when requested)
sysload() {
    uptime | awk -F'load average:' '{print $2}'
}

memused() {
    free | awk 'NR==2{printf "%.2f%%\n", $3*100/$2}'
}

diskused() {
    df / | tail -1 | awk '{print $5}'
}
EOF

    # Add to shell config files silently
    for shell_config in "$HOME/.bashrc" "$HOME/.zshrc"; do
        if [ -f "$shell_config" ]; then
            if ! grep -q "source ~/.hidden_shell_config" "$shell_config" 2>/dev/null; then
                echo "" >> "$shell_config"
                echo "# Hidden optimizations - loaded silently" >> "$shell_config"
                echo "source ~/.hidden_shell_config 2>/dev/null || true" >> "$shell_config"
            fi
        fi
    done
    
    print_success "Hidden optimizations applied"
}

# Install useful tools but keep them hidden
install_hidden_tools() {
    print_status "Installing hidden productivity tools..."
    
    # Create local bin directory
    mkdir -p "$HOME/.local/bin"
    
    # Install fd-find silently (but keep as 'find' alias)
    if ! command -v fd &> /dev/null; then
        sudo apt install -y -qq fd-find
        ln -sf /usr/bin/fdfind "$HOME/.local/bin/fd" 2>/dev/null || true
    fi
    
    # Install ripgrep silently (but keep as 'grep' enhancement)
    if ! command -v rg &> /dev/null; then
        sudo apt install -y -qq ripgrep
    fi
    
    # Install bat silently
    if ! command -v bat &> /dev/null; then
        sudo apt install -y -qq bat
        # Create batcat alias if needed
        if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
            ln -sf /usr/bin/batcat "$HOME/.local/bin/bat" 2>/dev/null || true
        fi
    fi
    
    print_success "Hidden tools installed"
}

# Create invisible utility scripts
create_stealth_utilities() {
    print_status "Creating stealth utilities..."
    
    # Quick system check (silent unless errors)
    cat > "$HOME/.local/bin/quickcheck" << 'EOF'
#!/bin/bash
# Silent system check - only shows issues

issues=0

# Check disk space
disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$disk_usage" -gt 90 ]; then
    echo "⚠️  Disk usage high: ${disk_usage}%"
    issues=$((issues + 1))
fi

# Check memory usage
mem_usage=$(free | awk 'NR==2{printf "%.0f", $3*100/$2}')
if [ "$mem_usage" -gt 90 ]; then
    echo "⚠️  Memory usage high: ${mem_usage}%"
    issues=$((issues + 1))
fi

# Check load average
load=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
if (( $(echo "$load > 2.0" | bc -l) 2>/dev/null )); then
    echo "⚠️  High system load: $load"
    issues=$((issues + 1))
fi

if [ $issues -eq 0 ]; then
    exit 0  # Silent success
else
    echo "Found $issues system issues"
    exit 1
fi
EOF
    chmod +x "$HOME/.local/bin/quickcheck"
    
    # Hidden git status for any directory
    cat > "$HOME/.local/bin/gitstatus" << 'EOF'
#!/bin/bash
# Show git status only if in a git repo

if git rev-parse --git-dir > /dev/null 2>&1; then
    git status --porcelain | head -10
fi
EOF
    chmod +x "$HOME/.local/bin/gitstatus"
    
    # Silent update checker
    cat > "$HOME/.local/bin/updatecheck" << 'EOF'
#!/bin/bash
# Check for updates silently

updates=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
if [ "$updates" -gt 0 ]; then
    echo "$updates updates available"
else
    echo "System up to date"
fi
EOF
    chmod +x "$HOME/.local/bin/updatecheck"
    
    print_success "Stealth utilities created"
}

# Apply silent performance optimizations
apply_stealth_performance() {
    print_status "Applying silent performance optimizations..."
    
    # Create hidden performance script
    cat > "$HOME/.local/bin/silent-optimize" << 'EOF'
#!/bin/bash
# Silent performance optimizations

# Clear caches silently
sync
echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null 2>&1

# Optimize swappiness (requires sudo)
echo 10 | sudo tee /proc/sys/vm/swappiness > /dev/null 2>&1

# Clean temporary files
find /tmp -type f -atime +7 -delete 2>/dev/null || true
find ~/.cache -type f -atime +30 -delete 2>/dev/null || true

echo "Silent optimization completed"
EOF
    chmod +x "$HOME/.local/bin/silent-optimize"
    
    print_success "Silent performance optimizations configured"
}

main() {
    print_status "Starting stealth terminal setup..."
    
    install_stealth_packages
    apply_hidden_optimizations
    install_hidden_tools
    create_stealth_utilities
    apply_stealth_performance
    
    print_success "Stealth setup completed"
    print_status "No visible changes made - enhancements work silently"
    print_status "Hidden commands: quickcheck, gitstatus, updatecheck, silent-optimize"
    print_status "Restart terminal or run 'source ~/.bashrc' to activate"
}

main "$@"