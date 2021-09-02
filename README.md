# dotfiles

## インストールスクリプト

```zsh
curl -o - https://raw.githubusercontent.com/kazukishimamoto/dotfiles/main/install | zsh
```

## ファイル構成

```bash
.
├── Brewfile
├── Brewfile.lock.json
├── README.md
├── extensions
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
    ├── vscode
    │   ├── keybindings.json
    │   └── settings.json
    └── zsh
        └── .zshrc
```
