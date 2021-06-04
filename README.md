# dotfiles

## preztoのインストール
以下の3手順を実行する（詳しい情報は、preztoのREADMEに乗っている）
```
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"`

setopt EXTENDED_GLOB

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

## preztoのアンインストール
`rm -rf ~/.zprezto ~/.zlogin ~/.zlogout ~/.zpreztorc ~/.zprofile ~/.zshenv ~/.zshrc`

## ファイル構成
```
drwxr-xr-x   3 kazuki.shimamoto  staff    96B May 28 14:34 .config
-rw-r--r--   1 kazuki.shimamoto  staff   269B Jun  4 18:35 .envrc
drwxr-xr-x  13 kazuki.shimamoto  staff   416B Jun  4 18:45 .git
-rw-r--r--   1 kazuki.shimamoto  staff   770B May 28 14:40 .gitconfig
-rw-r--r--   1 kazuki.shimamoto  staff    14B May 31 09:23 .gitignore_global
-rw-r--r--   1 kazuki.shimamoto  staff   2.5K May 28 14:26 .tmux.conf
-rw-r--r--   1 kazuki.shimamoto  staff   1.0K May 30 17:16 .zlogin
-rw-r--r--   1 kazuki.shimamoto  staff   469B May 30 17:16 .zlogout
-rw-r--r--   1 kazuki.shimamoto  staff   1.0K May 30 17:16 .zprofile
-rw-r--r--   1 kazuki.shimamoto  staff   297B May 30 17:17 .zshenv
-rw-r--r--   1 kazuki.shimamoto  staff   3.3K Jun  1 17:07 .zshrc
```
