#!/bin/bash

# ==============================================================================
# チャットログ用 簡易ファイル作成スクリプト
#
# 説明:
#   指定されたディレクトリに、日付名のMarkdownファイルを作成します。
#   日々のチャットログを整理・保存する目的で作成されました。
#
# 使い方:
#   ./mklog.sh [オプション]
#
# オプション:
#   引数なし: 今日の日付でファイルを作成します。
#   p<数字> : <数字>日後の日付でファイルを作成します。(例: p1 は明日)
#   m<数字> : <数字>日前の日付でファイルを作成します。(例: m7 は7日前)
#   -h, --help: このヘルプメッセージを表示します。
# ==============================================================================

# --- 設定項目 ---
# ファイルを作成する対象のディレクトリをここに列挙します。
# 新しいサービスを追加する場合は、このリストに追記してください。
TARGET_DIRS=(
  "$HOME/Documents/Gemini_Archives"
  "$HOME/Documents/Claude_Archives"
  "$HOME/Documents/Openai_Archives"
)
# --- 設定項目ここまで ---

# ヘルプメッセージを表示する関数
show_help() {
  # スクリプト自身のヘッダコメント部分を表示する
  grep '^#' "$0" | cut -c 3-
}

# 引数がヘルプオプションの場合、ヘルプを表示して終了
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# 日付を計算する
DATE_MODIFIER=""
if [ -z "$1" ]; then
  # 引数がない場合は今日の日付
  DATE_MODIFIER="today"
else
  # 引数の形式をチェック (p or m + 数字)
  if [[ "$1" =~ ^[pm][0-9]+$ ]]; then
    # pかmかを判定
    if [[ "$1" == p* ]]; then
      # pの場合、数字部分を抽出して「+N days」の形式にする
      DAYS=${1#p}
      DATE_MODIFIER="$DAYS days"
    else
      # mの場合、数字部分を抽出して「-N days」の形式にする
      DAYS=${1#m}
      DATE_MODIFIER="-$DAYS days"
    fi
  else
    echo "エラー: オプションの形式が正しくありません。'p1' や 'm7' のように指定してください。" >&2
    echo "詳しくは -h または --help をご覧ください。" >&2
    exit 1
  fi
fi

# `date`コマンドで最終的な日付文字列を生成
# macOSとLinuxで互換性のある書き方
if [[ $(uname) == "Darwin" ]]; then
  # macOSの場合
  TARGET_DATE=$(date -v"${DATE_MODIFIER// /}" "+%Y-%m-%d")
else
  # Linux (GNU)の場合
  TARGET_DATE=$(date -d "$DATE_MODIFIER" "+%Y-%m-%d")
fi

# 作成対象となるファイルのリストを作成
FILE_PATHS=()
for dir in "${TARGET_DIRS[@]}"; do
  FILE_PATHS+=("$dir/$TARGET_DATE.md")
done

# 作成前の確認
echo "■ ファイル作成プレビュー"
echo "--------------------------------------------------"
echo "以下のファイルを作成します。"
echo ""

PREVIEW_EXISTS=()
for path in "${FILE_PATHS[@]}"; do
  if [ -e "$path" ]; then
    echo "  - $path (既に存在します)"
    PREVIEW_EXISTS+=("true")
  else
    echo "  - $path"
    PREVIEW_EXISTS+=("false")
  fi
done

echo "--------------------------------------------------"

# 全てのファイルが既に存在する場合は、確認せずに終了
if [[ ! " ${PREVIEW_EXISTS[@]} " =~ "false" ]]; then
  echo "全ての対象ファイルが既に存在するため、処理をスキップしました。"
  exit 0
fi

read -p "よろしいですか？ (y/N): " answer

# yまたはYが入力された場合のみ処理を続行
if [[ "$answer" != "y" ]] && [[ "$answer" != "Y" ]]; then
  echo "キャンセルしました。"
  exit 0
fi

echo ""
echo "■ ファイル作成実行"
echo "--------------------------------------------------"

# ファイル作成処理
for path in "${FILE_PATHS[@]}"; do
  # ディレクトリ部分を取得
  dir_path=$(dirname "$path")

  # ディレクトリが存在しない場合の処理
  if [ ! -d "$dir_path" ]; then
    echo "ディレクトリが存在しません: $dir_path"
    read -p "作成しますか？ (y/N): " create_dir_answer
    if [[ "$create_dir_answer" == "y" ]] || [[ "$create_dir_answer" == "Y" ]]; then
      mkdir -p "$dir_path"
      if [ $? -eq 0 ]; then
        echo "  -> ディレクトリを作成しました。"
      else
        echo "  -> エラー: ディレクトリの作成に失敗しました。このファイルの作成をスキップします。" >&2
        continue # 次のループへ
      fi
    else
      echo "  -> スキップしました。"
      continue
    fi
  fi

  # ファイルが存在しない場合のみ作成
  if [ ! -e "$path" ]; then
    touch "$path"
    if [ $? -eq 0 ]; then
      echo "作成しました: $path"
    else
      echo "エラー: ファイルの作成に失敗しました: $path" >&2
    fi
  else
    echo "スキップしました (既存): $path"
  fi
done

echo "--------------------------------------------------"
echo "処理が完了しました。"
