# dotfiles

## インストールスクリプト

```zsh
curl -o - https://raw.githubusercontent.com/kazukishimamoto/dotfiles/main/install | zsh
```

利用 OS は macOS を想定しており、zsh が規定のシェルになっていることが前提

## ファイル構成

```bash
.
├── Brewfile
├── Brewfile.lock.json
├── README.md
├── install
└── packages
    ├── git
    │   ├── .gitconfig
    │   └── .gitignore_global
    ├── starship
    │   └── .config
    │       └── starship.toml
    ├── tmux
    │   └── .tmux.conf
    └── zsh
        └── .zshrc
```
