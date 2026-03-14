#source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# Force my custom fastfetch config
fastfetch() {
    command fastfetch --config /home/erdem/erdconfig/fastfetch.jsonc "$@"
}

