#!/usr/bin/env bash

save_dir="$HOME/Pictures/Screenshots"
mkdir -p "$save_dir"

# Menu options
options=$(echo -e "  Screen\n  Area\n  Window\n")
selected_option=$(echo -e "$options" | rofi -dmenu -i -mesg "Screenshot" -config ~/.config/rofi/screen.rasi)

# Quit immediately if Esc pressed
[ -z "$selected_option" ] && exit 0

# Default filename
default_name="$(date +'%Y-%m-%d_%H-%M-%S').png"

# Prompt for filename using zenity
filename=$(zenity --entry --title="Screenshot Filename" --text="Enter filename:" --entry-text="$default_name")
[ -z "$filename" ] && filename="$default_name"

filepath="$save_dir/$filename"

case "$selected_option" in
    "  Screen")
        sleep 0.4
        grim -t png "$filepath" && wl-copy < "$filepath"
        notify-send "Screenshot saved" "$filepath" -i "$filepath"
        ;;
    "  Area")
        grim -g "$(slurp)" -t png "$filepath" && wl-copy < "$filepath"
        notify-send "Screenshot saved" "$filepath" -i "$filepath"
        ;;
    "  Window")
        sleep 0.4
        geom="$(hyprctl activewindow | awk '/at:/ {x=$2","$3} /size:/ {s=$2} END{gsub(",", "x", x); print x"s"}')"
        grim -g "$geom" -t png "$filepath" && wl-copy < "$filepath"
        notify-send "Screenshot saved" "$filepath" -i "$filepath"
        ;;
esac
