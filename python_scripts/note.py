import datetime
import os
import subprocess
import jinja2

home_dir = os.path.expanduser("~")
notes_dir = home_dir + "/Workspaces/notes/"

# Get current date
today = datetime.date.today().strftime("%Y%m%d")

# Create a file name base on the date
filepath = notes_dir + today + ".md"
print(filepath)

# Check if the Notes Directory exists
try:
    os.makedirs(notes_dir, exist_ok=False)
    print(f"ディレクトリ {notes_dir} を作成しました。")
except OSError as e:
    print(e)


# TODO

# Check if the corresponding file exists

# Open the file with neovim
# subprocess.run("nvim")
