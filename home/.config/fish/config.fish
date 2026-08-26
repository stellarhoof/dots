status is-interactive; and begin
    set fish_greeting # Disable the fish greeting
    ~/.local/bin/mise activate fish | source
    starship init fish | source
    zoxide init fish | source
    switch (uname)
        case Darwin
            /opt/homebrew/bin/brew shellenv fish | source
    end
end
