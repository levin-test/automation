#!/usr/bin/env bash

# Arch系ディストリビューションセットアップ用スクリプト
# 必要なパッケージリストを表示（テスト用）
# 今後、実際のインストール処理を追加予定

pacman_list=(
  # must have
  chezmoi
  eza
  fcitx5-mozc
  fd
  firefox
  fish
  flatpak
  fzf
  hyprland
  neovim
  rclone
  starship
  vim
  vivaldi
  xdg-user-dirs
  xdg-utils
  zoxide
  zed
  # hyprland
  waybar
  # dev tools
  docker
  git
  git-delta
  github-cli
  glab
  lazygit
  # utilities
  cava
  fastfetch
  ffmpeg
  htop
  nvtop
  # gaming and videos
  kdenlive
  obs-studio
  steam
)

cachyos_pkg=(
  proton-cachyos
)

aur_list=(
  # browsers
  google-chrome
  visual-studio-code-bin
)

flatpak_list=(
  # mail client
  # Thunderbird
  org.mozilla.Thunderbird

  # GPU monitor
  # Misson Center
  io.missioncenter.MissionCenter

  # graphics
  # Upscayl
  org.upscayl.Upscayl

  # Video Editing
  # Video Trimmer
  org.gnome.gitlab.YaLTeR.VideoTrimmer

  # recorder
  # GPU Screen Recorder
  com.dec05eba.gpu_screen_recorder

  # gaming
  # ProtonUp-Qt
  net.davidotek.pupgui2

  # converter
  # HandBrake
  fr.handbrake.ghb

  # wine managers
  # Bottles
  com.usebottles.bottles
  # LocalSend
  org.localsend.localsend_app

  # backup tools
  org.gnome.World.PikaBackup
)

# テスト実行用フラグ（trueなら表示のみ、falseならインストール処理も実行）
TEST_MODE=true

echo "--pacman--"
printf "%s\n" "${pacman_list[@]}"
echo "--aur--"
printf "%s\n" "${aur_list[@]}"
echo "--flatpak--"
printf "%s\n" "${flatpak_list[@]}"

# 実際のインストール処理（TEST_MODE=falseのときのみ実行）
if [ "$TEST_MODE" = false ]; then
  # pacman
  sudo pacman -S --needed ${pacman_list[@]}

  # cachyos
  sudo pacman -S --needed ${cachyos_pkg[@]}

  # aur (yayが必要)
  yay -S --needed ${aur_list[@]}

  # flatpak
  for pkg in "${flatpak_list[@]}"; do
    flatpak install -y "$pkg"
  done
fi

cd "$HOME"

# Dockerと共有するためのディレクトリを作成
## 作成されるディレクトリ構造
# ~/docker-data/
# ├── downloads
# │   ├── raw
# │   ├── processed
# │   └── archive
# └── scripts
#     ├── active
#     ├── development
#     └── templates
mkdir -p ~/docker-data/{downloads/{raw,processed,archive},scripts/{active,development,templates}}
