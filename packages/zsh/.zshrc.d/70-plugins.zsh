# ~/.zshrc.d/70-plugins.zsh

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

# 補完定義を追加するプラグインは compinit より先に読み込む
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# 補完システムの初期化。
# 1 日 1 回だけ完全な検査を行い、それ以外はキャッシュを使って起動を速くする。
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zinit cdreplay -q   # プラグインが登録した compdef を反映する

# シンタックスハイライトは他のウィジェット定義より後に読み込む必要がある
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zdharma-continuum/history-search-multi-word

# ↑のどこかで別のkeybindが設定されてしまうので上書きする
bindkey '^K' kill-line
