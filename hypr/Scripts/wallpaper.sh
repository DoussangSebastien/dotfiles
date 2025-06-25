#!/bin/bash

wallpapers_dir="$HOME/wallpapers/"
hyprlock_config="$HOME/.config/hypr/hyprlock.conf"
hyprpaper_config="$HOME/.config/hypr/hyprpaper.conf"

build_theme() {
  rows=$1
  cols=$2
  icon_size=$3

  echo "element{orientation:vertical;}element-text{horizontal-align:0.5;}element-icon{size:$icon_size.0000em;}listview{lines:$rows;columns:$cols;}"
}

rofi_cmd="rofi -dmenu -i -show-icons -theme-str $(build_theme 4 3 12) -theme ${theme}"

choice=$(
  ls --escape "$wallpapers_dir" |
    while read A; do echo -en "$A\x00icon\x1f$wallpapers_dir/$A\n"; done |
    $rofi_cmd
)

if [ -z "$choice" ]; then
  exit 1
fi

WALLPAPER="$wallpapers_dir/$choice"
wal -i "$WALLPAPER"

# Wait for Pywal to finish writing files
while [ ! -f "$HOME/.cache/wal/colors.sh" ]; do
  sleep 0.1
done

# Inject matching color into Hyprlock labels (minute + song)
colors_json="$HOME/.cache/wal/colors.json"
hyprlock_config="$HOME/.config/hypr/hyprlock.conf"

# Extract a nice accent color (you can change to another like color2, color4, etc.)
accent_hex=$(jq -r '.colors.color4' "$colors_json")

# Convert to rgba
hex_to_rgba() {
  hex=${1#"#"}
  r=$((16#${hex:0:2}))
  g=$((16#${hex:2:2}))
  b=$((16#${hex:4:2}))
  echo "rgba($r, $g, $b, 1)"
}

accent_rgba=$(hex_to_rgba "$accent_hex")

sed -i "/Time-Minute/,/}/ s|color = rgba([^)]*)|color = $accent_rgba|" "$hyprlock_config"
sed -i "/CURRENT SONG/,/}/ s|color = rgba([^)]*)|color = $accent_rgba|" "$hyprlock_config"

"$HOME/.config/hypr/Scripts/term_colors.sh"
"$HOME/.config/hypr/Scripts/cava_colors.sh"
"$HOME/.config/hypr/Scripts/reload-waybar.sh"

# Change wallpaper based on current wallpaper daemon
if pgrep -x "hyprpaper" >/dev/null; then
  # Update hyprpaper config
  if [ -f "$hyprpaper_config" ]; then
    # Update both preload and wallpaper entries
    sed -i \
      -e "s|preload = .*|preload = $WALLPAPER|" \
      -e "s|wallpaper = .*|wallpaper = ,$WALLPAPER|" \
      "$hyprpaper_config"
    
    # Reload hyprpaper
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$WALLPAPER"
    hyprctl hyprpaper wallpaper ,"$WALLPAPER"
    
    notify-send "Wallpaper Changed" -i "$WALLPAPER" --app-name=Wallpaper
  else
    notify-send "Hyprpaper config not found" "Could not update wallpaper" --app-name=Wallpaper
  fi
elif pgrep -x "swww" >/dev/null; then
  swww img "$WALLPAPER" \
    --transition-bezier 0.5,1.19,.8,.4 \
    --transition-type wipe \
    --transition-duration 2 \
    --transition-fps 75 && notify-send "Wallpaper Changed" -i "$WALLPAPER" --app-name=Wallpaper
fi

# Update Hyprlock background path
if [ -f "$hyprlock_config" ]; then
  sed -i "/background {/,/}/ s|path = .*|path = $WALLPAPER|" "$hyprlock_config"
  notify-send "Hyprlock Wallpaper Updated" -i "$WALLPAPER" --app-name=Wallpaper
else
  notify-send "Hyprlock config not found" "Could not update lock screen wallpaper" --app-name=Wallpaper
fi

exit 0
