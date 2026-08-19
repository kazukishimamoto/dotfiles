# fzf で git のコミットを選んでコマンドラインに挿入する ZLE ウィジェットの例
#
# このファイルは読み込まれない。`.zshrc` が読むのは `.zshrc.d/` 直下の
# `NN-*.zsh` だけで、`examples/` はシンボリックリンクの対象にもしていない。
#
# 以前は `.zshrc.d/50-functions.zsh` として常時読み込み、Ctrl-g l に割り当てていたが、
# 実際には使っておらず、herdr の prefix（ctrl+g）と衝突していたため外した。
# ZLE ウィジェットを自作するときの雛形として残してある。
#
# 使いたくなったら `.zshrc.d/50-functions.zsh` などにコピーする。
# その際 herdr の中では Ctrl-g が prefix に奪われるため、
# 別のキー（例: "^o"）に割り当てるか、herdr の prefix を変更すること。

# git log を fzf に流し、選んだコミットの短縮ハッシュを空白区切りで返す
select_commit_from_git_log() {
  git log -n1000 --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |\
    fzf -m --ansi --no-sort --reverse --tiebreak=index --preview 'f() {
      set -- $(echo "$@" | grep -o "[a-f0-9]\{7\}" | head -1);
      if [ $1 ]; then
        git show --color $1
      else
        echo "blank"
      fi
    }; f {}' |\
    grep -o "[a-f0-9]\{7\}" |
    tr '\n' ' '
}

# 選んだハッシュをカーソル位置に挿入する ZLE ウィジェット
insert_selected_git_logs(){
    LBUFFER+=$(select_commit_from_git_log)
    CURSOR=$#LBUFFER
    zle reset-prompt
}
zle -N insert_selected_git_logs
bindkey "^gl" insert_selected_git_logs
