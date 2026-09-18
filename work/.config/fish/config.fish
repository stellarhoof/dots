status is-interactive; and begin
    set fish_greeting
    /opt/homebrew/bin/brew shellenv fish | source
    ~/.local/bin/mise activate fish | source
    starship init fish | source
    zoxide init fish | source
end
