#################################  HISTORY  #################################
# history
HISTFILE=$HOME/.zsh-history # 履歴を保存するファイル
HISTSIZE=100000             # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000            # 上述のファイルに保存する履歴のサイズ

# share .zshhistory
setopt inc_append_history   # 実行時に履歴をファイルにに追加していく
setopt share_history        # 履歴を他のシェルとリアルタイム共有する

#################################  COMPLEMENT  #################################
# enable completion
autoload -Uz compinit && compinit

# 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''


### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2
#################################  OTHERS  #################################
# automatically change directory when dir name is typed
setopt auto_cd

# disable ctrl+s, ctrl+q
setopt no_flow_control

# emacs keybind
bindkey -e

#
# Homebrew
#
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"
# z setting
. /opt/homebrew/etc/profile.d/z.sh

# alias
## global
alias -g G="| grep"
alias -g A='| awk'
# alias -g C='| pbcopy' # copy
alias -g C='| wc -l' # count
alias -g H='| head' # 当然tailもね
alias -g L='| less -R'
alias -g X='| xargs'
alias -g F='| fzf'

## utils
alias ls="eza"
alias ll="ls -l -g --icons"
alias la="ll -a"
alias cat="bat"
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias google="s -p google"
alias zshr="source ~/.zshrc"
alias zshconf="vim ~/.zshrc"

## docker
alias dk="docker"
alias dkv="docker volume"
alias dkn="docker network"
alias dka="docker attach"
alias dkc="docker compose"
alias dkm="docker-machine"
alias dkce="docker compose exec"

## git
### basic
alias g="git"
alias gtop="cd `git rev-parse --show-toplevel`"

## Zenn
# Zennのコンテンツ管理に移動
alias zenn='cd ~/Workspace/Zenn'
# Zennのコンテンツ管理ディレクトリに移動してVSCodeで開く & プレビュー表示
alias zennop='zenn && code ~/Workspace/Zenn && npx zenn preview --open --port 3333'
# 新しい記事をランダムなスラッグで作成
alias zennna='zenn && npx zenn new:article'
# 新しい記事をスラッグを指定して作成
alias zennnas='zenn && npx zenn new:article --slug'
# 新しい本をランダムなスラッグで作成
alias zennnb='zenn && npx zenn new:book'
# 新しい本をスラッグを指定して作成
alias zennnbs='zenn && npx zenn new:book --slug'
# ブラウザ上でプレビューを開く
alias zennpr='zenn && npx zenn preview --open --port 3333'

### fzf
export FZF_DEFAULT_OPTS='--reverse --border'
alias grs='g ol | fzf --preview="echo {} | awk '\''{print \$1}'\'' | xargs git diff --color" | awk '\''{print $1}'\'' | xargs git reset'
alias pr='gh pr list | fzf | awk '\''{print $1}'\'' | xargs gh pr view --web'
alias prb='gh pr list | fzf | awk '\''{print $1}'\'' | xargs gh pr checkout'

## kubectl
alias kc="kubectl"
alias kns="kubens"
alias kctx="kubectx"

## terraform
alias tf="terraform"

## circleci
alias ci="circleci"

## firebase
alias f="firebase"
alias fd="firebase deploy"
alias fdh="firebase deploy --only hosting"

## tmb
alias tmb="dkce teachme_web"
dct() { docker compose $1 teachme_web "${@:2}" }

# functions
## utils
clip () {
  cat $1 | pbcopy
}

cn () {
  (z $1 && code -n .)
}

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# function select_history() {
#   BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
#   CURSOR=$#BUFFER
# }
# zle -N select_history
# bindkey '^r' select_history

## git func
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
function insert_selected_git_logs(){
    LBUFFER+=$(select_commit_from_git_log)
    CURSOR=$#LBUFFER
    zle reset-prompt
}
zle -N insert_selected_git_logs
bindkey "^gl" insert_selected_git_logs

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kazuki.shimamoto/Workspace/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kazuki.shimamoto/Workspace/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/kazuki.shimamoto/Workspace/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kazuki.shimamoto/Workspace/google-cloud-sdk/completion.zsh.inc'; fi

# コマンドの存在確認
# type fzf >/dev/null 2>&1
# if [[ ! $? = 0 ]]; then
#   echo -e  "error: fzf command is not found.\n\nPlease install fzf command.\n ex) brew install fzf"
#   exit 1
# fi

# Homebrew shell Completion
# https://docs.brew.sh/Shell-Completion
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

#   autoload -Uz compinit
#   compinit
# fi

# heroku autocomplete setup
# HEROKU_AC_ZSH_SETUP_PATH=/Users/kazuki.shimamoto/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# terraform completion
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/Cellar/tfenv/2.2.0/versions/0.14.4/terraform terraform

## kubectl completion
# [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

############# zprofile #####################
#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR=code
export VISUAL='vim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# rbenv
eval "$(rbenv init - zsh)"
# nodenv
eval "$(nodenv init -)"
# direnv
eval "$(direnv hook zsh)"

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path
typeset -U path PATH

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

# local bin path
export PATH="$HOME/.local/bin:$PATH"
# git script path
export PATH="$HOME/.git-bin:$PATH"

# go path
export GOPATH=$HOME/go
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"

# aqua
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
export LESS='-g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit light zdharma/fast-syntax-highlighting

zinit light zsh-users/zsh-autosuggestions

zinit light zsh-users/zsh-completions

zinit light zdharma/history-search-multi-word

# ↑のどこかで別のkeybindが設定されてしまうので上書きする
bindkey '^K' kill-line
