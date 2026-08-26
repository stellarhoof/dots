status is-interactive; and begin
    set fish_greeting
    mise activate fish | source
    starship init fish | source
    zoxide init fish | source
end
