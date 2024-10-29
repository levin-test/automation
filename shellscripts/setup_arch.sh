#!/usr/bin/env bash

pacman_list=(
  # must have
  firefox
  fish
  flatpak
  hyprland
  neovim
  vim
  starship
  # hyprland
  waybar
  # dev tools
  docker
  github-cli
  glab
  lazygit
  # utility
  htop
  nvtop
  fastfetch
  # gaming and videos
  obs-studio
  steam
)

aur_list=(
  google-chrome
)

flatpak_list=(
  test
)

echo "--pacman--"
echo ${pacman_list[@]}
echo "--aur--"
echo ${aur_list[@]}
echo "--flatpak--"
echo ${flatpak_list[@]}

cd $HOME
