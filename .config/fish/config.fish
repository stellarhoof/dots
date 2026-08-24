# xdg variables
set -g XDG_BIN_HOME "$HOME/.local/bin"
set -g XDG_CACHE_HOME "$HOME/.cache"
set -g XDG_CONFIG_HOME "$HOME/.config"
set -g XDG_DATA_HOME "$HOME/.local/share"
set -g XDG_STATE_HOME "$HOME/.local/state"
set -g XDG_PROJECTS_HOME "$HOME/Projects"

# defaults
set -g EDITOR nvim
set -g VISUAL nvim
set -g PAGER 'less -R'
set -g MANPAGER 'less -s -M'

# node
set -g NPM_CONFIG_PREFIX "$XDG_DATA_HOME/npm"
set -g NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -g NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npmrc.local"
set -g NPM_CONFIG_GLOBALCONFIG "$XDG_CONFIG_HOME/npmrc.global"
set -g NODE_REPL_HISTORY "$XDG_CACHE_HOME/node_repl_history"
set -g NODE_REPL_MODE strict

# rust
set -g CARGO_HOME "$XDG_DATA_HOME/cargo"
set -g RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# docker
set -g DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -g MACHINE_STORAGE_PATH "$XDG_DATA_HOME/docker-machine"

# go
set -g GOPATH "$XDG_DATA_HOME"

# ruby
set -g GEM_HOME "$XDG_DATA_HOME/gem"
set -g GEM_SPEC_CACHE "$XDG_CACHE_HOME/gem"

# gpg
set -g GNUPGHOME "$XDG_STATE_HOME/gnupg"

# python
set -g IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -g PIP_LOG "$XDG_CACHE_HOME/pip/pip.log"
set -g PYLINTHOME "$XDG_CACHE_HOME/pylint"
set -g PYTHONSTARTUP "$XDG_DATA_HOME/python/startup.py"
set -g PYTHON_EGG_CACHE "$XDG_CACHE_HOME/python-eggs"
set -g PYTHON_HISTFILE "$XDG_CACHE_HOME/python_history"

# password store
set -g PASSWORD_STORE_DIR "$XDG_PROJECTS_HOME/github.com/stellarhoof/pass"

# other
set -g EXA_ICON_SPACING 2
set -g GROFF_NO_SGR 1
set -g ICEAUTHORITY "$XDG_CACHE_HOME/ICEauthority"
set -g INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
set -g LESSHISTFILE "$XDG_CACHE_HOME/less/history"
set -g LESSKEY "$XDG_CONFIG_HOME/less/key"
set -g MYSQL_HISTFILE "$XDG_CACHE_HOME/mysql_history"
set -g PSQL_HISTORY "$XDG_CACHE_HOME/postgres_history"
set -g REDISCLI_HISTFILE "$XDG_DATA_HOME/redis/rediscli_history"
set -g REDISCLI_RCFILE "$XDG_CONFIG_HOME/redis/redisclirc"
set -g RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/ripgreprc"
set -g SQLITE_HISTORY "$XDG_CACHE_HOME/sqlite_history"
set -g FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs'
set -g FZF_DEFAULT_OPTS '--cycle --filepath-word --inline-info --reverse --pointer=\'*\' --preview=\'head -100 {}\' --preview-window=right:hidden --bind=ctrl-space:toggle-preview'

status is-login; and begin
    fish_add_path "$XDG_BIN_HOME" "$NPM_CONFIG_PREFIX/bin" "$CARGO_HOME/bin" "$HOME/.docker/bin"
    switch (uname)
        case Darwin
            fish_add_path /opt/homebrew/bin
    end
end

status is-interactive; and begin
    set fish_greeting # Disable the fish greeting

    mise activate fish | source

    starship init fish | source

    zoxide init fish | source

    # set -gx GPG_TTY (tty)

    alias claude 'SHELL=/bin/bash command claude'
    alias cp 'cp -i'
    alias df duf
    alias diff 'diff --color=auto'
    alias du dua
    alias eza 'eza --icons --group-directories-first'
    alias g git
    alias l 'eza -la'
    alias la 'eza -a'
    alias less 'less -R'
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls eza
    alias lt 'eza --tree'
    alias p pnpm
    alias rm 'echo '\''Use `trash-put` instead!'\'' false'
    alias te trash-empty
    alias tl trash-list
    alias top htop
    alias tp trash-put
    alias tr trash-rm
    alias vi nvim
    alias y yarn
end
