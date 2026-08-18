# 環境（どのモードでも必要）
export LANG=en_US.UTF-8
# 慣習として EDITOR は端末内で完結するエディタ、VISUAL はフル機能のエディタを指す
export EDITOR=vim
export VISUAL=vim
export PAGER=less

# PATH（非対話でも効かせたいものだけ）
typeset -gU path PATH
path=(
  $HOME/.local/bin
  $HOME/.git-bin
  /usr/local/bin /usr/local/sbin
  $path
)

# --- Homebrew ---
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# VS Code があればフル機能のエディタとして使う。
# --wait を付けないと編集の完了を待たずに終了してしまうため必ず付ける。
# commands は PATH を参照するので、PATH を組み立てた後に判定する。
(( $+commands[code] )) && export VISUAL='code --wait'

# less
export LESS='-g -i -M -R -S -w -X -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
