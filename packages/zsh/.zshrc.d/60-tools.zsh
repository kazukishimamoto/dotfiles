# ~/.zshrc.d/60-tools.zsh
#
# 外部ツールのシェル連携。
# 未インストールのマシンでも .zshrc の読み込みが止まらないよう、すべて存在を確認してから実行する。

# Starship（プロンプト）
command -v starship > /dev/null && eval "$(starship init zsh)"

# z（よく使うディレクトリへのジャンプ）
z_script="${HOMEBREW_PREFIX:-/opt/homebrew}/etc/profile.d/z.sh"
[ -f "$z_script" ] && . "$z_script"
unset z_script

# direnv（ディレクトリごとの環境変数）
command -v direnv > /dev/null && eval "$(direnv hook zsh)"

# fnm（Node.js のバージョン管理）
command -v fnm > /dev/null && eval "$(fnm env --use-on-cd --shell zsh)"

# fzf
# Ctrl-T でファイル選択、Alt-C でディレクトリ移動が使えるようになる。
# Ctrl-R は後から読み込む history-search-multi-word が上書きするため、そちらが優先される。
export FZF_DEFAULT_OPTS='--reverse --border'
command -v fzf > /dev/null && source <(fzf --zsh)
