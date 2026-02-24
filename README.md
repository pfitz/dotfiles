# dotfiles (chezmoi)

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap a new machine

Install chezmoi and apply all dotfiles in one command:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:pfitz/dotfiles.git --branch chezmoi
```

## Daily use

| Command | What it does |
|---------|-------------|
| `chezmoi add ~/.config/foo/bar` | Start tracking a new file |
| `chezmoi edit ~/.config/foo/bar` | Edit a managed file |
| `chezmoi diff` | Preview what chezmoi would change |
| `chezmoi apply` | Apply source state to home dir |
| `chezmoi update` | Pull latest from GitHub and apply |
| `chezmoi managed` | List all managed files |

## Secrets

API keys and secrets go in `~/.config/fish/conf.d/secrets.fish` — that file is gitignored and never committed.
