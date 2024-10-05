import subprocess
from time import sleep

BLUE = "\033[1;34m"
NC = "\033[0;0m"


def run_command(cmd):
    print(f"{BLUE}:: {cmd}によるアップデートを実行中...{NC}")
    subprocess.run(cmd, shell=True)


if __name__ == "__main__":
    run_command("paru -Syu")
    sleep(1)
    run_command("flatpak update")

    print("\n" + f"{BLUE}:: すべてのアップデートが完了しました{NC}")
