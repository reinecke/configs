
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc" # Load the default .bashrc

# load the iTerm integration if it exists
ITERM_SCRIPT_PATH="$HOME/.iterm2_shell_integration.bash"
if [ -f "$ITERM_SCRIPT_PATH" ]; then
    source "$ITERM_SCRIPT_PATH"
fi
