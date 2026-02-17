# Ubuntu Terminal Customization and Performance Setup

A comprehensive toolkit for setting up a professional Ubuntu terminal environment with enhanced performance, modern tools, and productivity features.

## 🚀 Quick Start

```bash
# Clone or download this repository
git clone <repository-url>
cd ubuntu-terminal-setup

# Make scripts executable
chmod +x setup.sh
chmod +x scripts/*.sh
chmod +x configs/apply-configs.sh

# Run the main setup
./setup.sh
```

## 📁 Project Structure

```
ubuntu-terminal-setup/
├── setup.sh                     # Main installation script
├── scripts/
│   ├── install-zsh.sh          # Zsh with Oh My Zsh setup
│   ├── install-fish.sh         # Fish shell setup
│   ├── optimize-terminal.sh    # Performance optimizations
│   └── install-tools.sh        # Modern CLI tools
├── configs/
│   ├── .zshrc                  # Zsh configuration
│   ├── config.fish             # Fish shell configuration
│   ├── starship.toml           # Starship prompt theme
│   └── apply-configs.sh        # Configuration deployment
└── README.md                   # This file
```

## 🛠 Installation Options

### Complete Setup
```bash
./setup.sh                      # Install all essentials
./scripts/install-zsh.sh        # Setup Zsh with Oh My Zsh
./scripts/install-fish.sh       # Setup Fish shell
./scripts/optimize-terminal.sh  # Apply performance optimizations
./scripts/install-tools.sh      # Install modern CLI tools
./configs/apply-configs.sh      # Apply all configurations
```

### Individual Components

#### Shell Setup
```bash
./scripts/install-zsh.sh        # Zsh + Oh My Zsh + Powerlevel10k
./scripts/install-fish.sh       # Fish + Starship + plugins
```

#### Performance Optimization
```bash
./scripts/optimize-terminal.sh  # Terminal and system optimizations
```

#### Modern Tools
```bash
./scripts/install-tools.sh      # CLI tools and development utilities
```

## ✨ Features

### Shell Enhancements
- **Zsh with Oh My Zsh**: Popular framework with extensive plugin ecosystem
- **Fish Shell**: User-friendly shell with smart autocompletion
- **Powerlevel10k**: Fast and customizable Zsh theme
- **Starship**: Modern, minimal prompt for any shell

### Modern CLI Tools
- **File Management**: `eza`, `fd`, `bat`, `lf`, `ranger`
- **System Monitoring**: `htop`, `btm`, `procs`, `dust`
- **Development**: `git-delta`, `gh` (GitHub CLI), `lazygit`
- **Utilities**: `fzf`, `ripgrep`, `zoxide`, `tldr`

### Performance Optimizations
- Terminal settings optimization
- Shell history improvements
- System performance tuning
- Memory and I/O optimizations

### Productivity Features
- Smart autocompletion and suggestions
- Git integration and aliases
- Directory navigation improvements
- Custom utility functions
- Performance monitoring aliases

## 🎨 Customization

### Zsh Configuration
The `.zshrc` file includes:
- Oh My Zsh with optimized plugins
- Custom aliases and functions
- Performance optimizations
- FZF integration

### Fish Configuration
The `config.fish` includes:
- Modern tool aliases
- Custom functions
- Starship prompt integration
- Performance enhancements

### Adding Custom Configurations
1. Edit configuration files in the `configs/` directory
2. Run `./configs/apply-configs.sh` to apply changes
3. Restart your terminal or source the configuration

## 🔧 Performance Tuning

### System Optimizations
The setup includes:
- Swappiness optimization (reduces swap usage)
- I/O scheduler improvements
- Network stack optimizations
- Memory management tuning

### Terminal Optimizations
- Disabled unnecessary visual effects
- Optimized scrollback settings
- Performance-focused plugin selection
- Efficient history management

## 📋 Included Tools

### System Monitoring
- `htop`, `btm` - Interactive process viewers
- `iotop` - I/O monitoring
- `glances` - System monitoring
- `neofetch` - System information

### File Operations
- `eza` - Modern `ls` replacement
- `bat` - `cat` with syntax highlighting
- `fd` - Fast `find` alternative
- `ripgrep` - Fast text search
- `lf`, `ranger` - Terminal file managers

### Development Tools
- `git-delta` - Better git diffs
- `gh` - GitHub CLI
- `lazygit` - Git TUI
- `tmux` - Terminal multiplexer
- `neovim` - Modern Vim

### Network & Web
- `httpie` - User-friendly HTTP client
- `speedtest-cli` - Internet speed testing
- `curl`, `wget` - Download utilities

## 🎯 Usage Examples

### Quick System Information
```bash
sysinfo                         # Custom system info script
neofetch                        # Detailed system information
```

### File Operations
```bash
eza -la --git                   # Enhanced file listing
bat filename                    # View file with syntax highlighting
fd searchterm                   # Fast file search
rg "pattern" .                  # Fast text search
```

### Git Workflow
```bash
git lg                          # Beautiful git log
git tree                        # Git history tree
lazygit                         # Git TUI
```

### System Monitoring
```bash
btm                             # Beautiful system monitor
procs                           # Modern process viewer
dust                            # Disk usage analyzer
```

## 🔒 Safety Features

- **Automatic Backups**: Original configurations are backed up before modification
- **Non-destructive**: Scripts check for existing installations
- **Rollback Support**: Backup directories with timestamps
- **Permission Checks**: Scripts verify proper permissions

## 🐛 Troubleshooting

### Common Issues

#### Zsh not loading properly
```bash
# Reset Zsh configuration
cp ~/.zshrc.backup.* ~/.zshrc
exec zsh
```

#### Missing tools
```bash
# Re-run tool installation
./scripts/install-tools.sh
```

#### Performance issues
```bash
# Check system resources
htop
# Review active plugins in shell config
```

### Reset to Defaults
```bash
# Restore from backup
ls ~/.config_backup_*           # List available backups
cp ~/.config_backup_*/.*rc ~/   # Restore configurations
```

## 📖 Documentation

### Configuration Files
- `.zshrc` - Zsh shell configuration
- `config.fish` - Fish shell configuration  
- `starship.toml` - Starship prompt theme
- `.shell_performance` - Performance optimizations
- `.performance_aliases` - Monitoring aliases

### Scripts
- `setup.sh` - Main installation script
- `install-*.sh` - Component-specific installers
- `optimize-terminal.sh` - Performance tuning
- `apply-configs.sh` - Configuration deployment

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on a clean Ubuntu system
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Oh My Zsh community
- Fish shell developers
- Starship maintainers
- Modern CLI tool creators
- Ubuntu community

## 📞 Support

If you encounter issues:
1. Check the troubleshooting section
2. Review script output for errors
3. Create an issue with system details
4. Check existing configurations

---

**Note**: Always review scripts before running them on your system. This setup is tested on Ubuntu 20.04+ but should work on other Ubuntu versions and Debian-based distributions.