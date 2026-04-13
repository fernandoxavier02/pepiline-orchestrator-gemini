# BRIDGE_SPEC: Claude Code → Gemini CLI Pipeline Orchestrator

> Mapeamento canônico entre a fonte (CC plugin) e o port (Gemini extension).
> Atualizado: 2026-04-12 | CC v3.1.0 | Gemini v1.3.0

## Architecture Differences

| Aspecto | Claude Code (CC) | Gemini CLI |
|---------|-------------------|------------|
| Agent dispatch | Task tool (subagents) | Inline mega-prompts (sem subagents) |
| Agent count | 20 plugin + 3 global = 23 | 15 (consolidated) |
| Tool: shell | Bash | run_shell_command |
| Tool: user input | AskUserQuestion | ask_user |
| Tool: files | Read/Write/Edit | read_file/write_file/edit_file |
| Tool: tasks | TodoWrite | (removed — inline tracking) |
| Tool: search | Grep/Glob | search_files |
| Config path | .claude/ | .gemini/ |
| Reference loading | Auto-loaded by plugin | cat ~/.gemini/extensions/pipeline-orchestrator/references/*.md |
| Pattern | Agent definitions (short) | Two-tier: thin stub + mega-prompt skill |

## Agent Mapping

### Ported (12 agents)

| # | Gemini Agent | CC Source | CC Path | Phase | Lines |
|---|-------------|-----------|---------|-------|-------|
| 1 | task-orchestrator | task-orchestrator | core/task-orchestrator.md | 0a | 532 |
| 2 | context-classifier | context-classifier | ~/.claude/agents/context-classifier.md (global) | 0a | 734 |
| 3 | orchestrator-documenter | orchestrator-documenter | ~/.claude/agents/orchestrator-documenter.md (global) | 0b-1 | 529 |
| 4 | architect-interrogator | design-interrogator | quality/design-interrogator.md | 1 | 607 |
| 5 | executor-controller | executor-controller | executor/executor-controller.md | 2 | 606 |
| 6 | executor-implementer-task | executor-implementer-task | executor/executor-implementer-task.md | 2 | 602 |
| 7 | executor-spec-reviewer | executor-spec-reviewer | executor/executor-spec-reviewer.md | 2 | 536 |
| 8 | executor-quality-reviewer | executor-quality-reviewer | executor/executor-quality-reviewer.md | 2 | 433 |
| 9 | adversarial-reviewer | adversarial-batch | core/adversarial-batch.md | 3 | 632 |
| 10 | sanity-checker | sanity-checker | core/sanity-checker.md | 3 | 415 |
| 11 | final-validator | final-validator | core/final-validator.md | 3 | 426 |
| 12 | finishing-branch | finishing-branch | core/finishing-branch.md | 3 | 523 |

### Not Ported — Absorbed Into Inline Logic

These CC agents exist as standalone subagents in CC but their logic is **inlined** into
the Gemini mega-prompts of the agents that invoke them.

| CC Agent | Absorbed Into | Reason |
|----------|--------------|--------|
| sentinel | executor-controller (Section 6.5), orchestrator-documenter | 3 validation modes inlined: ORCHESTRATOR, SEQUENCE, COHERENCE |
| information-gate | task-orchestrator, architect-interrogator | Gap detection inlined into classification + interrogation phases |
| checkpoint-validator | executor-controller (Section 8) | Checkpoint logic inlined as sequential steps |
| executor-fix | executor-controller (retry flow) | Fix dispatching inlined as retry protocol |
| review-orchestrator | executor-controller (Section 7d-7e) | Review coordination inlined as spec-review + quality-review phases |
| plan-architect | architect-interrogator (Section 8.5) | Codebase research + implementation plan + user approval inlined |

### Ported in Phase 4 (3 quality agents)

| # | Gemini Agent | CC Source | CC Path | Phase | Lines |
|---|-------------|-----------|---------|-------|-------|
| 13 | quality-gate-router | quality-gate-router | quality/quality-gate-router.md | 2 (TDD) | 429 |
| 14 | pre-tester | pre-tester | quality/pre-tester.md | 2 (TDD) | 563 |
| 15 | final-adversarial-orchestrator | final-adversarial-orchestrator | quality/final-adversarial-orchestrator.md | 3 | 557 |

### Not Ported — Intentionally Skipped

| CC Agent | Domain | Reason |
|----------|--------|--------|
| architecture-reviewer | quality | Redundant with executor-quality-reviewer (patterns/SOLID/naming). Not referenced in any pipeline or skill. |

### Note: CC Global Agents Ported

The following agents exist as **global agents** in CC (`~/.claude/agents/`) rather than plugin agents. They are already listed in the Ported table above but noted here for clarity on their CC source location:

| Gemini Agent | CC Global Source | Why Global in CC |
|-------------|-----------------|------------------|
| task-orchestrator | ~/.claude/agents/task-orchestrator.md (579 lines) | Also exists as plugin agent (270 lines); global version is canonical |
| context-classifier | ~/.claude/agents/context-classifier.md (638 lines) | Gemini needs explicit context enrichment (CC handles via hooks) |
| orchestrator-documenter | ~/.claude/agents/orchestrator-documenter.md (890 lines) | Pipeline selection logic explicit in Gemini (CC uses plugin routing) |

## File Structure Mapping

```
CC Plugin (FX-Studio-AI/pipeline-orchestrator/3.1.0/)
├── agents/
│   ├── core/          (8 agents)
│   ├── executor/      (5 agents)
│   └── quality/       (7 agents)
├── references/
│   ├── checklists/    (7 files)
│   ├── gates/         (2 files)
│   ├── pipelines/     (12 files: 6 types × light/heavy)
│   ├── complexity-matrix.md
│   ├── glossary.md
│   ├── sentinel-integration.md
│   └── team-registry.md
├── skills/pipeline/SKILL.md
└── commands/pipeline.md

Gemini Extension (~/.gemini/extensions/pipeline-orchestrator/)
├── gemini-extension.json      (manifest v2.0.0)
├── GEMINI.md                  (context file — auto-loaded at session start)
├── BRIDGE_SPEC.md             (this file)
├── agents/                    (15 stubs, 38-52 lines each)
├── skills/                    (31 mega-prompt skill files, 164-734 lines each)
├── commands/pipeline.toml     (/pipeline command)
└── references/                (self-contained — no external paths)
    ├── checklists/            (7 files — copied from CC)
    ├── gates/                 (2 files — copied from CC)
    ├── pipelines/             (12 files: 6 types × light/heavy)
    ├── complexity-matrix.md
    ├── glossary.md
    ├── sentinel-integration.md
    └── team-registry.md
# NOTE: v2.0.0 flattened structure for `gemini extensions install` compatibility
# NOTE: MCP server (server/) removed in v1.2.0 — superseded by mega-prompt agents
# NOTE: References moved from ~/.gemini/skills/pipeline/references/ to extension-local in v2.0.0
```

## Tool Adaptation Map

| CC Tool | Gemini Equivalent | Notes |
|---------|-------------------|-------|
| `Task` (subagent spawn) | Inline mega-prompt steps | All subagent logic inlined |
| `Bash` | `run_shell_command` | Direct 1:1 |
| `AskUserQuestion` | `ask_user` | Direct 1:1 |
| `Read` | `read_file` | Direct 1:1 |
| `Write` | `write_file` | Direct 1:1 |
| `Edit` | `edit_file` | Direct 1:1 |
| `Grep` | `run_shell_command: grep` | Gemini uses shell grep |
| `Glob` | `run_shell_command: find` | Gemini uses shell find |
| `TodoWrite` | (removed) | Inline tracking in YAML blocks |
| `Agent` | (not available) | All orchestration is inline |

## Pipeline References (Complete)

All 12 pipeline type definitions are in `~/.gemini/extensions/pipeline-orchestrator/references/pipelines/`:

| Type | Light | Heavy |
|------|-------|-------|
| Bugfix | bugfix-light.md (103 lines) | bugfix-heavy.md (125 lines) |
| Implement | implement-light.md (103 lines) | implement-heavy.md (122 lines) |
| User Story | user-story-light.md (102 lines) | user-story-heavy.md (123 lines) |
| Audit | audit-light.md (111 lines) | audit-heavy.md (146 lines) |
| Adversarial | adversarial-light.md (74 lines) | adversarial-heavy.md (114 lines) |
| UX Simulation | ux-sim-light.md (110 lines) | ux-sim-heavy.md (146 lines) |

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-04-12 | Phase 1: 4 core agents ported (task-orchestrator, executor-implementer, final-validator, sanity-checker) |
| 1.1.0 | 2026-04-12 | Phase 2: 8 remaining agents ported + manifest updated to 12 agents + stubs cleanup |
| 1.2.0 | 2026-04-12 | Phase 3: MCP server removed (superseded by mega-prompt agents). 4.600 lines of dead code eliminated |
| 1.3.0 | 2026-04-12 | Phase 4: 3 quality agents ported (quality-gate-router, pre-tester, final-adversarial-orchestrator). architecture-reviewer intentionally skipped (redundant). 15-agent architecture finalized |
| 2.0.0 | 2026-04-13 | Phase 5: Restructured for `gemini extensions install` compatibility. Flattened directory (removed extension/ subdirectory). Added GEMINI.md context file. Self-contained references (moved from ~/.gemini/skills/pipeline/references/ to extension-local). Added 16 domain-specific skills (bugfix, audit, feature, UX, adversarial). Total: 15 agents, 31 skills, 24 references |
