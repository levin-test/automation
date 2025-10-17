# automation

個人用自動化スクリプト・ツール集

## 概要

本リポジトリは、言語別にディレクトリを分類し、**stow** を使用して設定ファイルと実行可能スクリプトを一元管理しています。Git履歴を保持しながら、拡張性の高い構造を実現しています。

## ディレクトリ構成

```text
automation/
├── shell/              # シェルスクリプト（stow管理対象）
│   ├── .config/        # 設定ファイル → ~/.config にsymlink
│   │   └── zf-launcher/
│   │       └── config.yaml
│   └── .local/bin/     # 実行可能スクリプト → ~/.local/bin にsymlink
│       ├── backup-7z
│       ├── chat-archiver
│       ├── setup-arch
│       ├── setup-cachyos-hyprland
│       ├── toilet
│       ├── update-arch
│       ├── venv-setup
│       └── zf-launcher2
├── go/                 # Goプロジェクト
│   └── zf-launcher/    # zf-launcher2 のGo実装
│       ├── cmd/
│       ├── internal/
│       ├── .gitignore
│       ├── Makefile
│       ├── go.mod      (未作成)
│       └── README.md
├── python/             # Pythonプロジェクト（将来用）
│   └── .gitkeep
├── doc/                # ドキュメント
│   ├── how_to_setup_hyprland.md
│   └── README_ChatArchiver.md
├── LICENSE
├── README.md           # このファイル
└── vibe_prompt_draft.md
```

## セットアップ

### 初回セットアップ（新しいマシンなど）

#### 1. リポジトリをクローン

```bash
git clone https://github.com/levin-test/automation.git ~/automation
cd ~/automation
```

#### 2. シェルスクリプトのインストール（stow使用）

```bash
stow -d ~/automation -t ~ shell
```

**実行結果:**

- `~/automation/shell/.local/bin/*` が `~/.local/bin/*` にシンボリックリンク化
- `~/automation/shell/.config/*` が `~/.config/` にシンボリックリンク化

確認：

```bash
ls -la ~/.local/bin/zf-launcher2    # シンボリックリンク確認
cat ~/.config/zf-launcher/config.yaml  # 設定ファイル確認
```

#### 3. Go プロジェクトのセットアップ（オプション）

```bash
cd ~/automation/go/zf-launcher
make build     # バイナリをビルド
make install   # ~/.local/bin にインストール
```

### 既存環境からの更新

リポジトリを最新の状態に更新：

```bash
cd ~/automation
git pull

# 新しいスクリプトを反映（必要に応じて）
stow -R -d ~/automation -t ~ shell
```

## 各ツールの説明

### シェルスクリプト（shell/.local/bin/）

| スクリプト | 説明 |
|-----------|------|
| **zf-launcher2** | fzfを使用したインタラクティブなファイル検索・選択ランチャー（Bash版） |
| **backup-7z** | 7z形式でのバックアップツール |
| **chat-archiver** | チャット履歴アーカイブツール |
| **setup-arch** | Arch Linuxの初期セットアップスクリプト |
| **setup-cachyos-hyprland** | CachyOS + Hyprland の初期セットアップスクリプト |
| **update-arch** | Arch Linuxのアップデート・メンテナンススクリプト |
| **venv-setup** | Python仮想環境のセットアップ補助スクリプト |
| **toilet** | テキストをASCIIアートに変換するスクリプト |

### 設定ファイル（shell/.config/）

| ファイル | 説明 |
|---------|------|
| **zf-launcher/config.yaml** | zf-launcher2の設定ファイル（YAML形式） |

### Go プロジェクト（go/）

| プロジェクト | 説明 |
|------------|------|
| **zf-launcher** | zf-launcher2 のGo実装版（将来のリリース予定） |

## stow の使い方

### stowとは

**stow** は、ディレクトリ構造を保ったまま、別の場所にシンボリックリンクを作成するツールです。dotfiles管理に最適です。

### 基本コマンド

```bash
# シンボリックリンク作成
stow -d ~/automation -t ~ shell

# シンボリックリンク削除
stow -D -d ~/automation -t ~ shell

# 既存リンクを更新（削除してから再作成）
stow -R -d ~/automation -t ~ shell

# 実行前にプレビュー（ドライラン）
stow -n -v -d ~/automation -t ~ shell

# より詳細な情報を表示
stow -v -d ~/automation -t ~ shell
```

### オプション説明

| オプション | 説明 |
|----------|------|
| `-d DIR` | stow実行ディレクトリを指定（デフォルト: 現在のディレクトリ） |
| `-t DIR` | ターゲットディレクトリを指定（デフォルト: 親ディレクトリ） |
| `-S, --stow` | シンボリックリンクを作成（デフォルト） |
| `-D, --delete` | シンボリックリンクを削除 |
| `-R, --restow` | 既存リンクを削除して再作成 |
| `-n, --no` | ドライラン（実行しない） |
| `-v, --verbose` | 詳細情報を表示 |

## トラブルシューティング

### stowが競合エラーを出す場合

既存のファイルやリンクが原因の場合があります。

```bash
# 問題のあるファイルを確認（ドライラン）
stow -n -v -d ~/automation -t ~ shell

# 手動で削除してから再実行
rm ~/.config/zf-launcher  # または該当ファイル
stow -d ~/automation -t ~ shell
```

### シンボリックリンクが壊れている場合

```bash
# リンク先を確認
ls -la ~/.local/bin/zf-launcher2

# リポジトリの構造が正しいか確認
ls -la ~/automation/shell/.local/bin/

# リンクを再作成
stow -R -d ~/automation -t ~ shell
```

### 設定ファイルが反映されない場合

```bash
# 設定ファイルが正しくリンクされているか確認
cat ~/.config/zf-launcher/config.yaml

# 実装されているかリンク先を確認
ls -la ~/.config/zf-launcher/

# 必要に応じてリンクを再作成
stow -R -d ~/automation -t ~ shell
```

## 開発

### 新しいスクリプトを追加する場合

1. スクリプトを `shell/.local/bin/` に配置
2. 実行権限を付与: `chmod +x shell/.local/bin/your_script`
3. Gitで管理: `git add shell/.local/bin/your_script`
4. コミット: `git commit -m "feat: Add your_script"`
5. stowで反映: `stow -R -d ~/automation -t ~ shell`

### 設定ファイルを追加する場合

1. ファイルを `shell/.config/your_app/` に配置
2. Gitで管理: `git add shell/.config/your_app/`
3. コミット: `git commit -m "feat: Add config for your_app"`
4. stowで反映: `stow -R -d ~/automation -t ~ shell`

### Go プロジェクトを開発する場合

```bash
cd ~/automation/go/zf-launcher

# 初期化（初回のみ）
go mod init github.com/levin-test/zf-launcher

# ビルド
make build

# テスト
make test

# インストール
make install

# クリーンアップ
make clean
```

## 更新履歴

- **2025-10-18**: 言語別ディレクトリ構成に再編成。stow を使用した管理に統一。Git履歴を保持。

## ライセンス

See LICENSE file.
