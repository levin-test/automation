#!/bin/bash

yay -Syu
# paru -Syu
echo ""

# 青色のANSIエスケープコード
BLUE='\e[1;34m'

# リセットコード
NC='\e[0;0m'

echo ""
echo -e "${BLUE}:: Flatpakのアップデートを確認中...${NC}"
flatpak update

echo ""
echo -e "${BLUE}:: NeovimでLazySyncを実行中...${NC}"
nvim --headless "+Lazy! sync" +qa

echo ""
echo -e "${BLUE}:: すべてのアップデートが完了しました。${NC}"
