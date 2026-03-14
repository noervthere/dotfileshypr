# 🍚 Hyprland Rice with Pywal 🍚
> Dynamic colors, GNU Stow management, and automated theme switching on Arch Linux.

im just a starter and trying to learn stuff for fun soo you know what i mean <3

This is my personal dotfile repository for my Hyprland setup, featuring a dynamic theme system powered by Pywal and managed with GNU Stow.

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/noervthere/dotfileshypr/raw/main/screenshots/screenshot1" width="45%" alt="Blue Theme-Wallpaper (Automatically Adapted) Screenshot">
  
</p>
<p align="center">
  <em>Above: Automatic theme switching from a Purple aesthetic to a Blue aesthetic based on the wallpaper.</em>
</p>

## 🚀 Quick Install

This guide assumes you are on a fresh install of Arch Linux (or similar) with Hyprland already running.

### 1. Install Dependencies

You'll need these essential packages (using `pacman` and `yay` for AUR):

```bash
# Core components
sudo pacman -S hyprland waybar rofi swww foot stow git polkit-gnome grim slurp wl-clipboard

# Theme & customization engine
sudo pacman -S python-pywal imagemagick python-setuptools

# Optional, but highly recommended for notifications
yay -S swaync