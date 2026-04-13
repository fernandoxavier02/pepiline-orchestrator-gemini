<div align="center">
  <img src="assets/fx-studio-ai-logo.png" alt="FX Studio AI" width="600"/>
</div>

<h1 align="center">Pipeline Orchestrator for Gemini</h1>

<p align="center">
  <strong>15-Agent Multi-Phase Task Execution Engine for Google Gemini CLI</strong><br/>
  <em>Ported from the Claude Code Pipeline Orchestrator plugin — fully adapted for Gemini's native architecture</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Google%20Gemini%20CLI-4285F4?style=flat-square&logo=google&logoColor=white" alt="Platform"/>
  <img src="https://img.shields.io/badge/version-1.3.0-blue?style=flat-square" alt="Version"/>
  <img src="https://img.shields.io/badge/agents-15-orange?style=flat-square" alt="Agents"/>
  <img src="https://img.shields.io/badge/skills-15-blueviolet?style=flat-square" alt="Skills"/>
  <img src="https://img.shields.io/badge/lines-9%2C004-informational?style=flat-square" alt="Lines of content"/>
  <img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" alt="License"/>
</p>

---

## Overview

Pipeline Orchestrator transforms Google Gemini CLI into a **structured, multi-agent execution engine** with auto-classification, adaptive batching, adversarial review, and Go/No-Go gates. Every task — from a one-line bug fix to a complex feature — flows through a disciplined pipeline that ensures quality before any change is finalized.

The system consists of **15 specialized agents**, each with a corresponding skill, orchestrated across **4 phases**. Tasks are classified by type and complexity, routed to the appropriate pipeline intensity (Light or Heavy), and validated at every stage.

## How It Works

```
User Request
    │
    ▼
┌──────────────────────────────────────────────────────────────┐
│  PHASE 0: TRIAGE                                              │
│  ┌───────────────────┐    ┌────────────────────┐              │
│  │ task-orchestrator  │───▶│ context-classifier │              │
│  │ (entry point)      │    │ (type + complexity)│              │
│  └───────────────────┘    └────────────────────┘              │
└──────────────────────────────────────────────────────────────┘
    │
    ▼
┌──────────────────────────────────────────────────────────────┐
│  PHASE 1: PROPOSAL                                            │
│  ┌─────────────────────────┐    ┌──────────────────────────┐  │
│  │ orchestrator-documenter  │    │ architect-interrogator   │  │
│  │ (pipeline selection)     │    │ (COMPLEXA tasks only)    │  │
│  └─────────────────────────┘    └──────────────────────────┘  │
└──────────────────────────────────────────────────────────────┘
    │
    ▼
┌──────────────────────────────────────────────────────────────┐
│  PHASE 2: EXECUTION                                           │
│  ┌───────────────────┐  ┌──────────────────┐  ┌───────────┐  │
│  │ executor-controller│─▶│ implementer-task  │─▶│ spec-     │  │
│  │ (batch orchestrator)│  │ (TDD + code)     │  │ reviewer  │  │
│  └───────────────────┘  └──────────────────┘  └───────────┘  │
│                                                    │          │
│  ┌──────────────────┐  ┌───────────────────┐       │          │
│  │ quality-reviewer  │◀─│ quality-gate-router│  ◀───┘          │
│  │ (SOLID/DRY/KISS)  │  │ (test scenarios)  │                 │
│  └──────────────────┘  └───────────────────┘                 │
│                         ┌────────────┐                        │
│                         │ pre-tester │                        │
│                         │ (RED phase)│                        │
│                         └────────────┘                        │
└──────────────────────────────────────────────────────────────┘
    │
    ▼
┌──────────────────────────────────────────────────────────────┐
│  PHASE 3: VALIDATION & CLOSURE                                │
│  ┌──────────────────┐  ┌────────────────┐  ┌──────────────┐  │
│  │adversarial-reviewer│─▶│ sanity-checker │─▶│final-validator│  │
│  │ (blind review)    │  │ (build + test) │  │ (Go/No-Go)   │  │
│  └──────────────────┘  └────────────────┘  └──────────────┘  │
│                                                               │
│  ┌──────────────────────────┐  ┌──────────────────────┐       │
│  │final-adversarial-orchestr│  │  finishing-branch     │       │
│  │ (opt-in deep review)     │  │  (merge/PR/discard)   │       │
│  └──────────────────────────┘  └──────────────────────┘       │
└──────────────────────────────────────────────────────────────┘
```

## Agent Reference

