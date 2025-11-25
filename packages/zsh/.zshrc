# ~/.zshrc —— エントリポイント

# 1) 非対話なら即終了（スクリプト実行時の副作用を防ぐ）
[[ -o interactive ]] || return

# 2) 便利系オプション（glob 失敗でエラーにしない等）
setopt extended_glob      # 高機能グロブ（()や~など）を有効化
setopt no_nomatch         # グロブがマッチしなくてもエラーにしない
setopt typeset_silent     # typeset の冗長出力を抑制

# 3) モジュール格納ディレクトリの決定
ZSHRC_DIR="${ZDOTDIR:-$HOME}/.zshrc.d"

# 4) モジュールの読み込み
#    - 00-*.zsh, 10-*.zsh, ... の順に読む
#    - .N（null_glob相当）で「該当が無い場合は無視」
if [[ -d "$ZSHRC_DIR" ]]; then
  for f in "$ZSHRC_DIR"/[0-9][0-9]-*.zsh(.N); do
    source "$f"
  done
fi
