#!/bin/bash

# Extended Terminal Setup - Maximum features and customization
# For users who want all the bells and whistles

set -e

# Source the main setup functions
source "$(dirname "$0")/../setup.sh"

# Extended package installation including development tools
install_extended_packages() {
    print_status "Installing extended development packages..."
    
    # Add additional repositories
    sudo add-apt-repository ppa:fish-shell/release-3 -y
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    
    sudo apt update
    sudo apt install -y \
        # Core development
        build-essential \
        cmake \
        ninja-build \
        pkg-config \
        # Languages and runtimes
        python3-pip \
        python3-venv \
        nodejs \
        npm \
        golang-go \
        rustc \
        cargo \
        # Database tools
        postgresql-client \
        mysql-client \
        sqlite3 \
        redis-tools \
        # Network and security
        nmap \
        wireshark-cli \
        tcpdump \
        openssl \
        # Multimedia
        ffmpeg \
        imagemagick \
        # System tools
        strace \
        ltrace \
        gdb \
        valgrind \
        # Archive tools
        p7zip-full \
        rar \
        unrar
    
    print_success "Extended packages installed"
}

# Install advanced CLI tools
install_advanced_tools() {
    print_status "Installing advanced CLI tools..."
    
    # Install via cargo
    cargo install --locked \
        bat \
        eza \
        fd-find \
        ripgrep \
        zoxide \
        du-dust \
        procs \
        tealdeer \
        git-delta \
        hyperfine \
        tokei \
        bottom \
        bandwhich \
        grex \
        xsv \
        choose \
        sd
    
    # Install via npm
    sudo npm install -g \
        tldr \
        gtop \
        vtop \
        http-server \
        json \
        fast-cli \
        npmcheck \
        serve \
        lighthouse \
        @vue/cli \
        create-react-app \
        typescript \
        ts-node
    
    print_success "Advanced CLI tools installed"
}

# Setup development environments
setup_development_environments() {
    print_status "Setting up development environments..."
    
    # Python development
    pip3 install --user \
        virtualenv \
        pipenv \
        poetry \
        black \
        flake8 \
        pylint \
        mypy \
        jupyter \
        ipython
    
    # Node.js development
    npm install -g \
        eslint \
        prettier \
        jest \
        webpack \
        @angular/cli \
        express-generator
    
    # Go development
    if command -v go &> /dev/null; then
        go install golang.org/x/tools/gopls@latest
        go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    fi
    
    print_success "Development environments configured"
}

