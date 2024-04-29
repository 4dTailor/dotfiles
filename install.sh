#!/usr/bin/env bash

SCRIPT_NAME="SQ Script"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ ! $(command -v curl) ]; then
    echo "$SCRIPT_NAME - [ERROR] curl is not installed in your system"
    exit 1
fi

if [ ! $(command -v unzip) ]; then
    echo "$SCRIPT_NAME - [ERROR] unzip is not installed in your system"
    exit 1
fi


# Install Oh My Posh on the system
echo "$SCRIPT_NAME - Installing oh-my-posh"
mkdir -p ~/.local/bin ~/.local/lib
if [ ! -f ~/.local/bin/oh-my-posh ]; then
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi

FONT_LOCATION=~/.local/share/fonts
# Install a nerd font
if [ ! -d $FONT_LOCATION/Agave ]; then
    mkdir -p $FONT_LOCATION/Agave
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Agave.zip" -P $FONT_LOCATION/Agave
    unzip $FONT_LOCATION/Agave/Agave.zip -d $FONT_LOCATION/Agave
    fc-cache -v
    rm $FONT_LOCATION/Agave/Agave.zip
fi

# Create symbolic links with files in the dotfiles directory (NB: Replaces existing files)
echo -e "$SCRIPT_NAME - ${CL_WARN}[INFO] Symlinking config files"
ln -sf $SCRIPT_DIR/.bashrc ~/.bashrc 
ln -sf $SCRIPT_DIR/.gitconfig ~/.gitconfig

if [ -e /etc/i3 ]; then
    ln -sf $SCRIPT_DIR/i3/config ~/.config/i3/config
else
    echo -e "$SCRIPT_NAME - ${CL_WARN}[WARN] I3 not installed, not adding I3 config"
fi

echo -e "$SCRIPT_NAME - [INFO] Remember to set Agave Nerd Font Mono to the terminal"
