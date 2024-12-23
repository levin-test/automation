import subprocess
import time

BLUE = "\033[1;34m"
NC = "\033[0;0m"


def is_command_exists(command: str):
    devnull = subprocess.DEVNULL
    try:
        subprocess.run([command, "--version"], stdout=devnull, stderr=devnull)
        return True
    except FileNotFoundError:
        return False


def run_command(cmd, sec=0.5, COLOR="\033[1;34m", NC="\033[0;0m"):
    def show_progress(word):
        for char in word:
            print(f"{COLOR}{char}{NC}", end="", flush=True)
            time.sleep(sec)
        print(f"{COLOR}!{NC}")

    print(f"{COLOR}:: {cmd}によるアップデートを実行中{NC}", end="")
    show_progress(".....")
    subprocess.run(cmd, shell=True)


if __name__ == "__main__":
    if is_command_exists("yay"):
        run_command("yay -Syu", 0, BLUE, NC)
    elif is_command_exists("paru"):
        run_command("paru -Syu", 0.3, BLUE, NC)
    else:
        run_command("sudo pacman -Syu", 0.3, BLUE, NC)

    if is_command_exists("flatpak"):
        run_command("flatpak update", 0.3, BLUE, NC)
        run_command("flatpak uninstall --unused", 0.1, BLUE, NC)

    if is_command_exists("nvim"):
        run_command("nvim --headless '+Lazy! sync' +qa", 0.3, BLUE, NC)

    print("\n" + f"{BLUE}:: すべてのアップデートが完了しました{NC}")
