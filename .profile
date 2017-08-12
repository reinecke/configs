alias py=python
alias ll='ls -l'
alias gvim=mvim
alias vim=/Applications/MacVim.app/Contents/MacOS/Vim

# Set prompt
export PS1="[\u@\h:\[\e[1;34m\]\w\[\e[m\]]\$ "

export EDITOR=vim

# Designate a python startup file
export PYTHONSTARTUP=$HOME/.pystartup

# git completions!
source ~/Projects/third-party/git/contrib/completion/git-completion.bash
source ~/Projects/third-party/git/contrib/completion/git-prompt.sh

#alias browse='open /System/Library/CoreServices/Finder.app ./'
alias browse='[[ "$#" -eq 2 ]] && a="$2" || a="./";open /System/Library/CoreServices/Finder.app "$a"'

# AWS
export AWS_PROFILE=dev
export AWS_REGION=us-east-1

export PATH="${HOME}/bin:${HOME}/Projects/pixtoolkit/bin:${PATH}"

# add virtualenv helpers
#source envman.sh
export WORKON_HOME=~/envs
export PROJECT_HOME=~/Projects
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='-p python3.6'
source /usr/local/bin/virtualenvwrapper.sh

alias mkenv=mkvirtualenv
alias rmenv=rmvirtualenv
