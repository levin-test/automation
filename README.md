# automation

## 概要

このリポジトリは、個人の環境で利用するスクリプトや設定ファイルを管理します。

## セットアップと運用

このリポジトリのスクリプトを `~/.local/bin` に配置してパスを通すには、[GNU Stow](https://www.gnu.org/software/stow/) を利用します。

### 1. インストール

`stow`がシステムにインストールされていることを確認してください。

リポジトリのルートディレクトリで以下のコマンドを実行すると、`bin`ディレクトリ内の各スクリプトへのシンボリックリンクが `~/.local/bin` ディレクトリ内に作成されます。

```bash
stow -t ~/.local/bin bin
```

### 2. 設定ファイルの配置

設定ファイルを `~/.config` に配置するには、リポジトリのルートディレクトリで以下のコマンドを実行します。

```bash
stow -t ~ .config
```

このコマンドで、`.config` ディレクトリ内のファイルが `~/.config` ディレクトリ内にシンボリックリンクとして配置されます。

例）`zf-launcher` の設定ファイル：

```text
# リポジトリ内のパス
.config/zf-launcher/config.yaml

# ホームディレクトリ内のリンク先
~/.config/zf-launcher/config.yaml
```

### 3. アンインストール

シンボリックリンクを解除するには、`-D` (delete) オプションを利用します。

スクリプト：

```bash
stow -D -t ~/.local/bin bin
```

設定ファイル：

```bash
stow -D -t ~ .config
```
