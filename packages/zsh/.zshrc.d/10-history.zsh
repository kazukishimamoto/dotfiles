# ~/.zshrc.d/10-history.zsh

HISTFILE=$HOME/.zsh-history   # 履歴を保存するファイル
HISTSIZE=100000               # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000              # 上述のファイルに保存する履歴のサイズ

setopt share_history          # 履歴を他のシェルとリアルタイム共有する（inc_append_history を含む）
setopt extended_history       # 実行時刻と実行時間も記録する
setopt hist_ignore_all_dups   # 同じコマンドが既にあれば古いほうを削除する
setopt hist_ignore_space      # 先頭が空白のコマンドは記録しない（一時的なコマンドを残さない）
setopt hist_reduce_blanks     # 余分な空白を詰めて記録する
setopt hist_verify            # 履歴展開したら即実行せず、一度行に展開して確認できるようにする
