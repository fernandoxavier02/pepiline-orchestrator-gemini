# Pipeline Orchestrator — Extension Context

> This file is automatically loaded by Gemini CLI at session start.

## What This Extension Does

Pipeline Orchestrator is a multi-agent pipeline system that classifies, routes, and executes development tasks through specialized agents across 4 phases (Triage → Planning → Execution → Validation).

## How to Use

The primary entry point is the `/pipeline` command:

```
/pipeline <task description>
/pipeline --hotfix <urgent fix>
/pipeline --grill <deep design review>
/pipeline --review-only <audit task>
```

## Agent Activation

When the `/pipeline` command is invoked, the **task-orchestrator** agent must be activated first. It classifies the task and routes to the appropriate pipeline. Never skip the classification phase.

## Reference Files

All reference materials (checklists, gate definitions, pipeline specs) are bundled within this extension at `references/`. When loading references, use:

```
run_shell_command: cat ~/.gemini/extensions/pipeline-orchestrator/references/<path>
```

Available references:
- `references/checklists/` — Security checklists (auth, crypto, injection, etc.)
- `references/gates/` — Gate definitions (macro-gate, micro-gate)
- `references/pipelines/` — 12 pipeline type definitions (6 types × light/heavy)
- `references/complexity-matrix.md` — Task classification matrix
- `references/glossary.md` — Pipeline terminology
- `references/team-registry.md` — Agent team compositions
- `references/sentinel-integration.md` — Sentinel validation modes

## Key Rules

1. **Always classify first** — No implementation without ORCHESTRATOR_DECISION
2. **Proportional intensity** — SIMPLES=Light, MÉDIA=Light/Heavy, COMPLEXA=Heavy
3. **Stop Rule** — If build/test fails 2×, stop and analyze root cause
4. **Gate enforcement** — Every phase gate must pass before proceeding
