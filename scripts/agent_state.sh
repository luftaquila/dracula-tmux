#!/usr/bin/env sh
# Records a coding agent's turn state (Claude Code, Codex) on the tmux window
# it runs in, as the @agent window option shown by window-status-format.
# Called from the agents' hooks:
#
#   agent_state.sh running|waiting|done|clear
#
# The hook payload arrives as JSON on stdin; drain it so the agent never
# writes into a closed pipe.

cat >/dev/null 2>&1
[ -n "$TMUX_PANE" ] || exit 0

case "$1" in
  running|waiting)
    tmux set -w -t "$TMUX_PANE" @agent "$1" ;;
  done)
    # a finished turn the user is already looking at needs no marker
    tmux if -F -t "$TMUX_PANE" '#{&&:#{window_active},#{session_attached}}' \
      "set -wu -t $TMUX_PANE @agent" \
      "set -w -t $TMUX_PANE @agent done" ;;
  clear)
    tmux set -wu -t "$TMUX_PANE" @agent ;;
esac

exit 0
