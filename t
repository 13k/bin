#!/bin/bash

function boot() {
	export TMUX_RESURRECT=1

	tmux start || return $?

	if [[ -n "$1" ]]; then
		tmux attach -t "$1" || return $?
	fi

	return 0
}

function shutdown() {
	tmux kill-server
}

case "$1" in
	-k|kill)
		shutdown || exit $?
		;;
	*)
		boot "$@" || exit $?
		;;
esac
