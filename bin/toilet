#!/usr/bin/env bash
# 文字列を複数フォントで表示するサンプルスクリプト

# toiletコマンドがインストールされているか確認
if ! command -v toilet &> /dev/null; then
  echo "Error: toilet コマンドが見つかりません。インストールしてください。" >&2
  exit 1
fi

read -p "string?: " test_string
# 入力が空の場合は終了
if [ -z "$test_string" ]; then
  echo "入力が空です。終了します。"
  exit 0
fi

fonts=(ascii12 bigascii9 circle future mono9 smascii9 smmono12)
for font in "${fonts[@]}"; do
  echo "$font"
  # フォントが使えない場合はスキップ
  if toilet -F list | grep -qw "$font"; then
    toilet -w $(tput cols) -f "$font" "$test_string"
  else
    echo "(フォント '$font' は未インストールまたは利用不可)"
  fi
done
# 変数が存在する場合のみunset
unset test_string
read -p "string?: " test_string
for font in ascii12 bigascii9 circle future mono9 smascii9 smmono12; do
  echo "$font"
  toilet -w $(tput cols) -f $font "$test_string"
done
unset test_string
