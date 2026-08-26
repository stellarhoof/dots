status is-interactive; and begin
    set fish_greeting # Disable the fish greeting
    switch (uname)
        case Darwin
            ~/.local/bin/mise activate fish | source
            /opt/homebrew/bin/brew shellenv fish | source
    end
    starship init fish | source
    zoxide init fish | source
end
