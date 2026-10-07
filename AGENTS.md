# Repository Guidelines

## Project Structure & Module Organization

This repository holds personal macOS configuration, not an application. Root-level dotfiles configure Bash, Zsh, Vim, Readline, Git, and Python startup behavior. `iterm/com.googlecode.iterm2.plist` contains iTerm preferences. `install.sh` links selected files into the home directory and installs supporting tools. There are no source modules, test directories, or build assets. VS Code's `Code/` directory is local and ignored by Git.

## Build, Test, and Development Commands

There is no build step or automated test suite. Check the files you change before committing:

```sh
bash -n install.sh .bashrc .bash_profile
zsh -n .zshrc
plutil -lint iterm/com.googlecode.iterm2.plist
git diff --check
```

Run `./install.sh` only when intentionally setting up a macOS account. It changes system preferences, Git globals, home-directory links, and installed software; it also assumes the checkout is at `~/Projects/configs`.

## Coding Style & Naming Conventions

Keep configuration in its existing format and location. Use descriptive shell variable and function names, quote paths and expansions, and keep shell commands compatible with the interpreter named by each file. Follow nearby indentation instead of reformatting unrelated settings. Keep shared Zsh behavior in `.zshrc`; put computer-specific aliases, paths, and tool initialization in the untracked `~/.zshrc.local`, which `.zshrc` sources last.

## Testing Guidelines

There are no coverage targets or test naming conventions. Use the syntax checks above, then verify behavior in a fresh shell or application session for the configuration you touched. For installer changes, review every command and test on a disposable account or machine before relying on it for setup.

## Commit & Pull Request Guidelines

Recent commits use short descriptive summaries such as “Updated gitignore and installer script”; no commit prefix convention is established. Keep each commit focused. In a pull request, explain which configurations change, how you validated them, and any installation or migration impact. Include screenshots only for visible editor or terminal appearance changes. Keep machine-specific history, credentials, and private values out of commits.
