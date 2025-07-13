#!/bin/bash

# Get current brightness percentage
current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((current * 100 / max))

# Calculate brightness bar
bar_length=15
filled_length=$((percent * bar_length / 100))
empty_length=$((bar_length - filled_length))

# Create colored bar
bar=""
for ((i = 0; i < filled_length; i++)); do
    # Gradient colors based on position
    position=$((i * 100 / bar_length))
    if [ "$position" -lt 30 ]; then
        bar+="<span foreground='#ffb86c'>■</span>" # Orange for low
    elif [ "$position" -lt 70 ]; then
        bar+="<span foreground='#8be9fd'>■</span>" # Cyan for medium
    else
        bar+="<span foreground='#50fa7b'>■</span>" # Green for high
    fi
done
for ((i = 0; i < empty_length; i++)); do
    bar+="<span foreground='#6272a4'>□</span>" # Comment color for empty
done

# Create a menu with brightness options
options="<span font='16' weight='bold'>Brightness Controls</span>"
options+="\n<span foreground='#f8f8f2' weight='bold'>Current: ${percent}%</span>"
#options+="\n"
options+="\n<span foreground='#ff79c6' weight='bold'>Quick Adjust:</span>"
options+="\n<span foreground='#8be9fd'>▲ Increase 5%</span>"
options+="\n<span foreground='#8be9fd'>▼ Decrease 5%</span>"
#options+="\n"
options+="\n<span foreground='#ff79c6' weight='bold'>Presets:</span>"
options+="\n<span foreground='#50fa7b'>🔆 100% (Maximum)</span>"
options+="\n<span foreground='#50fa7b'>🔆 90%</span>"
options+="\n<span foreground='#50fa7b'>🔆 80%</span>"
options+="\n<span foreground='#8be9fd'>🔅 70%</span>"
options+="\n<span foreground='#8be9fd'>🔅 60%</span>"
options+="\n<span foreground='#8be9fd'>🔅 50%</span>"
options+="\n<span foreground='#ffb86c'>🔅 40%</span>"
options+="\n<span foreground='#ffb86c'>🔅 30%</span>"
options+="\n<span foreground='#ffb86c'>🔅 20%</span>"
options+="\n<span foreground='#ff5555'>🔅 10% (Minimum)</span>"

theme="$HOME/.config/rofi/scripts/brightness/style.rasi"

# Use wofi, rofi or bemenu for displaying the menu
if command -v wofi >/dev/null 2>&1; then
    chosen=$(echo -e "$options" | wofi --dmenu --cache-file=/dev/null --insensitive --width=400 --height=500 --allow-markup --prompt="Brightness" --style ~/.config/wofi/style.css)
elif command -v rofi >/dev/null 2>&1; then
    chosen=$(echo -e "$options" | rofi -dmenu -i -p "Brightness" -markup-rows -theme "${theme}")
else
    chosen=$(echo -e "$options" | sed 's/<[^>]*>//g' | bemenu -p "Brightness" -l 15 -W 0.4)
fi

# Clean the chosen option from markup
chosen_clean=$(echo "$chosen" | sed 's/<[^>]*>//g')

# Process the selection
case "$chosen_clean" in
*"Increase 5%"*)
    brightnessctl set +5%
    new_percent=$(($(brightnessctl get) * 100 / $max))
    notify-send -u low "Brightness" "Increased to $new_percent%" -h int:value:$new_percent -i display-brightness
    ;;
*"Decrease 5%"*)
    brightnessctl set 5%-
    new_percent=$(($(brightnessctl get) * 100 / $max))
    notify-send -u low "Brightness" "Decreased to $new_percent%" -h int:value:$new_percent -i display-brightness
    ;;
*"100%"*)
    brightnessctl set 100%
    notify-send -u low "Brightness" "Set to 100%" -h int:value:100 -i display-brightness
    ;;
*"90%"*)
    brightnessctl set 90%
    notify-send -u low "Brightness" "Set to 90%" -h int:value:90 -i display-brightness
    ;;
*"80%"*)
    brightnessctl set 80%
    notify-send -u low "Brightness" "Set to 80%" -h int:value:80 -i display-brightness
    ;;
*"70%"*)
    brightnessctl set 70%
    notify-send -u low "Brightness" "Set to 70%" -h int:value:70 -i display-brightness
    ;;
*"60%"*)
    brightnessctl set 60%
    notify-send -u low "Brightness" "Set to 60%" -h int:value:60 -i display-brightness
    ;;
*"50%"*)
    brightnessctl set 50%
    notify-send -u low "Brightness" "Set to 50%" -h int:value:50 -i display-brightness
    ;;
*"40%"*)
    brightnessctl set 40%
    notify-send -u low "Brightness" "Set to 40%" -h int:value:40 -i display-brightness
    ;;
*"30%"*)
    brightnessctl set 30%
    notify-send -u low "Brightness" "Set to 30%" -h int:value:30 -i display-brightness
    ;;
*"20%"*)
    brightnessctl set 20%
    notify-send -u low "Brightness" "Set to 20%" -h int:value:20 -i display-brightness
    ;;
*"10%"*)
    brightnessctl set 10%
    notify-send -u low "Brightness" "Set to 10%" -h int:value:10 -i display-brightness
    ;;
esac
