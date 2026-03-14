#!/bin/bash

# --- CONFIG ---
WALL_DIR="$HOME/Pictures/Wallpapers"

# 1. Background Daemons (Silent)
pkill hyprpaper > /dev/null 2>&1
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon > /dev/null 2>&1 &
    sleep 0.5
fi

# 2. Select Wallpaper
if [ -z "$1" ]; then
    WALL=$(find "$WALL_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)
else
    WALL=$1
fi

# 3. Set Wallpaper (Silent & Detached)
swww img "$WALL" --transition-type grow --transition-fps 60 > /dev/null 2>&1 &

# Generate JSON for Quickshell or other scripts
wal -i "$WALL" -n -q --json
# This creates ~/.cache/wal/colors.json

# 4. Generate Colors
wal -i "$WALL" -n -q > /dev/null 2>&1
source "$HOME/.cache/wal/colors.sh"

# 5. Clean & Inject Colors
CLEAN_BG=$(echo "$color0" | tr -d '[:space:]')
CLEAN_ACCENT=$(echo "$color6" | tr -d '[:space:]')
CLEAN_TEXT=$(echo "$color7" | tr -d '[:space:]')

echo "\$accent = rgba(${CLEAN_ACCENT:1}ff)
\$bg     = rgba(${CLEAN_BG:1}ff)" > ~/.config/hypr/theme.conf

cat <<EOF > ~/.config/waybar/colors.css
@define-color bg      $CLEAN_BG;
@define-color accent  $CLEAN_ACCENT;
@define-color text    $CLEAN_TEXT;
EOF

cat <<EOF > ~/.config/wofi/colors.css
@define-color bg      $CLEAN_BG;
@define-color accent  $CLEAN_ACCENT;
@define-color text    $CLEAN_TEXT;
EOF

# 6. Instant Terminal Refresh
cat ~/.cache/wal/sequences

# 7. The "Anti-Death" Reload
# We kill waybar and restart it completely outside the terminal's control
pkill waybar > /dev/null 2>&1
sleep 0.2
hyprctl reload > /dev/null 2>&1
nohup waybar > /dev/null 2>&1 & 
disown

# 8. Notify and Exit
notify-send "Theme Synced" "Matched to $(basename "$WALL")"
exit 0

pkill waybar
nohup waybar > /dev/null 2>&1 &
disown