#!/bin/bash

# Path to your CAVA config (default: ~/.config/cava/config)
CAVA_CONFIG="${HOME}/.config/cava/config"

# Path to pywal's colors.json (generated by `wal`)
PYWAL_COLORS="${HOME}/.cache/wal/colors.json"

# Check if pywal colors exist
if [[ ! -f "$PYWAL_COLORS" ]]; then
    echo "Error: Pywal colors not found. Run 'wal' first."
    exit 1
fi

# Check if CAVA config exists
if [[ ! -f "$CAVA_CONFIG" ]]; then
    echo "Error: CAVA config not found at $CAVA_CONFIG"
    exit 1
fi

# Extract pywal colors (16 colors, but we'll use 8 for the gradient)
PYWAL_GRADIENT=(
    "$(jq -r '.colors.color1' "$PYWAL_COLORS")"  # Color 1 (bottom)
    "$(jq -r '.colors.color2' "$PYWAL_COLORS")"
    "$(jq -r '.colors.color3' "$PYWAL_COLORS")"
    "$(jq -r '.colors.color4' "$PYWAL_COLORS")"
    "$(jq -r '.colors.color5' "$PYWAL_COLORS")"
    "$(jq -r '.colors.color6' "$PYWAL_COLORS")"
    "$(jq -r '.colors.color7' "$PYWAL_COLORS")"
    "$(jq -r '.colors.color8' "$PYWAL_COLORS")"  # Color 8 (top)
)

# Update gradient colors in CAVA config
for i in {1..8}; do
    sed -i "s/^gradient_color_${i} = .*/gradient_color_${i} = '${PYWAL_GRADIENT[$((i-1))]}'/" "$CAVA_CONFIG"
done

pkill -USR2 cava
