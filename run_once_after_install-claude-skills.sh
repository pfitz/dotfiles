#!/bin/sh
# Bootstrap the personal Claude Code skills on a new machine.
# The `personal` plugin (~/documents/projects/claude-plugin) expects its skills
# in a `skills/` subdir, but those live in a separate repo (claude-skills).
# This clones that repo and symlinks it in so the plugin loads all skills.
# Safe to re-run; idempotent.

set -eu

SKILLS_REPO="git@github.com:pfitz/claude-skills.git"
PROJECTS_DIR="$HOME/documents/projects"
SKILLS_DIR="$PROJECTS_DIR/claude-skills"
PLUGIN_DIR="$PROJECTS_DIR/claude-plugin"
LINK="$PLUGIN_DIR/skills"

# 1. Clone the skills repo if it isn't there. Prefer jj (colocated with git),
#    fall back to plain git if jj isn't installed yet.
if [ ! -d "$SKILLS_DIR/.git" ] && [ ! -d "$SKILLS_DIR/.jj" ]; then
	mkdir -p "$PROJECTS_DIR"
	if command -v jj >/dev/null 2>&1; then
		echo "Cloning claude-skills with jj into $SKILLS_DIR ..."
		(cd "$PROJECTS_DIR" && jj git clone "$SKILLS_REPO" claude-skills)
	else
		echo "jj not found; cloning claude-skills with git into $SKILLS_DIR ..."
		git clone "$SKILLS_REPO" "$SKILLS_DIR"
	fi
else
	echo "claude-skills already present; skipping clone."
fi

# 2. Symlink the skills repo into the plugin as its skills/ dir.
#    Only if the plugin repo exists (it may not be cloned yet on this machine).
if [ -d "$PLUGIN_DIR" ]; then
	if [ -L "$LINK" ] || [ ! -e "$LINK" ]; then
		ln -sfn "$SKILLS_DIR" "$LINK"
		echo "Linked $LINK -> $SKILLS_DIR"
	else
		echo "WARNING: $LINK exists and is not a symlink; leaving it alone." >&2
	fi
else
	echo "Plugin dir $PLUGIN_DIR not found; skipping skills symlink." >&2
fi

echo "Claude skills ready. Restart Claude Code to load them as personal:*."
