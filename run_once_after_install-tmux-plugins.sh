#!/bin/sh
# Bootstrap tmux plugins on a new machine.
# Clones TPM (tmux plugin manager) if missing, then installs all plugins
# declared in ~/.config/tmux/tmux.conf. Safe to re-run; idempotent.

set -eu

# Nothing to do if tmux isn't installed yet.
command -v tmux >/dev/null 2>&1 || {
	echo "tmux not installed; skipping plugin bootstrap." >&2
	exit 0
}

PLUGINS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins"
TPM_DIR="$PLUGINS_DIR/tpm"

# 1. Clone TPM if it isn't there.
if [ ! -d "$TPM_DIR" ]; then
	echo "Cloning TPM into $TPM_DIR ..."
	git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# 2. Install the plugins headlessly.
#    TPM reads TMUX_PLUGIN_MANAGER_PATH from the tmux *server* environment, so we
#    seed it into a throwaway detached session (which keeps the server alive long
#    enough for the query to succeed), then run install_plugins as a normal
#    subprocess so tmux stays on PATH.
echo "Installing tmux plugins ..."
tmux new-session -d -s __tpm_bootstrap 2>/dev/null || true
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$PLUGINS_DIR/"
"$TPM_DIR/bin/install_plugins"
tmux kill-session -t __tpm_bootstrap 2>/dev/null || true

echo "tmux plugins ready."