| # | Agent | Phase | Role |
|---|-------|-------|------|
| 1 | `task-orchestrator` | 0a | **Mandatory entry point** — classifies type, complexity, severity, and selects persona |
| 2 | `context-classifier` | 0a | Classifies complexity, collects context, blocks source-of-truth conflicts |
| 3 | `orchestrator-documenter` | 0b–1 | Selects pipeline type + intensity (Light/Heavy), delivers instructions to executor |
| 4 | `architect-interrogator` | 1 | Design interrogation for COMPLEXA tasks — resolves trade-offs before implementation |
| 5 | `executor-controller` | 2 | Orchestrates execution in adaptive batches, dispatches per-task subagents |
| 6 | `executor-implementer-task` | 2 | Implementation engine with TDD, vertical slices, and micro-gates |
| 7 | `executor-spec-reviewer` | 2 | Verifies implementation matches spec requirements (does NOT trust implementer) |
| 8 | `executor-quality-reviewer` | 2 | Reviews code quality: SOLID, KISS, DRY, YAGNI — runs after spec-reviewer PASS |
| 9 | `quality-gate-router` | 2 | Generates test scenarios in plain language for user approval before implementation |
| 10 | `pre-tester` | 2 | Converts approved scenarios into automated RED-phase tests (TDD) |
| 11 | `adversarial-reviewer` | 3 | Blind adversarial review — seeks failures, edge cases, vulnerabilities |
| 12 | `sanity-checker` | 3 | Proportional sanity checks: build (SIMPLES), +tests (MEDIA), +regression (COMPLEXA) |
| 13 | `final-validator` | 3 | Final Go/No-Go decision — consolidates all agent results |
| 14 | `final-adversarial-orchestrator` | 3 | Independent 3-reviewer adversarial audit (opt-in, zero prior context) |
| 15 | `finishing-branch` | 3 | Branch completion: merge locally, create PR, keep as-is, or discard |

## Pipeline Types

The orchestrator supports **8 pipeline types** with **2 intensity levels** each:

| Pipeline | Light | Heavy | When |
|----------|-------|-------|------|
| Bug Fix | `bugfix-light` | `bugfix-heavy` | Fixing known issues |
| Feature | `implement-light` | `implement-heavy` | New functionality |
| User Story | `user-story-light` | `user-story-heavy` | User-facing stories |
| Audit | `audit-light` | `audit-heavy` | Code analysis (read-only) |
| Refactor | `refactor-light` | `refactor-heavy` | Code restructuring |
| Security | `security-light` | `security-heavy` | Security-focused work |
| Hotfix | `hotfix-light` | `hotfix-heavy` | Urgent production fixes |
| Regression | `regression-light` | `regression-heavy` | Test suite management |

**Complexity → Intensity mapping:**

| Complexity | Intensity | Agents Active |
|------------|-----------|---------------|
| SIMPLES | Light | 5–7 agents, minimal gates |
| MEDIA | Light or Heavy | 8–12 agents, proportional gates |
| COMPLEXA | Heavy | All 15 agents, full adversarial review |

## Architecture

```
~/.gemini/extensions/pipeline-orchestrator/
├── gemini-extension.json                # Extension manifest (v1.3.0)
├── BRIDGE_SPEC.md                       # CC → Gemini mapping document
├── agents/                              # 15 agent definitions
│   ├── task-orchestrator.md
│   ├── context-classifier.md
│   ├── orchestrator-documenter.md
│   ├── architect-interrogator.md
│   ├── executor-controller.md
│   ├── executor-implementer-task.md
│   ├── executor-spec-reviewer.md
│   ├── executor-quality-reviewer.md
│   ├── quality-gate-router.md
│   ├── pre-tester.md
│   ├── adversarial-reviewer.md
│   ├── sanity-checker.md
│   ├── final-validator.md
│   ├── final-adversarial-orchestrator.md
│   └── finishing-branch.md
├── skills/                              # 15 corresponding skills
│   ├── pipeline-task-orchestrator.md
│   ├── pipeline-context-classifier.md
│   ├── pipeline-orchestrator-documenter.md
│   ├── pipeline-architect-interrogator.md
│   ├── pipeline-executor-controller.md
│   ├── pipeline-executor-implementer-task.md
│   ├── pipeline-executor-spec-reviewer.md
│   ├── pipeline-executor-quality-reviewer.md
│   ├── pipeline-quality-gate-router.md
│   ├── pipeline-pre-tester.md
│   ├── pipeline-adversarial-reviewer.md
│   ├── pipeline-sanity-checker.md
│   ├── pipeline-final-validator.md
│   ├── pipeline-final-adversarial-orchestrator.md
│   └── pipeline-finishing-branch.md
└── commands/
    └── pipeline.toml                    # /pipeline command entry point
```

## Key Adaptations from Claude Code

