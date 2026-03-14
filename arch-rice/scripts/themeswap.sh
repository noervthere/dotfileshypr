#!/bin/bash

THEME=$1
THEME_DIR="$HOME/.config/hypr/themes/$THEME"

if [ ! -d "$THEME_DIR" ]; then
    echo "Theme '$THEME' not found"
    exit 1
fi

# 1. Standard file copies
cp "$THEME_DIR/theme.conf" "$HOME/.config/hypr/theme.conf"
cp "$THEME_DIR/colors.css" "$HOME/.config/waybar/colors.css"

# 2. Extract the hex color from your theme's colors.css
# This looks for the #xxxxxx pattern specifically on the 'accent' line
NEW_COLOR=$(grep "accent" "$THEME_DIR/colors.css" | grep -oE '#[a-fA-F0-9]{6}')

# 3. Use sed to find the lines in wofi style and swap the hex code
# This replaces any # hex code on the border and entry:selected lines
# This swaps the color in the border and the selection highlight
sed -i "s/#[a-fA-F0-9]\{6\}/$NEW_COLOR/g" "$HOME/.config/wofi/style.css"
# This puts the background color back to dark so the whole window doesn't turn blue/purple
sed -i "s/background-color: $NEW_COLOR/background-color: #1e1e2e/g" "$HOME/.config/wofi/style.css"
# This makes sure the input box stays slightly lighter than the background
sed -i "s/background-color: #313244/background-color: #313244/g" "$HOME/.config/wofi/style.css"
# Note: We keep the background-color of the window itself dark (#1e1e2e) 
# and only change the highlight/border.

# 4. Reload services
killall waybar
nohup waybar &> /dev/null &
disown
hyprctl reload

notify-send "Theme Swapped" "Applied $THEME ($NEW_COLOR)"