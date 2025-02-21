# -*- coding: utf-8 -*-

import os
import sys
import datetime
import shutil
import subprocess
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

# NOTE: debug
shutil.rmtree(backup_dir)
os.makedirs(target_dirname, exist_ok=True)


def copy_dirs(dir_dict: dict, copy_dst: str):
    """引数(dict)のkeyに含まれるすべてのディレクトリをcopy_dstで指定されたディレクトリへコピーする。
    valueには除外リストを指定する。

    Args:
        dir_dict:辞書。キーにはコピー対象ディレクトリ、値には除外対象のリスト
        target_dir:コピー先のディレクトリ

    Returns:
        None
    """

    for key, ignored_option in dir_dict.items():
        src = os.path.join(home_dir, key)
        command_sentence = ["rsync", "-avz", "--progress"]

        if ignored_option is not None:
            for i in range(len(ignored_option)):
                command_sentence.extend(["--exclude"])
                command_sentence.extend([ignored_option[i]])

        command_sentence.extend([src, copy_dst])

        subprocess.run(command_sentence)

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

# TODO: ディレクトリを7zファイルにする。暗号化も忘れずに。
password = input("Enter password: ")
with py7zr.SevenZipFile(target_filename, "w", password=password) as archive:
    archive.writeall(target_dirname)


# プロセス完了のメッセージ
print("バックアップが完了しました。")
