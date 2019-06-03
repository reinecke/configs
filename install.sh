#!/bin/bash

# TODO: replace with detection logic
echo "Before running, please install the following:"
echo "  Python 3"
echo "  Xcode"

read -p "Ready to install? (y/N): " ready
if [ $ready != "y" ]
then
    echo "please install requirements and run again"
fi

pushd ~

# -- Terminal
defaults write com.apple.Terminal FocusFollowsMouse -string YES
defaults write com.apple.Terminal "Startup Window Settings" -string Homebrew
defaults write com.apple.Terminal "Default Window Settings" -string Homebrew
ln -s Projects/configs/.bashrc .bashrc
ln -s Projects/configs/.bash_profile .bash_profile

# -- git
ln -s Projects/configs/.gitignore_global .gitignore_global
git config --global user.name "Eric Reinecke"
git config --global user.email reinecke.eric@gmail.com
git config --global core.excludesfile ~/.gitignore_global
git config --global alias.co checkout
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash

# -- Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# -- vim
brew install macvim
ln -s Projects/configs/.vimrc .vimrc
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

# vundle, colors
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl https://raw.githubusercontent.com/reinecke/vim-cgpro/master/colors/cgpro.vim > ~/.vim/colors/cgpro.vim

# -- vscode
mkdir -p "${HOME}/Library/Application Support/Code"
pushd "${HOME}/Library/Application Support/Code"
ln -s "${HOME}/Projects/configs/Code" User
popd

# -- python
brew install readline
ln -s Projects/configs/.inputrc .inputrc
ln -s Projects/configs/.pystartup .pystartup
pip3 install virtualenvwrapper

# -- mac dev
brew install carthage

# -- assorted dev
brew install jq httpie, grip

popd
