# Quick Start Guide

## 🚀 Get Started in 3 Steps

### 1. List Available Fonts
```bash
./fonts-cli/list-fonts.sh
```

### 2. Pick a Font and Try It
```bash
./fonts-cli/switch-font.sh "JetBrainsMono Nerd Font"
```

### 3. Experiment Until You Find Your Favorite
```bash
# Try different fonts
./fonts-cli/switch-font.sh "FiraCode Nerd Font"
./fonts-cli/switch-font.sh "Hack Nerd Font"
./fonts-cli/switch-font.sh "Iosevka Nerd Font"

# Adjust size when you find one you like
./fonts-cli/switch-font.sh "FiraCode Nerd Font" 13.5
```

## 📋 One-Liners for Testing

```bash
# Quick test loop - try each font for 5 seconds
for font in "JetBrainsMono Nerd Font" "FiraCode Nerd Font" "Hack Nerd Font" "Iosevka Nerd Font"; do 
  ./fonts-cli/switch-font.sh "$font" && echo "Testing $font..." && sleep 5
done
```

## 💡 Tips

- **Alacritty auto-reloads** - changes take effect immediately
- **Font names are case-sensitive** - copy-paste from `list-fonts.sh`
- **Each font has variants**: Regular, Mono (strict monospace), Propo (proportional icons)
- **Recommended sizes**: 12.0-14.0 for normal displays, 13.0-15.0 for Retina/4K

## 🎨 Popular Choices

| Font | Best For |
|------|----------|
| **JetBrainsMono** | General coding, long sessions |
| **FiraCode** | Programming ligatures (→, >=, !=) |
| **Hack** | Readability, clarity |
| **Iosevka** | Performance, compact code |
| **CaskaydiaCove** | Modern look with ligatures |

## 📚 Full Documentation

See [README.md](./README.md) for complete documentation.
