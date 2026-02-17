#!/bin/bash

# Additional Productivity Tools Installation Script
# Installs modern CLI tools and development utilities

set -e

# Source colors and functions
source "$(dirname "$0")/../setup.sh"

install_modern_cli_tools() {
    print_status "Installing modern CLI tools..."
    
    # Install Rust (for cargo-based tools)
    if ! command -v cargo &> /dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    fi
    
    # Install Node.js and npm
    if ! command -v node &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        sudo apt install -y nodejs
    fi
    
    # Install modern alternatives
    cargo install --locked \
        zoxide \
        du-dust \
        procs \
        tealdeer \
        git-delta \
        hyperfine \
        tokei \
        bottom
    
    # Install via npm
    sudo npm install -g \
        tldr \
        gtop \
        vtop \
        http-server \
        json \
        fast-cli
    
    print_success "Modern CLI tools installed"
}

install_development_tools() {
    print_status "Installing development tools..."
    
    # Install via apt
    sudo apt install -y \
        git-extras \
        tig \
        lazygit \
        jq \
        yq \
        httpie \
        curl \
        wget \
        rsync \
        tmux \
        screen \
        vim \
        neovim \
        emacs \
        code \
        docker.io \
        docker-compose
    
    # Install GitHub CLI
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh
    
    print_success "Development tools installed"
}

install_system_utilities() {
    print_status "Installing system utilities..."
    
    sudo apt install -y \
        neofetch \
        screenfetch \
        lolcat \
        figlet \
        toilet \
        fortune-mod \
        cowsay \
        sl \
        cmatrix \
        hollywood \
        asciinema \
        terminalizer \
        stress \
        stress-ng \
        lm-sensors \
        hardinfo \
        inxi \
        lshw \
        hwinfo
    
    print_success "System utilities installed"
}

install_file_managers() {
    print_status "Installing terminal file managers..."
    
    # Install file managers
    sudo apt install -y \
        ranger \
        mc \
        nnn \
        vifm
    
    # Install lf file manager
    wget -O lf.tar.gz "https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz"
    tar -xzf lf.tar.gz
    sudo mv lf /usr/local/bin/
    rm lf.tar.gz
    
    print_success "Terminal file managers installed"
}

install_multiplexers() {
    print_status "Installing terminal multiplexers..."
    
    # Install terminal multiplexers
    sudo apt install -y tmux screen
    
    # Install Zellij
    wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf zellij.tar.gz
    sudo mv zellij /usr/local/bin/
    rm zellij.tar.gz
    
    print_success "Terminal multiplexers installed"
}

configure_git() {
    print_status "Configuring Git with useful aliases..."
    
    # Set up Git aliases for productivity
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.visual '!gitk'
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    git config --global alias.tree "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
    
    # Set up Delta as diff tool if installed
    if command -v delta &> /dev/null; then
        git config --global core.pager delta
        git config --global interactive.diffFilter 'delta --color-only'
        git config --global delta.navigate true
        git config --global merge.conflictstyle diff3
        git config --global diff.colorMoved default
    fi
    
    print_success "Git configured with productivity aliases"
}

main() {
    print_status "Starting productivity tools installation..."
    
    install_modern_cli_tools
    install_development_tools
    install_system_utilities
    install_file_managers
    install_multiplexers
    configure_git
    
    print_success "Productivity tools installation completed!"
    print_status "Restart your terminal to use all new tools"
}

# Run only if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi