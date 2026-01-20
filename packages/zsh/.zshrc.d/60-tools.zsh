# ~/.zshrc.d/60-tools.zsh

# Starship
eval "$(starship init zsh)"
# z setting
. /opt/homebrew/etc/profile.d/z.sh
# direnv
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

eval "$(fnm env --use-on-cd --shell zsh)"