| Claude Code | Gemini CLI | Notes |
|-------------|------------|-------|
| `Task` / `Agent` tool | `activate_skill` + inline execution | No isolated subagent dispatch |
| `Bash` | `run_shell_command` | All shell execution |
| `AskUserQuestion` | `ask_user` | User input/confirmation |
| `Read` / `Write` / `Edit` | `read_file` / `write_file` / `edit_file` | File operations |
| `Grep` / `Glob` | `run_shell_command` with `grep` / `find` | Search operations |
| `TodoWrite` | Inline YAML tracking blocks | Progress tracking |
| Parallel agent dispatch | Sequential skill chaining | Gemini is single-session |

## Installation

### Prerequisites

- [Gemini CLI](https://github.com/google-gemini/gemini-cli) installed and configured
- `~/.gemini/` directory exists

### Option 1: Automated (recommended)

```bash
git clone https://github.com/fernandoxavier02/pepiline-orchestrator-gemini.git
cd pepiline-orchestrator-gemini
chmod +x install.sh
./install.sh
```

The installer copies files to two locations:

| What | Where |
|------|-------|
| Extension (agents, skills, commands, manifest) | `~/.gemini/extensions/pipeline-orchestrator/` |
| Shared references (checklists, gates, pipelines) | `~/.gemini/skills/pipeline/references/` |

> **Why two locations?** The agents load reference files at runtime via `cat ~/.gemini/skills/pipeline/references/...`. This is required by the Gemini CLI mega-prompt pattern — agents need these files to make decisions about pipeline type, security checklists, and gate criteria.

### Option 2: Symlink

```bash
git clone https://github.com/fernandoxavier02/pepiline-orchestrator-gemini.git
cd pepiline-orchestrator-gemini

# Extension
ln -s "$(pwd)/extension" ~/.gemini/extensions/pipeline-orchestrator

# References (required — agents won't work without these)
mkdir -p ~/.gemini/skills/pipeline
ln -s "$(pwd)/extension/references" ~/.gemini/skills/pipeline/references
```

### Option 3: Manual copy

```bash
git clone https://github.com/fernandoxavier02/pepiline-orchestrator-gemini.git
cd pepiline-orchestrator-gemini

# Extension
cp -R extension/ ~/.gemini/extensions/pipeline-orchestrator/

# References
mkdir -p ~/.gemini/skills/pipeline
cp -R extension/references/ ~/.gemini/skills/pipeline/references/
```

### Verify Installation

```bash
# Extension manifest
ls ~/.gemini/extensions/pipeline-orchestrator/gemini-extension.json  # Must exist

# Agents (should be 15)
ls ~/.gemini/extensions/pipeline-orchestrator/agents/*.md | wc -l

# Skills (should be 31 — 15 core + 16 domain-specific)
ls ~/.gemini/extensions/pipeline-orchestrator/skills/*.md | wc -l

# References (should be ~24)
find ~/.gemini/skills/pipeline/references -name "*.md" | wc -l
```

### Uninstall

```bash
chmod +x uninstall.sh
./uninstall.sh
```

## Usage

```bash
# Submit any task — the orchestrator classifies and routes automatically
/pipeline "Refactor the authentication module to use dependency injection"

# The pipeline will:
# 1. Classify: Feature, MEDIA complexity
# 2. Select: implement-light pipeline
# 3. Execute: TDD → implement → spec review → quality review
# 4. Validate: adversarial review → sanity check → Go/No-Go
```

The orchestrator handles everything from classification to branch completion. You approve at key gates; the agents handle the rest.

## Quality Gates

| Gate | Condition | Action if Failed |
|------|-----------|-----------------|
| Classification | Task type + complexity determined | STOP — cannot proceed without classification |
| Information | All critical gaps resolved | BLOCK — ask one question at a time until resolved |
| Spec Review | Implementation matches requirements | FAIL — return to implementer with feedback |
| Quality Review | SOLID/DRY/KISS/YAGNI compliance | FAIL — return to implementer with findings |
| Adversarial | No critical vulnerabilities found | FAIL — fix loop (max 3 attempts) |
| Sanity Check | Build + tests pass | STOP — cannot finalize with failures |
| Final Validation | All agents report GO | NO-GO — consolidate issues for user decision |

## Credits

- **Original Plugin**: Pipeline Orchestrator for Claude Code by [Fernando Xavier](https://github.com/fernandoxavier02)
- **Gemini Port**: [Fernando Xavier](https://github.com/fernandoxavier02)

## License

MIT License. See [LICENSE](LICENSE) for details.

---

<div align="center">
  <strong>Built by <a href="https://github.com/fernandoxavier02">Fernando Xavier</a></strong>
  <br/>
  <a href="https://fxstudioai.com">FX Studio AI</a> — Business Automation with AI
</div>
