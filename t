#!/bin/bash

export RESTORE=1

tmux start
start_ret="$?"

[[ $start_ret -ne 0 ]] && exit $start_ret

if [[ -n "$1" ]]; then
	tmux attach -t "$1"
fi
