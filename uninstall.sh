#!/bin/sh

rm -rf ~/.antigen ~/.oh-my-zsh
rm ~/.zsh* ~/antigen.zsh
sudo apt remove --purge zsh
mv ~/.profile.pre-zsh ~/.profile

echo -e "You successfully removed ZSH"
read -p "Press Enter to continue..."