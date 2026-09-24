## Engineering Principles

1. Ask, don't assume. If something is unclear, ask before writing a single line. Never make silent assumptions about intent, architecture, or requirements. When running unattended, pick the most reasonable interpretation, proceed, and record the assumption rather than blocking.

2. Implement the simplest solution for simple problems, better solutions for harder problems. Do not over-engineer or add flexibility that isn't needed yet.

3. Don't touch unrelated code but please do surface bad code or design smells you discover with me so we can address them as a separate issue.

4. Flag uncertainty explicitly. If you're unsure about something, see point 1 above. If it makes sense to do so, conduct a small, localised and low-risk experiment and bring the hypothesis and results to me to discuss. Confidence without certainty causes more damage than admitting a gap.

5. I'm always open to ideas on better ways to do things. Please don't hesitate to suggest a better way, or one that has long lasting impact over a tactical change. (as a few examples)

## Terminal Multiplexing — Herdr

The terminal multiplexer here is **Herdr**, not tmux. Never reach for `tmux` to
create panes, windows, or background sessions — it is not in use.

Claude Code's own `teammateMode` is set to `in-process`, so spawned teammates run
inside this process rather than shelling out to a multiplexer. Herdr is driven
deliberately via its CLI, not automatically by Claude Code.

The `herdr` skill (installed at `~/.agents/skills/herdr`, symlinked into
`~/.claude/skills/`) carries the full control reference — CLI discovery, pane and
agent commands, ID conventions, lifecycle states. Invoke it whenever a task actually
involves driving Herdr; do not work from recollection.

Herdr also reports this session's identity to its socket via a `SessionStart` hook
(`~/.claude/hooks/herdr-agent-state.sh`), which is what lets it restore Claude panes
after a server restart. Leave that hook in place.

### Gate before controlling anything

Herdr control commands only make sense from inside a Herdr-managed pane:

```bash
test "${HERDR_ENV:-}" = 1
```

If that fails, say so and stop. Do not drive the user's focused session from outside Herdr.

## Codebase Exploration Strategy

When gathering information about a codebase, always prefer semantic tools over
text search. Use the following priority order:

### 1. LSP First (semantic/relational queries)

Use LSP tools for:

- Finding where a function/module is **defined** (`goto_definition`)
- Finding all **callers/references** of a symbol (`find_references`)
- Getting current **compiler errors and warnings** (`diagnostics`)
- **Renaming** symbols across the codebase

Do NOT use grep or file search for questions a LSP can answer precisely.
LSP returns one exact result instead of dozens of fuzzy matches to read through.

LSP servers currently configured (built-in LSP tool, `ENABLE_LSP_TOOL=1`):

- **Elixir** (`.ex`, `.exs`, `.heex`, `.leex`) → Dexter
- **TypeScript / JavaScript** (`.ts`, `.tsx`, `.js`, `.jsx`, `.mts`, `.cts`, `.mjs`, `.cjs`) → typescript-language-server
- **Terraform / OpenTofu** (`.tf`, `.tfvars`, `.tofu`) → terraform-ls
- **Rust** (`.rs`) → rust-analyzer (via `rust-analyzer-lsp@claude-plugins-official`)

### 2. ast-grep for structural/pattern queries

Use ast-grep when you need to find **code shapes**, not just symbol names:

- Finding all functions that pattern-match on `{:error, _}`
- Finding every module that `use`s a specific behaviour
- Finding all `with` blocks that have an `else` clause
- Finding all `GenServer.handle_call` implementations matching a pattern
- Auditing how a pattern is used across the whole codebase

### 3. File search / grep as last resort

Only fall back to plain grep/file search when:

- No LSP is available
- The query is about comments, strings, or non-code content
- You need to search across file names or directory structure

### Elixir-specific notes

- Prefer Dexter for all Elixir symbol navigation
- ast-grep with the Elixir grammar is well-suited for macro/pipe pattern searches
- Never infer module structure from filenames alone — use LSP to confirm

## Fast Judgments (Jev MCP)
Tool: `mcp__evaluate__evaluate` (TypeSafe Jev). Use it for narrow, enumerable judgments: binary checks, classification/routing, risk scoring.
- Pass raw evidence as state, never my own verdict.
- Confidence >0.85: proceed on reversible, local decisions only.
- Low confidence / uncertain: explain the ambiguity and ask.
- Destructive or outward-facing actions: always confirm with me, whatever the Jev score.

@RTK.md
