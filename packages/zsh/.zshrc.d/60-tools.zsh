# ~/.zshrc.d/60-tools.zsh

# Starship
eval "$(starship init zsh)"
# z setting
. /opt/homebrew/etc/profile.d/z.sh
# direnv
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
