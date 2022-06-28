#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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
alias ls="exa"
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
alias dkc="docker-compose"
alias dkm="docker-machine"
alias dkce="docker-compose exec"

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
dct() { docker-compose $1 teachme_web "${@:2}" }

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

function select_history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select_history
bindkey '^r' select_history

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
