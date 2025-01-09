#!/usr/bin/env bash

pacman_list=(
  # must have
  eza
  fcitx5-mozc
  firefox
  fish
  flatpak
  hyprland
  neovim
  starship
  vim
  xdg-user-dirs
  xdg-utils
  zoxide
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
  zen-browser
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
  org.gnome.DejaDup
)

echo "--pacman--"
echo ${pacman_list[@]}
echo "--aur--"
echo ${aur_list[@]}
echo "--flatpak--"
echo ${flatpak_list[@]}

cd $HOME
