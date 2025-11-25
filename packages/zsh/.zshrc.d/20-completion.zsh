# ~/.zshrc.d/20-completion.zsh

# zsh の保管システムをロード & 初期化
autoload -Uz compinit && compinit -C

# 補完の設定
## 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
## 補完結果のグループ化
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
