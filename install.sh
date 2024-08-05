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

if [ ! $(command -v stow) ]; then
    echo "$SCRIPT_NAME - [ERROR] stow is not installed in your system"
    exit 1
fi

# Install Oh My Posh on the system
mkdir -p ~/.local/bin ~/.local/lib
if [ ! $(command -v oh-my-posh) ]; then
    echo "$SCRIPT_NAME - Installing oh-my-posh"
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi

FONT_LOCATION=~/.local/share/fonts
# Install a nerd font
if [ ! -d $FONT_LOCATION/Agave ]; then
    mkdir -p $FONT_LOCATION/Agave
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Agave.zip" -P $FONT_LOCATION/Agave
    unzip $FONT_LOCATION/Agave/Agave.zip -d $FONT_LOCATION/Agave
    fc-cache
    rm $FONT_LOCATION/Agave/Agave.zip
fi

# Create symbolic links with files in the dotfiles directory (NB: Replaces existing files)
echo -e "$SCRIPT_NAME - ${CL_WARN}[INFO] Symlinking config files"

for d in 'ls -d */';
do
    ( stow $d )
done

echo -e "$SCRIPT_NAME - [INFO] Remember to set Agave Nerd Font Mono to the terminal"
