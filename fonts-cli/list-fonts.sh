#!/usr/bin/env zsh

# List all installed Nerd Fonts and highlight the currently active one in Alacritty

ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"

# Get current font from Alacritty config
current_font=""
if [[ -f "$ALACRITTY_CONFIG" ]]; then
    # Extract font family from [font.normal] section
    current_font=$(awk '/^\[font\.normal\]/ {flag=1; next} /^\[/ {flag=0} flag && /^family/ {gsub(/^family[[:space:]]*=[[:space:]]*"|"[[:space:]]*$/, ""); print; exit}' "$ALACRITTY_CONFIG")
fi

echo "📚 Installed Nerd Fonts:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo

# Get all Nerd Font families (non-Mono, non-Propo variants as primary options)
# Extract only the base family name (before any comma)
# Filter out variants that end with " Mono" or " Propo" but keep fonts like "JetBrainsMono"
fonts=$(fc-list : family | grep -i "nerd font" | grep -v " Mono" | grep -v " Propo" | cut -d',' -f1 | sort -u)

if [[ -z "$fonts" ]]; then
    echo "❌ No Nerd Fonts found!"
    echo "Run: brew install --cask font-<name>-nerd-font"
    exit 1
fi

count=0
while IFS= read -r font; do
    ((count++))
    
    # Check if this is the current font
    if [[ "$font" == "$current_font" ]]; then
        echo "  → $font  ✓ (active)"
    else
        echo "    $font"
    fi
done <<< "$fonts"

echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Total fonts: $count"

if [[ -n "$current_font" ]]; then
    echo "Current font: $current_font"
else
    echo "No font configured in Alacritty (using system default)"
fi

echo
echo "💡 Tip: Each font also has 'Mono' and 'Propo' variants available"
echo "   Switch fonts with: ./switch-font.sh \"<font-name>\""
