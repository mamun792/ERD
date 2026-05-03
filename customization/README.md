# Terminal Customization Options

This directory contains different setup configurations for various user preferences and needs.

## 🎯 Setup Options

### 1. Minimal Setup (`minimal-setup.sh`)
**For users who want basic improvements with maximum compatibility**

**Features:**
- Essential packages only (curl, wget, git, vim, htop, tree)
- Basic shell optimizations and aliases
- Simple system info command
- Minimal visual changes
- Fast installation

**Best for:**
- Servers and production systems
- Users with limited permissions
- Minimal system footprint requirements
- Quick setup without complications

**Commands added:**
- `info` - Simple system information
- Basic aliases: `ll`, `la`, `..`

---

### 2. Extended Setup (`extended-setup.sh`)
**For developers who want maximum features and tools**

**Features:**
- Complete development environment
- Advanced CLI tools (bat, eza, fd, ripgrep, etc.)
- Multiple programming language support
- Comprehensive aliases and functions
- Development utilities and helpers
- Advanced system monitoring

**Best for:**
- Development workstations
- Power users and developers
- Full-featured terminal experience
- Learning new tools and workflows

**Commands added:**
- `sysinfo-extended` - Comprehensive system information
- `devcheck` - Development environment checker
- 100+ aliases and functions
- Modern tool replacements

---

### 3. Stealth Setup (`stealth-setup.sh`)
**For users who want improvements without obvious changes**

**Features:**
- Hidden optimizations that work silently
- Maintains original command behavior
- Background performance improvements
- Invisible utility functions
- No visual changes to terminal

**Best for:**
- Shared or corporate systems
- Users who prefer minimal visual changes
- Systems where appearance consistency matters
- Subtle productivity improvements

**Commands added:**
- `quickcheck` - Silent system health check
- `gitstatus` - Hidden git status
- `updatecheck` - Silent update checker
- `silent-optimize` - Background optimization

---

## 🚀 Quick Installation

### Run Minimal Setup
```bash
chmod +x customization/minimal-setup.sh
./customization/minimal-setup.sh
```

### Run Extended Setup
```bash
chmod +x customization/extended-setup.sh
./customization/extended-setup.sh
```

### Run Stealth Setup
```bash
chmod +x customization/stealth-setup.sh
./customization/stealth-setup.sh
```

## 📊 Comparison Table

| Feature | Minimal | Extended | Stealth |
|---------|---------|----------|---------|
| Installation Time | ~2 min | ~15 min | ~5 min |
| Disk Space | ~50MB | ~500MB | ~100MB |
| Visual Changes | Minimal | Extensive | None |
| Tools Added | 5 | 50+ | 10 |
| Aliases/Functions | 10 | 100+ | 20 |
| Development Tools | Basic | Complete | Hidden |
| Performance Impact | Low | Medium | Low |
| Learning Curve | None | High | None |

## 🔧 Customization Guidelines

### Mix and Match
You can combine features from different setups:

```bash
# Install minimal base
./customization/minimal-setup.sh

# Add specific tools from extended setup
sudo apt install bat eza fd-find ripgrep

# Apply stealth optimizations
source ~/.hidden_shell_config
```

### Override Options
Each setup creates separate config files you can modify:

- **Minimal**: `~/.minimal_shell_config`
- **Extended**: `~/.advanced_shell_config`  
- **Stealth**: `~/.hidden_shell_config`

### Disable Features
To disable any setup:

```bash
# Comment out source line in ~/.bashrc
sed -i 's/source ~\/..*_shell_config/# &/' ~/.bashrc

# Or remove the config file
rm ~/.minimal_shell_config    # or advanced/hidden
```

## 🛡️ Safety Features

All setups include:
- ✅ Automatic backups before changes
- ✅ Non-destructive installation
- ✅ Easy rollback options
- ✅ Permission checks
- ✅ Error handling

## 📝 Usage Examples

### Minimal Setup Commands
```bash
info                    # System information
ll                      # Enhanced ls
..                      # Go up directory
```

### Extended Setup Commands  
```bash
sysinfo-extended        # Detailed system info
devcheck               # Check dev environment
extract file.tar.gz    # Smart extraction
mkcd newdir            # Make and enter directory
backup important.txt   # Create timestamped backup
venv myproject         # Create Python virtual env
server 8080            # Start HTTP server
gitignore python       # Download gitignore template
```

### Stealth Setup Commands
```bash
quickcheck             # Silent health check
gitstatus              # Git status if in repo
updatecheck            # Check for updates
silent-optimize        # Background optimization
myip                   # Get public IP
localip                # Get local IP
backup file.txt        # Hidden backup
extract archive.zip    # Silent extraction
```

## 🔄 Switching Between Setups

You can switch setups anytime:

```bash
# Switch to minimal (removes advanced features)
./customization/minimal-setup.sh

# Upgrade to extended (adds all features)
./customization/extended-setup.sh

# Apply stealth mode (hides visual changes)
./customization/stealth-setup.sh
```

## 🆘 Troubleshooting

### Reset Everything
```bash
# Backup current configs
cp ~/.bashrc ~/.bashrc.backup

# Remove all custom configs
rm ~/.minimal_shell_config ~/.advanced_shell_config ~/.hidden_shell_config

# Restore original bashrc
grep -v "source.*shell_config" ~/.bashrc.backup > ~/.bashrc

# Restart terminal
exec bash
```

### Check What's Active
```bash
# See what configs are loaded
grep "shell_config" ~/.bashrc

# Check installed tools
which bat eza fd rg

# Verify aliases
alias | grep -E "(ll|la|..)"
```