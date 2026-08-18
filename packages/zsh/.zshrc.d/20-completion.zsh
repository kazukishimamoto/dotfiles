# ~/.zshrc.d/20-completion.zsh

# 補完の初期化（compinit）はここでは行わない。
# zinit で読み込む zsh-completions の補完定義を拾えるようにするため、
# プラグインを読み込んだ後の 70-plugins.zsh で実行している。

# 補完の設定
## 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
## 補完結果のグループ化
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
