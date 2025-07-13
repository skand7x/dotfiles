#!/bin/bash

# Get list of available networks
networks=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | sort -nr -k2 | uniq -f 1)

# Create menu options with network information
if [ -n "$networks" ]; then
    options="<span font='16' weight='bold'>WiFi Networks</span>"

    # Current connection status
    current=$(nmcli -t -f NAME,DEVICE connection show --active | grep -E 'wifi|wlan' | cut -d: -f1)
    if [ -n "$current" ]; then
        options+="\n<span weight='bold' foreground='#8be9fd'>Connected to:</span> <span foreground='#50fa7b'>$current</span>"
    else
        options+="\n<span weight='bold' foreground='#ff5555'>Not Connected</span>"
    fi

    #options+="\n"
    options+="\n<span weight='bold' foreground='#bd93f9'>Available Networks:</span>"

    # Add available networks
    IFS=$'\n'
    for line in $networks; do
        SSID=$(echo "$line" | cut -d: -f1)
        SIGNAL=$(echo "$line" | cut -d: -f2)
        SECURITY=$(echo "$line" | cut -d: -f3)

        if [ -n "$SECURITY" ] && [ "$SECURITY" != "--" ]; then
            security_icon="🔒"
        else
            security_icon="  "
        fi

        # Calculate signal strength icon
        if [ "$SIGNAL" -ge 80 ]; then
            signal_icon="▮▮▮▮"
            signal_color="#50fa7b" # green for strong signal
        elif [ "$SIGNAL" -ge 60 ]; then
            signal_icon="▮▮▮ "
            signal_color="#8be9fd" # cyan for good signal
        elif [ "$SIGNAL" -ge 40 ]; then
            signal_icon="▮▮  "
            signal_color="#ffb86c" # orange for moderate signal
        elif [ "$SIGNAL" -ge 20 ]; then
            signal_icon="▮   "
            signal_color="#ff79c6" # pink for weak signal
        else
            signal_icon="    "
            signal_color="#ff5555" # red for very weak signal
        fi

        # Highlight current network
        if [ "$SSID" = "$current" ]; then
            options+="\n<span weight='bold'>→ $SSID</span> $security_icon <span foreground='$signal_color'>$signal_icon</span>"
        else
            options+="\n$SSID $security_icon <span foreground='$signal_color'>$signal_icon</span>"
        fi
    done

    #options+="\n"
    options+="\n<span foreground='#ff79c6' weight='bold'>Actions:</span>"
    options+="\n<span foreground='#ffb86c'>📡 Rescan Networks</span>"
    options+="\n<span foreground='#ffb86c'>📱 Network Settings</span>"
    if nmcli radio wifi | grep -q enabled; then
        options+="\n<span foreground='#ff5555'>🔌 Disable WiFi</span>"
    else
        options+="\n<span foreground='#50fa7b'>🔌 Enable WiFi</span>"
    fi
else
    options="<span font='16' weight='bold' foreground='#ff5555'>No WiFi Networks Found</span>"
    options+="\n<span foreground='#ffb86c'>📡 Rescan Networks</span>"
    options+="\n<span foreground='#ffb86c'>📱 Network Settings</span>"
    if nmcli radio wifi | grep -q enabled; then
        options+="\n<span foreground='#ff5555'>🔌 Disable WiFi</span>"
    else
        options+="\n<span foreground='#50fa7b'>🔌 Enable WiFi</span>"
    fi
fi

theme="$HOME/.config/rofi/scripts/wifi/style.rasi"

# Use wofi, rofi or bemenu for displaying the menu
if command -v wofi >/dev/null 2>&1; then
    chosen=$(echo -e "$options" | wofi --dmenu --cache-file=/dev/null --insensitive --width=400 --height=500 --allow-markup --prompt="WiFi" --style ~/.config/wofi/style.css)
elif command -v rofi >/dev/null 2>&1; then
    chosen=$(echo -e "$options" | rofi -dmenu -i -p "WiFi" -markup-rows -theme "${theme}")
else
    chosen=$(echo -e "$options" | sed 's/<[^>]*>//g' | bemenu -p "WiFi" -l 15 -W 0.4)
fi

# Clean the chosen option from markup
chosen_clean=$(echo "$chosen" | sed 's/<[^>]*>//g')

# Process the selection
case "$chosen_clean" in
*"Rescan Networks"*)
    nmcli device wifi rescan
    notify-send -i network-wireless "WiFi" "Rescanning networks..."
    sleep 2
    ~/.config/waybar/scripts/wifi-menu.sh
    ;;
*"Network Settings"*)
    if command -v nm-connection-editor >/dev/null 2>&1; then
        nm-connection-editor &
    elif command -v gnome-control-center >/dev/null 2>&1; then
        gnome-control-center wifi &
    else
        notify-send -i network-wireless "WiFi" "No network settings application found"
    fi
    ;;
*"Disable WiFi"*)
    nmcli radio wifi off
    notify-send -i network-wireless-disabled "WiFi" "WiFi disabled"
    ;;
*"Enable WiFi"*)
    nmcli radio wifi on
    notify-send -i network-wireless "WiFi" "WiFi enabled"
    ;;
*)
    # If a network was selected, try to connect to it
    # Extract SSID from the chosen line
    selected=$(echo "$chosen_clean" | sed 's/→ \(.*\) 🔒.*/\1/' | sed 's/\(.*\) 🔒.*/\1/' | sed 's/→ \(.*\)  .*/\1/' | sed 's/\(.*\)  .*/\1/' | xargs)

    if [ -n "$selected" ]; then
        # Check if we're already connected to this network
        if [ "$selected" = "$current" ]; then
            notify-send -i network-wireless "WiFi" "Already connected to $selected"
        else
            # Check if this is a known connection
            if nmcli -t -f NAME connection show | grep -q "^$selected$"; then
                notify-send -i network-wireless "WiFi" "Connecting to $selected..."
                nmcli connection up "$selected" && notify-send -i network-wireless "WiFi" "Connected to $selected" || notify-send -i network-error "WiFi" "Failed to connect to $selected"
            else
                # Try to connect to new network
                # Check if it has password
                if echo "$networks" | grep "^$selected:" | grep -q ":.*:"; then
                    notify-send -i dialog-password "WiFi" "Please enter password for $selected"
                    password=$(echo "" | wofi --dmenu --password --prompt="Enter password for $selected")
                    if [ -n "$password" ]; then
                        notify-send -i network-wireless "WiFi" "Connecting to $selected..."
                        nmcli device wifi connect "$selected" password "$password" && notify-send -i network-wireless "WiFi" "Connected to $selected" || notify-send -i network-error "WiFi" "Failed to connect to $selected"
                    fi
                else
                    notify-send -i network-wireless "WiFi" "Connecting to $selected..."
                    nmcli device wifi connect "$selected" && notify-send -i network-wireless "WiFi" "Connected to $selected" || notify-send -i network-error "WiFi" "Failed to connect to $selected"
                fi
            fi
        fi
    fi
    ;;
esac