# Advanced shell configurations
setup_advanced_shell_config() {
    print_status "Setting up advanced shell configurations..."
    
    # Create advanced shell config
    cat > "$HOME/.advanced_shell_config" << 'EOF'
# Advanced Shell Configuration

# Enhanced history
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
shopt -s histappend

# Advanced aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias glg='git log --stat'
alias glog='git log --oneline --decorate --graph'

# Development aliases
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server'
alias json='python3 -m json.tool'

# System monitoring
alias ports='netstat -tulanp'
alias processes='ps aux | grep -v grep | grep'
alias listening='lsof -i -P -n | grep LISTEN'
alias memtop='ps aux | sort -nrk 4,4 | head'
alias cputop='ps aux | sort -nrk 3,3 | head'

# Network tools
alias myip='curl -s ifconfig.me'
alias localip='hostname -I | awk "{print \$1}"'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3'

# File operations
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias mkdir='mkdir -pv'
alias mount='mount | column -t'

# Enhanced ls with colors
export LS_COLORS='di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33;40:cd=1;33;40'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Modern tool replacements
if command -v eza &> /dev/null; then
    alias ls='eza --color=auto'
    alias ll='eza -la --git --time-style=long-iso'
    alias tree='eza --tree'
fi

if command -v bat &> /dev/null; then
    alias cat='bat --paging=never'
    alias less='bat'
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if command -v fd &> /dev/null; then
    alias find='fd'
fi

if command -v rg &> /dev/null; then
    alias grep='rg'
fi

if command -v procs &> /dev/null; then
    alias ps='procs'
fi

if command -v dust &> /dev/null; then
    alias du='dust'
fi

if command -v bottom &> /dev/null; then
    alias top='btm'
    alias htop='btm'
fi

# Functions
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

backup() {
    cp "$1"{,.bak-$(date +%Y%m%d-%H%M%S)}
}

# Development helpers
venv() {
    if [ -z "$1" ]; then
        python3 -m venv venv && source venv/bin/activate
    else
        python3 -m venv "$1" && source "$1/bin/activate"
    fi
}

server() {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

gitignore() {
    curl -sL "https://www.gitignore.io/api/$1" >> .gitignore
}
EOF

    # Add to bashrc
    if ! grep -q "source ~/.advanced_shell_config" "$HOME/.bashrc" 2>/dev/null; then
        echo "source ~/.advanced_shell_config" >> "$HOME/.bashrc"
    fi
    
    print_success "Advanced shell configuration applied"
}

# Create comprehensive system utilities
create_extended_utilities() {
    print_status "Creating extended system utilities..."
    
    mkdir -p "$HOME/.local/bin"
    
    # Advanced system info
    cat > "$HOME/.local/bin/sysinfo-extended" << 'EOF'
#!/bin/bash

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                           SYSTEM INFORMATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "🖥️  SYSTEM"
echo "   Hostname: $(hostname)"
echo "   OS: $(lsb_release -d | cut -f2)"
echo "   Kernel: $(uname -r)"
echo "   Architecture: $(uname -m)"
echo "   Uptime: $(uptime -p)"
echo "   Load: $(uptime | awk -F'load average:' '{print $2}')"
echo

echo "💾 MEMORY"
free -h | awk 'NR==2{printf "   Total: %s, Used: %s (%.2f%%), Free: %s\n", $2,$3,$3*100/$2,$7}'
echo

echo "💿 STORAGE"
df -h | awk '$NF=="/"{printf "   Root: %s/%s (%s)\n", $3,$2,$5}'
echo "   Disk Usage: $(du -sh ~ 2>/dev/null | cut -f1) (home directory)"
echo

echo "🌐 NETWORK"
echo "   Local IP: $(hostname -I | awk '{print $1}')"
echo "   Public IP: $(curl -s ifconfig.me 2>/dev/null || echo 'N/A')"
echo "   Gateway: $(route -n | grep '^0.0.0.0' | awk '{print $2}')"
echo

echo "🔧 HARDWARE"
echo "   CPU: $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "   Cores: $(nproc) cores"
echo "   GPU: $(lspci | grep -i vga | cut -d':' -f3 | xargs)"
echo

echo "🐳 SERVICES"
if command -v docker &> /dev/null; then
    echo "   Docker: $(docker --version 2>/dev/null | cut -d' ' -f3 | cut -d',' -f1)"
fi
if command -v node &> /dev/null; then
    echo "   Node.js: $(node --version)"
fi
if command -v python3 &> /dev/null; then
    echo "   Python: $(python3 --version | cut -d' ' -f2)"
fi
if command -v git &> /dev/null; then
    echo "   Git: $(git --version | cut -d' ' -f3)"
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
EOF
    chmod +x "$HOME/.local/bin/sysinfo-extended"
    
    # Development environment checker
    cat > "$HOME/.local/bin/devcheck" << 'EOF'
#!/bin/bash

echo "🔍 DEVELOPMENT ENVIRONMENT CHECK"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Languages
echo "📚 LANGUAGES:"
for cmd in python3 node go rust java javac gcc g++ php ruby; do
    if command -v $cmd &> /dev/null; then
        case $cmd in
            python3) echo "   ✅ Python: $(python3 --version | cut -d' ' -f2)" ;;
            node) echo "   ✅ Node.js: $(node --version)" ;;
            go) echo "   ✅ Go: $(go version | awk '{print $3}')" ;;
            rust) echo "   ✅ Rust: $(rustc --version | awk '{print $2}')" ;;
            java) echo "   ✅ Java: $(java -version 2>&1 | head -1 | awk '{print $3}' | tr -d '"')" ;;
            *) echo "   ✅ $cmd: installed" ;;
        esac
    else
        echo "   ❌ $cmd: not installed"
    fi
done

echo
echo "🛠️  TOOLS:"
for cmd in git docker npm yarn pip3 cargo; do
    if command -v $cmd &> /dev/null; then
        echo "   ✅ $cmd: installed"
    else
        echo "   ❌ $cmd: not installed"
    fi
done

echo
echo "📦 PACKAGE MANAGERS:"
for cmd in apt snap flatpak brew; do
    if command -v $cmd &> /dev/null; then
        echo "   ✅ $cmd: available"
    else
        echo "   ❌ $cmd: not available"
    fi
done
EOF
    chmod +x "$HOME/.local/bin/devcheck"
    
    print_success "Extended utilities created"
}

main() {
    print_status "Starting extended terminal setup..."
    
    install_extended_packages
    install_advanced_tools
    setup_development_environments
    setup_advanced_shell_config
    create_extended_utilities
    
    print_success "Extended setup completed!"
    print_status "Available commands: sysinfo-extended, devcheck"
    print_status "Restart terminal to use all new features"
}

main "$@"