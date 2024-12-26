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
  fastfetch
  # gaming and videos
  kdenlive
  obs-studio
  steam
)

aur_list=(
  # browsers
  google-chrome
  zen-browser
)

flatpak_list=(
  # GPU monitor
  io.missioncenter.MissionCenter
  # graphics
  org.upscayl.Upscayl
  # gaming
  net.davidotek.pupgui2
  # converter
  fr.handbrake.ghb
  # utilities
  com.usebottles.bottles
)

echo "--pacman--"
echo ${pacman_list[@]}
echo "--aur--"
echo ${aur_list[@]}
echo "--flatpak--"
echo ${flatpak_list[@]}

cd $HOME
