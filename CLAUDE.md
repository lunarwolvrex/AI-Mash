@AGENTS.md

## Claude Code specifics
- Installed as a plugin, the skills are namespaced (`/universal-modder:mod-any-game`), the fal MCP server comes
  from `.mcp.json` (needs `FAL_KEY` in the environment), and a SessionStart hook puts `um` on PATH.
- In a clone, `.claude/settings.json` adds the same PATH hook, and `.claude/skills` is a copy of `skills/`.
- `agents/` holds a three-agent team for long mods: `mod-orchestrator` (run it as the main session with
  `claude --agent mod-orchestrator`), which spawns `mod-game-worker` and `mod-offline-worker`.
