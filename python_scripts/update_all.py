import subprocess
from time import sleep

BLUE = "\033[1;34m"
NC = "\033[0;0m"


def is_command_exists(command: str):
    try:
        subprocess.run(
            [command, "--version"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
        return True
    except FileNotFoundError:
        return False


def run_command(cmd):
    print(f"{BLUE}:: {cmd}によるアップデートを実行中...{NC}")
    subprocess.run(cmd, shell=True)


if __name__ == "__main__":
    if is_command_exists("yay"):
        run_command("yay -Syu")
    elif is_command_exists("paru"):
        run_command("paru -Syu")
    else:
        run_command("sudo pacman -Syu")

    sleep(1)

    if is_command_exists("flatpak"):
        run_command("flatpak update")

    sleep(1)

    if is_command_exists("nvim"):
        run_command("nvim --headless '+Lazy! sync' +qa")

    sleep(1)

    print("\n" + f"{BLUE}:: すべてのアップデートが完了しました{NC}")
