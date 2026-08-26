status is-interactive; and begin
    set fish_greeting
    ~/.local/bin/mise activate fish | source
    /opt/homebrew/bin/brew shellenv fish | source
    starship init fish | source
    zoxide init fish | source
end
