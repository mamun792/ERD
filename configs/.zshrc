# Zsh Configuration for Professional Development
# Optimized for performance and productivity

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    docker
    docker-compose
    npm
    node
    python
    pip
    virtualenv
    ubuntu
    command-not-found
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    fzf
    tmux
    history
    copypath
    copyfile
    dirhistory
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor
export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Performance optimizations
source ~/.shell_performance 2>/dev/null || true
source ~/.performance_aliases 2>/dev/null || true

# Custom aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias reload="source ~/.zshrc"

# Modern CLI tool aliases
# Modern alternatives
if command -v eza &> /dev/null; then
    alias ls='eza --color=auto'
    alias ll='eza -la --git'
    alias tree='eza --tree'
fi

# FZF configuration
if command -v fzf &> /dev/null; then
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Auto-completion for various tools
autoload -U compinit && compinit

# History configuration
HISTSIZE=50000
HISTFILESIZE=100000
SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# Directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# Auto-completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Key bindings
bindkey '^[[1;5C' forward-word                    # Ctrl+Right
bindkey '^[[1;5D' backward-word                   # Ctrl+Left
bindkey '^[[3~' delete-char                       # Delete
bindkey '^[[H' beginning-of-line                  # Home
bindkey '^[[F' end-of-line                        # End

# Custom functions
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

function extract() {
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
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Load custom local configurations
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh