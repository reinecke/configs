#!/bin/bash

# TODO: replace with detection logic
echo "Before running, please install the following:"
echo "  Python 3"
echo "  Xcode"

read -p "Ready to install? (y/N): " ready
if [ $ready != "y" ]
then
    echo "please install requirements and run again"
    exit 1
fi

pushd ~

# -- Terminal
defaults write com.apple.Terminal FocusFollowsMouse -string YES
defaults write com.apple.Terminal "Startup Window Settings" -string Homebrew
defaults write com.apple.Terminal "Default Window Settings" -string Homebrew
ln -s Projects/configs/.bashrc .bashrc
ln -s Projects/configs/.bash_profile .bash_profile
ln -s Projects/configs/.zshrc .zshrc
mkdir -p .zsh

# -- git
ln -s Projects/configs/.gitignore_global .gitignore_global

# Keep ~/.gitconfig writable for tools that manage it, and load shared
# settings before machine-specific settings so the latter can override them.
for config_file in "$HOME/Projects/configs/.gitconfig" "$HOME/.gitconfig.local"; do
    if ! git config --global --get-all include.path | grep -Fxq "$config_file"; then
        printf '\n[include]\n\tpath = %s\n' "$config_file" >> "$HOME/.gitconfig"
    fi
done

if [[ -z "$(git config --global --includes --get user.email)" ]]; then
    read -r -p "Git user email (leave blank to skip): " git_user_email
    if [[ -n "$git_user_email" ]]; then
        git config --file "$HOME/.gitconfig.local" user.email "$git_user_email"
    fi
fi

install_git_completion() {
    local url="$1" target="$2" temporary_file
    temporary_file=$(mktemp "${target}.XXXXXX") || return 1
    if ! curl -fsSL "$url" -o "$temporary_file" || ! mv "$temporary_file" "$target"; then
        rm -f "$temporary_file"
        return 1
    fi
}

install_git_completion \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
    "$HOME/.git-completion.bash" || exit 1
install_git_completion \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh \
    "$HOME/.zsh/_git" || exit 1

# -- Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# -- vim
brew install macvim
ln -s Projects/configs/.vimrc .vimrc
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

# Bootstrap vundle and install plugins, colors
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
curl https://raw.githubusercontent.com/reinecke/vim-cgpro/main/colors/cgpro.vim > ~/.vim/colors/cgpro.vim

# -- python
brew install readline
ln -s Projects/configs/.inputrc .inputrc
ln -s Projects/configs/.pystartup .pystartup

# -- mac dev
#brew install carthage

# -- assorted dev
brew install jq httpie grip

# -- iTerm
curl -L https://iterm2.com/shell_integration/bash -o "${HOME}/.iterm2_shell_integration.bash"
# TODO: Figure out how to setup custom dir

popd
