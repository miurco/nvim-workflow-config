# Nerd Fonts CLI Tool

A command-line utility to manage and switch Nerd Fonts in Alacritty terminal.

## 📖 How Fonts Work with Terminals

**Important:** Terminals (like Alacritty), not Neovim, control font rendering.

- **Alacritty** reads font configuration from `~/.config/alacritty/alacritty.toml`
- **Neovim** simply displays text using whatever font the terminal provides
- **Nerd Fonts** provide special icon glyphs (like , , , etc.) used by modern terminal UI plugins and prompts

## 🎨 Installed Nerd Fonts

The following 10 Nerd Fonts are installed on your system (located in `~/Library/Fonts/`):

1. **JetBrainsMono Nerd Font** - Designed by JetBrains for developers
2. **FiraCode Nerd Font** - Features programming ligatures
3. **Hack Nerd Font** - Clean and highly readable
4. **MesloLGL Nerd Font** - Customized version of Apple's Menlo
5. **SauceCodePro Nerd Font** - Based on Source Code Pro by Adobe
6. **Inconsolata Nerd Font** - Monospace font for code listings
7. **RobotoMono Nerd Font** - Google's Roboto in monospace
8. **UbuntuMono Nerd Font** - Ubuntu's monospace font
9. **Iosevka Nerd Font** - Slender and customizable
10. **CaskaydiaCove Nerd Font** - Microsoft's Cascadia Code variant

Each font has three variants:
- **Regular** (e.g., "JetBrainsMono Nerd Font") - Standard spacing
- **Mono** (e.g., "JetBrainsMono Nerd Font Mono") - Strict monospace with icons
- **Propo** (e.g., "JetBrainsMono Nerd Font Propo") - Proportional width icons

## 🚀 Usage

### List Available Fonts

Display all installed Nerd Fonts and see which one is currently active:

```bash
./fonts-cli/list-fonts.sh
```

**Output example:**
```
📚 Installed Nerd Fonts:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  → JetBrainsMono Nerd Font  ✓ (active)
    FiraCode Nerd Font
    Hack Nerd Font
    MesloLGL Nerd Font
    ...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total fonts: 10
Current font: JetBrainsMono Nerd Font
```

### Switch Fonts

Change the font in Alacritty (with optional size):

```bash
# Switch to a font with default size (12.0)
./fonts-cli/switch-font.sh "FiraCode Nerd Font"

# Switch to a font with custom size
./fonts-cli/switch-font.sh "Hack Nerd Font" 14.0

# Use Mono variant for strict monospacing
./fonts-cli/switch-font.sh "JetBrainsMono Nerd Font Mono" 13.0
```

**Notes:**
- Font names are **case-sensitive**
- Use quotes around font names with spaces
- Alacritty will auto-reload the configuration
- If auto-reload doesn't work, reopen the terminal

### Quick Font Testing Workflow

```bash
# 1. List all available fonts
./fonts-cli/list-fonts.sh

# 2. Try different fonts to see which you prefer
./fonts-cli/switch-font.sh "JetBrainsMono Nerd Font"
# ... test it in your terminal ...

./fonts-cli/switch-font.sh "FiraCode Nerd Font"
# ... test it in your terminal ...

./fonts-cli/switch-font.sh "Hack Nerd Font"
# ... test it in your terminal ...

# 3. Once you find one you like, set it with your preferred size
./fonts-cli/switch-font.sh "FiraCode Nerd Font" 13.5
```

## 📦 Adding More Fonts

### Search for Nerd Fonts

```bash
brew search nerd-font
```

### Install Additional Nerd Fonts

```bash
# Install a specific Nerd Font
brew install --cask font-<name>-nerd-font

# Examples:
brew install --cask font-victor-mono-nerd-font
brew install --cask font-dejavu-sans-mono-nerd-font
brew install --cask font-anonymice-nerd-font
```

### Uninstall Fonts

```bash
brew uninstall --cask font-<name>-nerd-font
```

## ⚙️ Configuration

### Alacritty Configuration Location

```
~/.config/alacritty/alacritty.toml
```

### Manual Font Configuration

You can also manually edit the Alacritty config:

```toml
[font]
size = 12.0

[font.normal]
family = "JetBrainsMono Nerd Font"

# Optional: different fonts for bold/italic
[font.bold]
family = "JetBrainsMono Nerd Font"
style = "Bold"

[font.italic]
family = "JetBrainsMono Nerd Font"
style = "Italic"
```

### Auto-reload Behavior

Alacritty monitors its configuration file and automatically reloads when changes are detected. The `switch-font.sh` script uses `touch` to ensure the modification timestamp is updated, triggering the reload.

If auto-reload doesn't work:
1. Close and reopen Alacritty
2. Or use the keyboard shortcut (if configured) to reload config

## 🔧 Troubleshooting

### Font not showing up in list

```bash
# Verify font is installed
fc-list | grep -i "nerd font"

# If missing, reinstall
brew reinstall --cask font-<name>-nerd-font
```

### Icons not rendering correctly

Make sure you're using the regular "Nerd Font" variant (not "Nerd Font Mono" or "Nerd Font Propo") for full icon support.

### Alacritty not reloading

1. Check for syntax errors: `cat ~/.config/alacritty/alacritty.toml`
2. Manually restart Alacritty
3. Check Alacritty's log for errors (if available)

## 📚 Resources

- [Nerd Fonts Official Site](https://www.nerdfonts.com/)
- [Alacritty Documentation](https://alacritty.org/)
- [Homebrew Cask Fonts](https://github.com/Homebrew/homebrew-cask-fonts)

## 💡 Tips

- **Programming ligatures**: FiraCode and CaskaydiaCove have ligatures (→, ≠, >=, etc.)
- **Performance**: Iosevka is lightweight and renders quickly
- **Readability**: Hack and JetBrainsMono are optimized for long coding sessions
- **Retina displays**: Try size 13.0-14.0 for better readability on high-DPI screens
