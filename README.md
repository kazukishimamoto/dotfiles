# dotfiles

macOS 用の設定ファイル。zsh が既定のシェルであることを前提にしている。

## 新しい Mac のセットアップ

### 1. Homebrew を入れる

[公式サイト](https://brew.sh/ja/)のインストーラを実行する。

インストーラは設定ファイルを書き換えない。完了時に「Next steps」として次の 3 行を表示するだけ。

```sh
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**このうち最後の 1 行だけを実行すればよい。**

```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

`~/.zprofile` への追記（上の 2 行）は不要。手順 4 で配置する `.zshenv` が同じことをしており、
そちらは非対話シェルでも読まれるぶん `.zprofile` より広くカバーするため。
最後の `eval` は「いま開いているシェルに brew を通す」ために必要で、
これが無いと手順 3 の `brew bundle` が command not found になる。
手順 2 以降は同じターミナルで続けて実行すること。

### 2. このリポジトリを clone する

```sh
mkdir -p ~/dev
git clone https://github.com/kazukishimamoto/dotfiles.git ~/dev/dotfiles
```

`~/dev/dotfiles` 以外に置く場合は、以降のコマンドで `DOTFILES=<置いた場所>` を指定する。

### 3. ツールを入れる

```sh
brew bundle --file=~/dev/dotfiles/Brewfile
```

### 4. 設定ファイルを配置する

```sh
~/dev/dotfiles/install
```

ホームディレクトリにシンボリックリンクを張るだけのスクリプト。何度実行してもよい。
既にある `~/.gitconfig-local` は上書きしない。

> **注意: 既存の設定ファイルは退避されない**
>
> 買ったばかりの Mac のように、ホームディレクトリに設定ファイルが無い状態で実行する分には問題ない。
> しかし **すでに `~/.zshrc` などを自分で書いている環境で実行すると、その内容は失われる。**
> install はバックアップを取らないので、必要なら事前に自分で退避しておくこと。
>
> 具体的には配置先の状態によって次のようになる。
>
> | 配置先の状態 | 実行結果 |
> | --- | --- |
> | 何もない | 普通にリンクが張られる |
> | このリポジトリへのリンク | 張り直されるだけで実質何も起きない |
> | **自分で書いた実ファイル**（例: `~/.zshrc`） | **警告もバックアップも無くリンクに置き換わり、内容は消える** |
> | **自分で作った実ディレクトリ**（例: `~/.zshrc.d`） | **`~/.zshrc.d/.zshrc.d` という入れ子のリンクができるだけで、設定は読み込まれない。しかもエラーにならず成功したように見える** |
>
> 実ディレクトリのケースは `ln -sfn` の `-n` が「シンボリックリンクを辿らない」オプションであり、
> 実ディレクトリには効かないために起きる。気づきにくいので、既存環境で実行したあとは
> `ls -la ~ | grep dotfiles` でリンク先を確認するとよい。
>
> 事前に退避する例:
>
> ```sh
> mv ~/.zshrc ~/.zshrc.bak
> mv ~/.zshrc.d ~/.zshrc.d.bak
> ```

配置後の `~/.zshrc` などはこのリポジトリへのシンボリックリンクになる。
そのため `echo ... >> ~/.zshrc` のような追記は、リンクをたどって
`packages/zsh/.zshrc` 本体を直接書き換える。ツールの案内どおりに追記したときは
`git status` に差分が出ていないか確認すること。
マシン固有の設定は `packages/zsh/.zshrc.d/99-local.zsh` に書く。

### 5. 手作業（自動化できないもの）

- GPG 鍵を復元し、`~/.gitconfig-local` に signingkey を書く
  （`commit.gpgsign = true` のため、これをやらないとコミットできない）
- `gh auth login`
- ターミナルのフォントを Nerd Font に設定する
- VS Code の拡張機能を復元する（下記）

### VS Code の拡張機能について

拡張機能は Brewfile では管理せず、**VS Code の設定同期（Settings Sync）に任せる**。
拡張が 30 件以上あり更新も頻繁なため、Brewfile に列挙すると実態とすぐズレるため。

1. VS Code を起動する
2. 左下の歯車アイコン → 「設定の同期をオンにする」
3. 同期する項目（設定・キーボードショートカット・拡張機能・UI の状態）を選ぶ
4. GitHub アカウントでサインインすると、拡張機能と設定が自動で復元される

## 設定を変更したときの確認

```sh
./test-install
```

`/tmp/dotfiles-test` を空のホームディレクトリに見立てて install を実行し、
リンクが正しく張れたか、2 回実行しても壊れないかを確認する。
**本番のホームディレクトリには一切触らない。**

実際にまっさらな環境のシェルに入って確かめたいときは、確認後に案内されるコマンドを実行する。

```sh
env HOME=/tmp/dotfiles-test zsh -l   # 抜けるときは exit
rm -rf /tmp/dotfiles-test            # 片付け
```

## 構成

```
Brewfile              brew bundle で入れるツールの一覧
install               設定ファイルを配置する（これだけが本体）
test-install          install を安全に確認するスクリプト
packages/
  git/                .gitconfig, .gitignore_global, git のサブコマンド（.git-bin/）
  nvim/               neovim の設定（現在 install の配置対象外）
  starship/           プロンプトの設定
  tmux/               tmux の設定
  zsh/                .zshenv, .zshrc, .zshrc.d/ 以下のモジュール
```

`packages/zsh/.zshrc.d/` は番号順に読み込まれる。
マシン固有の設定や実験中の設定は `99-local.zsh` に書く。

## CI

`.github/workflows/check.yml` で以下を確認している。

- **links** (Ubuntu) — 毎 push。`test-install` を実行する。5 秒ほどで終わる。
- **fresh-mac** (macOS) — **手動実行と月 1 回の定期実行のみ**。毎回まっさらな macOS 上で
  上記の手順 3〜4 を実際に流し、新しいシェルが起動して主要コマンドが使えるところまで確認する。
  新しい Mac でセットアップが通るかを、手元の環境を壊さずに確かめられる。

`fresh-mac` を毎 push で回さないのは、知りたいのが「新しい Mac で再現できるか」であって
日常の変更ごとに必要な情報ではないため。macOS ランナーは混雑時に長く待たされることもある。
新しい Mac を買う前や Brewfile / zsh 設定を大きく変えたときは、手動で回す。

```sh
gh workflow run check.yml
```
