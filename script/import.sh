# shellcheck shell=bash

case "$(uname)" in
    Darwin*)
        # Homebrew
        intel_brew_path='/usr/local/bin/brew'
        m1_brew_path='/opt/homebrew/bin/brew'
        # Export Homebrew variables for current platform
        if [[ -x "$intel_brew_path" ]]; then
            eval "$($intel_brew_path shellenv)"
        elif [[ -x "$m1_brew_path" ]]; then
            eval "$($m1_brew_path shellenv)"
        fi

        # Homebrew Python
        homebrew_python_path='/usr/local/opt/python/libexec/bin'
        export PATH="$homebrew_python_path:$PATH"
        ;;
    Linux*)
        brew_path="$HOME/linuxbrew/.linuxbrew/bin/brew"
        if [[ -x "$brew_path" ]]; then
            brew_env="$($brew_path shellenv)"
            eval "$brew_env"
            # test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
            # test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            # test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.bash_profile
            # echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.profile
        fi
        ;;
    CYGWIN*)
        exit_failure 'Windows is not currently supported'
        ;;
esac

# Pipenv
local_python_bin="$HOME/.local/bin"
export PATH="$local_python_bin:$PATH"
if command -v python; then
    user_python_bin="$(python -m site --user-base)/bin"
    export PATH="$user_python_bin:$PATH"
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)" || true; fi
