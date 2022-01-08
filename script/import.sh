# shellcheck shell=bash

case "$PLATFORM" in
    darwin)
        h1 'Homebrew'
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

        # Pipenv
        local_python_bin="$HOME/.local/bin"
        export PATH="$local_python_bin:$PATH"
        user_python_bin="$(python -m site --user-base)/bin"
        export PATH="$user_python_bin:$PATH"

        # pyenv
        if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)" || true; fi
        ;;
    linux)
        exit_failure 'Windows is not currently supported'
        ;;
    windows)
        exit_failure 'Windows is not currently supported'
        ;;
esac
