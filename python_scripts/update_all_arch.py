import subprocess  # サブプロセスを使って外部コマンドを実行するための標準ライブラリ
import time  # プログレス表示のために待機時間を設定するための標準ライブラリ
import shlex  # コマンド文字列を安全に分割するための標準ライブラリ

# ターミナルで文字色を変更するためのANSIエスケープコード
BLUE = "\033[1;34m"  # 青色
NC = "\033[0;0m"  # 色リセット


def is_command_exists(command: str):
    """
    指定したコマンドがシステムに存在するかどうかを判定する関数
    コマンドのバージョン表示を試み、存在しなければFalseを返す
    """
    devnull = subprocess.DEVNULL  # 標準出力・エラー出力を無視
    try:
        subprocess.run([command, "--version"], stdout=devnull, stderr=devnull)
        return True
    except FileNotFoundError:
        return False


def run_command(cmd, sec=0.5, color=BLUE):
    """
    コマンドを実行し、簡単なプログレス表示を行う関数
    cmd: 実行するコマンド文字列
    sec: プログレス表示の待機秒数
    color: 表示する文字色（固定で青色）
    """

    def show_progress(word):
        # プログレス用の文字列を1文字ずつ表示し、待機する
        for char in word:
            print(f"{color}{char}{NC}", end="", flush=True)
            time.sleep(sec)
        print(f"{color}!{NC}")

    print(f"{color}:: {cmd}によるアップデートを実行中{NC}", end="")
    show_progress(".....")
    subprocess.run(shlex.split(cmd))  # コマンド文字列を分割して安全に実行


if __name__ == "__main__":
    # yay, paru, pacmanの順でコマンドが存在するか確認し、システムアップデートを実行
    if is_command_exists("yay"):
        run_command("yay -Syu", 0)
    elif is_command_exists("paru"):
        run_command("paru -Syu", 0)
    else:
        run_command("sudo pacman -Syu", 0.3)

    # flatpakがインストールされていれば、flatpakのアップデートと未使用パッケージの削除を実行
    if is_command_exists("flatpak"):
        run_command("flatpak update", 0.3)
        run_command("flatpak uninstall --unused", 0.1)

    # nvimがインストールされていれば、Neovimプラグインの同期を実行
    if is_command_exists("nvim"):
        run_command("nvim --headless '+Lazy! sync' +qa", 0.3)

    # すべてのアップデートが完了したことを表示
    print("\n" + f"{BLUE}:: すべてのアップデートが完了しました{NC}")
