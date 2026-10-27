# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/ah/.docker/bin"
# End of Docker Desktop section.

status is-interactive; and begin
    set fish_greeting
    /opt/homebrew/bin/brew shellenv fish | source
    ~/.local/bin/mise activate fish | source
    starship init fish | source
    zoxide init fish | source
end
