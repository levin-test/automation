# zf-launcher (Go implementation)

Bash版 `zf-launcher2` のGo実装。

## ビルド

```bash
cd ~/automation/go/zf-launcher
make build
```

## インストール

```bash
make install
```

## 開発

```bash
# ビルド
go build -o zf-launcher ./cmd/zf-launcher

# テスト
go test -v ./...

# フォーマット
go fmt ./...
```

## 設定ファイル

`~/.config/zf-launcher/config.yaml` (shell/配下から stow で symlink)
