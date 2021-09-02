# dotfiles

## preztoのインストール

以下の3手順を実行する（詳しい情報は、preztoのREADMEに乗っている）

```bash

if [ ! -d ~/.zprezto ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

setopt EXTENDED_GLOB

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

## preztoのアンインストール

`rm -rf ~/.zprezto ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile ~/.zshenv ~/.zshrc`

## ファイル構成

```bash
❯ tree
.
├── Brewfile
├── Brewfile.lock.json
├── README.md
├── extensions
├── install
└── packages
    ├── git
    ├── starship
    ├── tmux
    ├── vscode
    │   ├── keybindings.json
    │   └── settings.json
    └── zsh

6 directories, 7 files
```
