#!/bin/bash

# Get battery percentage using upower
battery_level=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -i percentage | awk '{print $2}' | sed 's/%//')

# Check if the battery is charging
charging_status=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -i state | awk '{print $2}')

# Set icon based on battery percentage
if [ "$charging_status" = "charging" ]; then
    icon=""
else
    if [ "$battery_level" -ge 80 ]; then
        icon=""  # Battery 80-100%
    elif [ "$battery_level" -ge 60 ]; then
        icon=""  # Battery 60-80%
    elif [ "$battery_level" -ge 40 ]; then
        icon=""  # Battery 40-60%
    elif [ "$battery_level" -ge 20 ]; then
        icon=""  # Battery 20-40%
    else
        icon=""  # Battery 0-20%
    fi
fi

# Display the icon with the battery level
echo "$icon $battery_level %"
