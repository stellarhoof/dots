# https://rabexc.org/posts/pitfalls-of-ssh-agents
# TODO: Run the ssh agent via runit's user services
function start-ssh-agent
    if test -z (pgrep ssh-agent)
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    end
end

status is-interactive; and begin
    set fish_greeting
    mise activate fish | source
    starship init fish | source
    zoxide init fish | source
end
