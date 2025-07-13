#!/bin/bash

# Get WiFi status using different methods to ensure reliability
device=$(nmcli device | grep wifi | awk '{print $1}' | head -n 1)
connection_info=$(nmcli -t -f NAME,SIGNAL,DEVICE connection show --active 2>/dev/null | grep -E "wlan|wifi")

if [ -z "$connection_info" ] && [ -n "$device" ]; then
    # Check directly if the device is connected
    status=$(nmcli -f GENERAL.STATE device show "$device" | grep "connected" | head -n 1)
    if [[ "$status" == *"connected"* ]]; then
        # Connected but not detected by the first method
        ssid=$(nmcli -t -f GENERAL.CONNECTION device show "$device" | cut -d: -f2)
        signal=$(nmcli -f IN-USE,SIGNAL device wifi list | grep "\*" | awk '{print $2}')
        if [ -z "$signal" ]; then signal="--"; fi
        ip=$(ip -4 addr show dev "$device" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
        
        tooltip="Connected to $ssid\nSignal Strength: $signal%\nIP: $ip\nDevice: $device"
        echo "{\"text\": \"$ssid\", \"tooltip\": \"$tooltip\", \"class\": \"connected\", \"alt\": \"connected\"}"
        exit 0
    fi
fi

if [ -n "$connection_info" ]; then
    # We have an active WiFi connection
    ssid=$(echo "$connection_info" | cut -d: -f1)
    signal=$(nmcli -f IN-USE,SIGNAL device wifi list | grep "\*" | awk '{print $2}')
    if [ -z "$signal" ]; then signal="--"; fi
    device=$(echo "$connection_info" | cut -d: -f3)
    ip=$(ip -4 addr show dev "$device" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
    
    tooltip="Connected to $ssid\nSignal Strength: $signal%\nIP: $ip\nDevice: $device"
    
    # Output JSON for waybar
    echo "{\"text\": \"$ssid\", \"tooltip\": \"$tooltip\", \"class\": \"connected\", \"alt\": \"connected\"}"
else
    # No active WiFi connection
    if nmcli radio wifi | grep -q enabled; then
        tooltip="WiFi is enabled but not connected\nClick to connect"
    else
        tooltip="WiFi is disabled\nClick to enable"
    fi
    
    # Output JSON for waybar
    echo "{\"tooltip\": \"$tooltip\", \"class\": \"disconnected\", \"alt\": \"disconnected\"}"
fi 