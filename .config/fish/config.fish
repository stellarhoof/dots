# xdg variables
set -gx XDG_BIN_HOME "$HOME/.local/bin"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_PROJECTS_HOME "$HOME/Projects"

# defaults
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER 'less -R'
set -gx MANPAGER 'less -s -M'

# home declutter
set -gx ICEAUTHORITY "$XDG_CACHE_HOME/ICEauthority"
set -gx INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"
set -gx MYSQL_HISTFILE "$XDG_STATE_HOME/mysql_history"
set -gx REDISCLI_HISTFILE "$XDG_STATE_HOME/redis/rediscli_history"
set -gx REDISCLI_RCFILE "$XDG_CONFIG_HOME/redis/redisclirc"
set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/ripgreprc"
set -gx SQLITE_HISTORY "$XDG_STATE_HOME/sqlite_history"

# other
set -gx GROFF_NO_SGR 1
set -gx EXA_ICON_SPACING 2
set -gx PASSWORD_STORE_DIR "$XDG_PROJECTS_HOME/github.com/stellarhoof/pass"

status is-login; and begin
    switch (uname)
        case Darwin
            /opt/homebrew/bin/brew shellenv fish | source
    end
end

status is-interactive; and begin
    set fish_greeting # Disable the fish greeting

    ~/.local/bin/mise activate fish | source

    starship init fish | source

    zoxide init fish | source

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
    # alias rm 'echo '\''Use `trash-put` instead!'\'' false'
    alias te trash-empty
    alias tl trash-list
    alias top htop
    alias tp trash-put
    alias tr trash-rm
    alias vi nvim
end
