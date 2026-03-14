#!/bin/bash

# Options as Icons
shutdown="  Shutdown"
reboot="󰜉  Reboot"
suspend="  Suspend"
lock="  Lock"
logout="󰈆  Log Out"

# Combine options
options="$shutdown\n$reboot\n$suspend\n$lock\n$logout"

# Run Rofi with a specific "Floating Window" override
chosen="$(echo -e "$options" | rofi -dmenu -i -p "System" \
-theme-str 'window {width: 300px; height: 380px; border: 3px; border-radius: 25px;}' \
-theme-str 'listview {columns: 1; lines: 5;}' \
-theme-str 'inputbar {children: [prompt];}' \
-theme ~/.config/rofi/theme.rasi)"

case $chosen in
    $shutdown) systemctl poweroff ;;
    $reboot)   systemctl reboot ;;
    $suspend)  systemctl suspend ;;
    $lock)     hyprlock || swaylock ;;
    $logout)   hyprctl dispatch exit ;;
esac