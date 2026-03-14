#!/bin/bash
CURRENT=$(readlink -f ~/.config/hypr)

if [[ "$CURRENT" == *custom* ]]; then
    rm ~/.config/hypr
    ln -s ~/.config/hypr_caelestia ~/.config/hypr
    echo "Switched to CAELESTIA"
else
    rm ~/.config/hypr
    ln -s ~/.config/hypr_custom ~/.config/hypr
    echo "Switched to CUSTOM"
fi

hyprctl reload