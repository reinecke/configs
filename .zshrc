alias py=python
alias ll='ls -l'
alias gvim=mvim
alias dockerclean="docker system prune -a"
alias uuid4="uuidgen| tr '[:upper:]' '[:lower:]'"

# Show the directory and useful context above a clear command line.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b%c%u'
# + means staged changes; * means unstaged changes.
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'
setopt PROMPT_SUBST
export VIRTUAL_ENV_DISABLE_PROMPT=1

typeset -gi prompt_command_started_at=-1
typeset -g prompt_python_env_path='' prompt_python_label=''
PROMPT=$'%F{#30b6b6}%{\e[3m%}%~%{\e[23m%}%f${prompt_git}${prompt_python}${prompt_duration}
${prompt_status}%B❯%b '

precmd() {
  local last_status=$?
  local elapsed_seconds
  local python_env=${VIRTUAL_ENV:-$PYENV_VIRTUAL_ENV}
  local env_name python_version

  vcs_info
  prompt_git=${vcs_info_msg_0_:+ %F{yellow}${vcs_info_msg_0_}%f}
  if [[ $python_env != $prompt_python_env_path ]]; then
    prompt_python_env_path=$python_env
    prompt_python_label=''
    if [[ -n $python_env ]]; then
      env_name=${python_env:t}
      if [[ $env_name == venv || $env_name == .venv ]]; then
        env_name=${python_env:h:t}
      fi
      python_version=$("$python_env/bin/python" --version 2>/dev/null)
      if [[ $python_version =~ '^Python ([0-9]+\.[0-9]+)' ]]; then
        prompt_python_label="${env_name}:${match[1]}"
      else
        prompt_python_label=$env_name
      fi
    fi
  fi
  prompt_python=${prompt_python_label:+ %F{#c94242}${prompt_python_label}%f}
  prompt_status=''
  (( last_status != 0 )) && prompt_status="%F{9}✗ (${last_status})%f "

  prompt_duration=''
  if (( prompt_command_started_at >= 0 )); then
    elapsed_seconds=$(( SECONDS - prompt_command_started_at ))
    (( elapsed_seconds >= 5 )) && prompt_duration=" %F{cyan}${elapsed_seconds}s%f"
    prompt_command_started_at=-1
  fi

  # In iTerm sessions, push the cwd to the window title.
  if [[ -n "$ITERM_SESSION_ID" ]]; then
    echo -ne "\033]0;zsh - ${PWD##*/}\007"
  fi
}

preexec() {
  prompt_command_started_at=$SECONDS
  if [[ -n "$ITERM_SESSION_ID" ]]; then
    echo -ne "\033]0;$1\007"
  fi
}

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

# Load local completion functions, including Git's _git wrapper, before compinit.
fpath=("$HOME/.zsh" $fpath)
zstyle ':completion:*:*:git:*' script "$HOME/.git-completion.bash"
autoload -Uz compinit
compinit

#alias browse='open /System/Library/CoreServices/Finder.app ./'
alias browse='[[ "$#" -eq 2 ]] && a="$2" || a="./";open /System/Library/CoreServices/Finder.app "$a"'

export PATH="${HOME}/bin:${PATH}"

if [[ "$OSTYPE" == darwin* ]]; then
    # Prefer Homebrew's ffmpeg-full when it is installed.
    if [[ -d /opt/homebrew/opt/ffmpeg-full/bin ]]; then
        export PATH="/opt/homebrew/opt/ffmpeg-full/bin:$PATH"
    fi

    export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
    if ! command -v pyenv >/dev/null 2>&1 && [[ -x "$PYENV_ROOT/bin/pyenv" ]]; then
        export PATH="$PYENV_ROOT/bin:$PATH"
    fi
    if command -v pyenv >/dev/null 2>&1; then
        eval "$(pyenv init - zsh)"
    fi
fi

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

# Machine-specific aliases, paths, and tool initialization live outside this repo.
if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi
