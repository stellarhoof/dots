status is-interactive; and begin
    set fish_greeting
    switch (uname)
        case Linux
            mise activate fish | source
        case Darwin
            /opt/homebrew/bin/brew shellenv fish | source
            ~/.local/bin/mise activate fish | source
    end
    starship init fish | source
    zoxide init fish | source
end
