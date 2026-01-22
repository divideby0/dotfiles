# Claude Code Configuration

Evidence > assumptions | Code > documentation | Efficiency > verbosity

## Commits

Use conventional commits following the 50/72 rule:

- **Subject line**: Max 50 chars, imperative mood (`fix:`, `feat:`, `refactor:`, etc.)
- **Body**: Wrap at 72 chars, explain *why* not *what*
- **Surgical commits**: One logical change per commit, easy to review and revert

## Asking Questions

Choose the right pattern based on context:

| Situation | Approach |
|-----------|----------|
| Quick decision with clear options | `AskUserQuestion` tool |
| Complex input needing user edits | Markdown file with comment threads |

### Markdown Comment Pattern

For complex questions requiring detailed user input, create a markdown file with HTML comments:

```markdown
## Open Questions

### Database Choice

<!-- Agent: Options are: 1) PostgreSQL, 2) SQLite, 3) MongoDB.
     PostgreSQL recommended for relational data with JSONB support. -->
<!-- User: PostgreSQL, but we need read replicas for scale -->
```

**Location**:
- If Basic Memory available: `memory://scratch/` or `memory://specs/`
- Otherwise: `.scratch/questions.md`

## Scratch Folder

Use `${PROJECT_ROOT}/.scratch/` for temporary artifacts:

```
.scratch/
├── scripts/       # Exploratory scripts
├── notes/         # Working notes (if no Basic Memory)
└── data/          # Temporary data files
```

### Python Scripts

For single-file scripts, use PEP 723 inline dependencies:

```python
#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.12"
# dependencies = ["typer", "rich"]
# ///

import typer
from rich import print

app = typer.Typer()

@app.command()
def main():
    print("[green]Hello[/green]")

if __name__ == "__main__":
    app()
```

For multi-file scripts, create a subdirectory with `pyproject.toml`:

```
.scratch/scripts/my-tool/
├── pyproject.toml
├── my_tool/
│   ├── __init__.py
│   └── cli.py
└── README.md
```

## Claude Code Config Structure

**Do not confuse these**:

| Type | Location | Invocation | Purpose |
|------|----------|------------|---------|
| **Commands** | `.claude/commands/foo.md` | `/project:foo` or `/foo` | User-invoked workflows with `$ARGUMENTS` |
| **Skills** | `.claude/skills/foo/SKILL.md` | Auto-activated by frontmatter conditions | Reference docs and workflows |
| **Hooks** | `.claude/hooks.json` or `~/.claude/hooks/` | Triggered by events (PreToolUse, Stop, etc.) | Automation scripts |
| **Settings** | `.claude/settings.json` | N/A | Permissions, MCP servers |

### Commands

Slash commands the user explicitly invokes:

```markdown
<!-- .claude/commands/review.md -->
Review the code at $ARGUMENTS for:
- Security issues
- Performance problems
```

### Skills

Auto-activated documentation with frontmatter triggers:

```markdown
<!-- .claude/skills/testing/SKILL.md -->
---
name: Testing Patterns
description: |
  Activate when:
  - Writing or modifying tests
  - User asks about testing strategy
---

# Testing Patterns
...
```

## Markdown Formatting

Always run Prettier on markdown files after saving:

```bash
npx prettier --write "path/to/file.md"
```

Basic Memory can auto-format via config:

```json
{
  "format_on_save": true,
  "formatter_command": "npx prettier --write {file}"
}
```
