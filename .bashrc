alias py=python
alias ll='ls -l'
alias gvim=mvim
alias dockerclean="docker system prune -a"
alias weather="curl wttr.in/oakland"

# Set prompt
export PS1="[\u@\h:\[\e[1;34m\]\w\[\e[m\]]\$ "

# Allow setting window title in iTerm
function title {
    echo -ne "\033]0;"$*"\007"
}

export EDITOR=vim

# Designate a python startup file
export PYTHONSTARTUP=$HOME/.pystartup

# git completions!
source ~/.git-completion.bash
#source ~/Projects/third-party/git/contrib/completion/git-prompt.sh

#alias browse='open /System/Library/CoreServices/Finder.app ./'
alias browse='[[ "$#" -eq 2 ]] && a="$2" || a="./";open /System/Library/CoreServices/Finder.app "$a"'

export PATH="${HOME}/bin:${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

# add virtualenv helpers
#source envman.sh
VIRTUALENVWRAPPER_PYTHON=python3
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='-p python3.7'
export WORKON_HOME=~/envs
export PROJECT_HOME=~/Projects
source `which virtualenvwrapper.sh`

alias mkenv=mkvirtualenv
alias rmenv=rmvirtualenv

if [ -f "${HOME}/.sitebashrc" ]
then
    source "${HOME}/.sitebashrc"
fi
