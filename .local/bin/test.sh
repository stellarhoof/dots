#!/bin/bash

mise 2>~/mise_output

# export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"
# mise env --json \
#   | jq -r 'to_entries[] | [.key, (.value // "")] | @tsv' \
#   | while IFS=$'\t' read -r k v; do
#       launchctl setenv "$k" "$v"
#     done
