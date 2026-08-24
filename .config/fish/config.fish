# Only execute this file once per shell.
set -q __config_sourced; and exit
set -g __config_sourced 1

function setup_session_vars
    # Only source this once.
    if [ -n (set -q __SESSION_VARS_SOURCED && echo "$__SESSION_VARS_SOURCED" || echo '') ]
        return
    end
    set -gx __SESSION_VARS_SOURCED 1

    set -gx XDG_BIN_HOME "$HOME/.local/bin"
    set -gx XDG_CACHE_HOME "$HOME/.cache"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
    set -gx XDG_DATA_HOME "$HOME/.local/share"
    set -gx XDG_STATE_HOME "$HOME/.local/state"
    set -gx XDG_PROJECTS_HOME "$HOME/Projects"

    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx PAGER 'less -R'
    set -gx MANPAGER 'less -s -M'

    set -gx PATH "$XDG_BIN_HOME:$PATH"

    # node
    set -gx NPM_CONFIG_PREFIX "$XDG_DATA_HOME/npm"
    set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
    set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npmrc.local"
    set -gx NPM_CONFIG_GLOBALCONFIG "$XDG_CONFIG_HOME/npmrc.global"
    set -gx NODE_REPL_HISTORY "$XDG_CACHE_HOME/node_repl_history"
    set -gx NODE_REPL_MODE strict
    set -gx PATH "$NPM_PACKAGES/bin:$PATH"

    # rust
    set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
    set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
    set -gx PATH "$CARGO_HOME/bin:$PATH"

    # docker
    set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
    set -gx MACHINE_STORAGE_PATH "$XDG_DATA_HOME/docker-machine"
    set -gx PATH "$HOME/.docker/bin:$PATH"

    # go
    set -gx GOPATH "$XDG_DATA_HOME"

    # ruby
    set -gx GEM_HOME "$XDG_DATA_HOME/gem"
    set -gx GEM_SPEC_CACHE "$XDG_CACHE_HOME/gem"

    # gpg
    set -gx GNUPGHOME "$XDG_STATE_HOME/gnupg"

    # python
    set -gx IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
    set -gx PIP_LOG "$XDG_CACHE_HOME/pip/pip.log"
    set -gx PYLINTHOME "$XDG_CACHE_HOME/pylint"
    set -gx PYTHONSTARTUP "$XDG_DATA_HOME/python/startup.py"
    set -gx PYTHON_EGG_CACHE "$XDG_CACHE_HOME/python-eggs"
    set -gx PYTHON_HISTFILE "$XDG_CACHE_HOME/python_history"

    # password store
    set -gx PASSWORD_STORE_DIR "$XDG_PROJECTS_HOME/github.com/stellarhoof/pass"

    # other
    set -gx EXA_ICON_SPACING 2
    set -gx GROFF_NO_SGR 1
    set -gx ICEAUTHORITY "$XDG_CACHE_HOME/ICEauthority"
    set -gx INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
    set -gx LESSHISTFILE "$XDG_CACHE_HOME/less/history"
    set -gx LESSKEY "$XDG_CONFIG_HOME/less/key"
    set -gx MYSQL_HISTFILE "$XDG_CACHE_HOME/mysql_history"
    set -gx PSQL_HISTORY "$XDG_CACHE_HOME/postgres_history"
    set -gx REDISCLI_HISTFILE "$XDG_DATA_HOME/redis/rediscli_history"
    set -gx REDISCLI_RCFILE "$XDG_CONFIG_HOME/redis/redisclirc"
    set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/ripgreprc"
    set -gx SQLITE_HISTORY "$XDG_CACHE_HOME/sqlite_history"
end

setup_session_vars

# Login shell initialisation
status is-login; and begin
    switch (uname)
        case Darwin
            fish_add_path -pP /opt/homebrew/bin
            # Fish login shells emulate the behavior of `/usr/libexec/path_helper` in
            # MacOS, which is to prepend everything in `/etc/paths` to `$PATH`, which
            # hides NIX paths. This moves those paths to the end.
            fish_add_path -maP /usr/local/bin /usr/bin /bin /usr/sbin /sbin
    end
end

# Interactive shell initialisation
status is-interactive; and begin
    # Disable the fish greeting
    set fish_greeting

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
    alias rm 'echo '\''Use `trash-put` instead!'\''
 false'
    alias te trash-empty
    alias tl trash-list
    alias top htop
    alias tp trash-put
    alias tr trash-rm
    alias y yarn

    zoxide init fish | source

    starship init fish | source
    set -gx STARSHIP_CONFIG '$XDG_CONFIG_HOME/starship.toml'

    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs'
    set -gx FZF_DEFAULT_OPTS '--cycle --filepath-word --inline-info --reverse --pointer=\'*\' --preview=\'head -100 {}\' --preview-window=right:hidden --bind=ctrl-space:toggle-preview'

    set -gx GPG_TTY (tty)
end
