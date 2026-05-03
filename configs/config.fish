# Fish Shell Configuration
# Professional setup with modern features

# Set greeting
set fish_greeting ""

# Environment variables
set -gx EDITOR vim
set -gx BROWSER firefox
set -gx TERM xterm-256color

# Add paths
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /usr/local/bin

# Performance optimizations
set -gx HISTSIZE 50000
set -gx HISTFILESIZE 100000

# Starship prompt
if command -v starship > /dev/null
    starship init fish | source
end

# Zoxide integration
if command -v zoxide > /dev/null
    zoxide init fish | source
end

# FZF integration
if command -v fzf > /dev/null
    set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
end

# Custom aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gst='git status'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'

# Modern alternatives
if command -v eza > /dev/null
    alias ls='eza --color=auto'
    alias ll='eza -la --git'
    alias tree='eza --tree'
end

if command -v bat > /dev/null
    alias cat='bat --paging=never'
    alias less='bat'
end

if command -v fd > /dev/null
    alias find='fd'
end

if command -v rg > /dev/null
    alias grep='rg'
end

if command -v procs > /dev/null
    alias ps='procs'
end

if command -v dust > /dev/null
    alias du='dust'
end

if command -v bottom > /dev/null
    alias top='btm'
end

# Performance monitoring aliases
alias top10='ps aux | sort -nrk 3,3 | head -n 10'
alias top10mem='ps aux | sort -nrk 4,4 | head -n 10'
alias ports='netstat -tulanp'
alias diskusage='du -h --max-depth=1 | sort -hr'
alias meminfo='free -h; and echo; and cat /proc/meminfo | head -20'
alias cpuinfo='lscpu; and echo; and cat /proc/cpuinfo | grep "model name" | head -1'

# Quick system info
alias sysinfo='echo "=== System Information ==="; and uname -a; and echo; and lsb_release -a; and echo; and df -h; and echo; and free -h'

# Custom functions
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar e $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Load local configuration if exists
if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end