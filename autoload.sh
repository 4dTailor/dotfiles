# Create symbolic links with files in the dotfiles directory (NB: Replaces existing files)
# ln -sf $PWD/.bashrc ~/.bashrc
ln -sf $PWD/.gitconfig ~/.gitconfig

print("Successfully set symbolic links to files")
