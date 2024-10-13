alias py=python
alias ll='ls -l'
alias gvim=mvim
alias dockerclean="docker system prune -a"
alias oldbrew=/usr/local/bin/brew
#alias vcleanup () {#
#	sudo launchctl unload -w "/Library/LaunchDaemons/net.pulsesecure.AccessService.plist" && sudo launchctl load -w "/Library/LaunchDaemons/net.pulsesecure.AccessService.plist"
#}

# Set prompt
# TODO: rethink for zsh
# export PS1="[\u@\h:\[\e[1;34m\]\w\[\e[m\]]\$ "

# In ITerm sessions, push the cwd to the window title
if [ $ITERM_SESSION_ID ]; then
precmd() {
  echo -ne "\033]0;zsh - ${PWD##*/}\007"
}
preexec() {
  echo -ne "\033]0;$1\007"
}
fi

# Use history completion search for up and down arrow
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Allow setting window title in iTerm
function title {
    echo -ne "\033]0;"$*"\007"
}

export EDITOR=vim

# Designate a python startup file
export PYTHONSTARTUP=$HOME/.pystartup

# Add the bash git completions
zstyle ':completion:*:*:git:*' script ~/.git-completion.bash

# Add local function autoloading
fpath=(~/.zsh $fpath)

#alias browse='open /System/Library/CoreServices/Finder.app ./'
alias browse='[[ "$#" -eq 2 ]] && a="$2" || a="./";open /System/Library/CoreServices/Finder.app "$a"'

PATH="${HOME}/bin:${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# shortcut json formatting
alias jlint="pbpaste|jq .|pbcopy"
alias prettypy='python3 -c "import json;import sys;print(json.dumps(eval(sys.stdin.read()), indent=2))"'

# add virtualenv helpers
#source envman.sh
#VIRTUALENVWRAPPER_PYTHON=python3
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='-p python3'
#export WORKON_HOME=~/envs
#export PROJECT_HOME=~/Projects
#source `which virtualenvwrapper.sh`

#alias mkenv=mkvirtualenv
#alias rmenv=rmvirtualenv

if [ -f "${HOME}/.sitebashrc" ]
then
    source "${HOME}/.sitebashrc"
fi

# Created by `userpath` on 2019-09-03 23:55:01
export PATH="$PATH:/Users/ereinecke/.local/bin"

export PYENV_ROOT=$HOME/.pyenv
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

