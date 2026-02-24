# jj Configuration

## Tools

### Delta (Diff Pager)
- **Theme:** Catppuccin Mocha
- **View:** Side-by-side with line numbers
- Used for `jj diff` and `jj show` commands

Requires the Catppuccin bat theme:
```bash
mkdir -p "$(bat --config-dir)/themes"
curl -sL https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme \
  -o "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme"
bat cache --build
```

### Kaleidoscope (ksdiff)
- **Diff editor:** Used for `jj split`, `jj squash -i`
- **Merge editor:** Used for `jj resolve`

The `--no-snapshot` flag makes files editable for jj's edit-a-diff workflow.

Note: When using `jj split`, Option-double-click (not regular double-click) to edit diffs.

### Mergiraf
Syntax-aware merge tool for automatic conflict resolution. Supports: Elixir, Go, Rust, and many more.

jj has mergiraf configured by default. Use with:
```bash
jj autoresolve              # alias for jj resolve --tool mergiraf
jj resolve --tool mergiraf  # explicit
```

## Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `tug` | `bookmark move --from "heads(::@- & bookmarks())" --to @-` | Move bookmark to parent |
| `autoresolve` | `resolve --tool mergiraf` | Auto-resolve conflicts with mergiraf |

## Fish Shell Alias

Add to `~/.config/fish/config.fish`:
```fish
alias jjfix "jj resolve --tool mergiraf; jj resolve"
```

This runs mergiraf first for automatic resolution, then opens Kaleidoscope for remaining conflicts.

## Revset Aliases

| Alias | Description |
|-------|-------------|
| `user(x)` | Commits authored or committed by x |
| `mine()` | Your commits (configure emails in alias) |
| `stack()` | Mutable commits reachable from current change |
| `stack(x)` | Mutable commits reachable from x |
| `stack(x, n)` | Same with n parents depth |
| `closest_pushable(to)` | Heads ready to push (non-empty, has description) |

## References

- [Catppuccin Delta](https://github.com/catppuccin/delta)
- [Mergiraf Usage](https://mergiraf.org/usage.html)
- [ksdiff Command Line Tool](https://kaleidoscope.app/help/docs/command-line-tool)
- [jj Configuration Docs](https://jj-vcs.github.io/jj/latest/config/)
