import os
import sys
import datetime
import shutil
import py7zr

# バックアップ格納用ディレクトリがなかった場合は新規作成する。
home_dir = os.path.expanduser("~")
backup_dir = os.path.join(home_dir, "full_backup")
os.makedirs(backup_dir, exist_ok=True)

# 対象日のバックアップディレクトリ・ファイル名の生成する。
today = datetime.date.today().strftime("%Y-%m-%d")
target_dirname = os.path.join(backup_dir, (today + "_fullbackup"))
target_filename = target_dirname + ".7z"

# バックアップファイルがすでに存在している場合、再作成するかどうか尋ねる。
# 再作成しない場合はプロセスを終了する。
if os.path.exists(target_filename):
    while True:
        choice = input(
            "すでにバックアップファイルが存在します。再作成しますか？ [y/n]: "
        ).lower()
        if choice == "y":
            break
        elif choice == "n":
            print("処理を中断しました。")
            sys.exit()
        else:
            print("正しい値を入力してください。")

os.makedirs(target_dirname, exist_ok=True)


def copy_dirs(dir_list: dict, copy_dst: str):
    """引数(dict)のkeyに含まれるすべてのディレクトリをcopy_dstで指定されたディレクトリへコピーする。
    valueには除外リストを指定する。

    Args:
        dir_list:コピー対象ディレクトリのリスト
        target_dir:コピー先のディレクトリ

    Returns:
        None
    """

    for key, value in dir_list.items():
        src = os.path.join(home_dir, key)
        dst = os.path.join(copy_dst, key)
        shutil.copytree(src, dst, dirs_exist_ok=True)
        print(key, "のコピーが完了しました。")

    return None


copy_target_list = {
    "Documents": None,
    "Desktop": None,
    "Pictures": None,
    ".fonts": None,
    "AppImages": None,
    "Workspaces": None,
}

copy_dirs(copy_target_list, target_dirname)

# プロセス完了のメッセージ
print("バックアップが完了しました。")
