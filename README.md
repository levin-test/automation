# automation

個人用自動化スクリプト・ツール集

## ディレクトリ構成

```
automation/
├── shell/          # シェルスクリプト（stow管理対象）
│   ├── .config/    # 設定ファイル
│   └── .local/bin/ # 実行可能スクリプト
├── go/             # Goプロジェクト
│   └── zf-launcher/
├── python/         # Pythonプロジェクト（将来用）
└── doc/            # ドキュメント
```

## セットアップ

### シェルスクリプトのインストール（stow使用）

```bash
cd ~/automation
stow -d ~/automation -t ~ shell
```

これにより以下が symlink されます：
- `~/automation/shell/.local/bin/*` → `~/.local/bin/*`
- `~/automation/shell/.config/*` → `~/.config/`

### Go プロジェクトのビルド

```bash
cd ~/automation/go/zf-launcher
make install
```

## 各ツールの説明

### シェルスクリプト

- **zf-launcher2**: ファイル検索・選択ランチャー（Bash版）
- **backup-7z**: 7z形式でのバックアップツール
- **chat-archiver**: チャット履歴アーカイブツール
- その他セットアップ・メンテナンススクリプト

### Goツール

- **zf-launcher**: zf-launcher2 のGo実装版

## stow の基本コマンド

```bash
# symlink 作成
stow -d ~/automation -t ~ shell

# symlink 削除
stow -D -d ~/automation -t ~ shell

# 既存 symlink を更新（再作成）
stow -R -d ~/automation -t ~ shell

# dry-run（実際には実行しない）
stow -n -v -d ~/automation -t ~ shell
```

## ライセンス

See LICENSE file.
