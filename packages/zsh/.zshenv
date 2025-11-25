# 環境（どのモードでも必要）
export LANG=en_US.UTF-8
export EDITOR=code
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

# less
export LESS='-g -i -M -R -S -w -X -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
