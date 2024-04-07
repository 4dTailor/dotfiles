#!/bin/sh

# Install Oh My Posh on the system
mkdir -p ~/.local/bin ~/.local/lib
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

# Install a nerd font
if [ -d "~/.local/share/fonts" ]; then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    sudo apt install unzip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Agave.zip
    unzip Agave.zip
    fc-cache -f -v
    rm Agave.zip
fi

# Create symbolic links with files in the dotfiles directory (NB: Replaces existing files)
ln -sf $PWD/.bashrc ~/.bashrc 
ln -sf $PWD/.gitconfig ~/.gitconfig
echo "Successfully set symbolic links to files"


echo "Remember to set Agave Nerd Font Mono to the terminal"
