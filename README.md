<h1 align="center">Pipeline Orchestrator for Gemini CLI</h1>

<p align="center">
  <strong>15-Agent Multi-Phase Task Execution Engine for Google Gemini CLI</strong><br/>
  <em>Ported from the Claude Code Pipeline Orchestrator plugin — fully adapted for Gemini's native architecture</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Google%20Gemini%20CLI-4285F4?style=flat-square&logo=google&logoColor=white" alt="Platform"/>
  <img src="https://img.shields.io/badge/version-2.0.0-blue?style=flat-square" alt="Version"/>
  <img src="https://img.shields.io/badge/agents-15-orange?style=flat-square" alt="Agents"/>
  <img src="https://img.shields.io/badge/skills-31-blueviolet?style=flat-square" alt="Skills"/>
  <img src="https://img.shields.io/badge/references-24-informational?style=flat-square" alt="References"/>
  <img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" alt="License"/>
</p>

---

## Overview

Pipeline Orchestrator transforms Google Gemini CLI into a **structured, multi-agent execution engine** with auto-classification, adaptive batching, adversarial review, and Go/No-Go gates. Every task — from a one-line bug fix to a complex feature — flows through a disciplined pipeline that ensures quality before any change is finalized.

The system consists of **15 specialized agents** with **31 skills** and **24 reference files**, orchestrated across **4 phases**. Tasks are classified by type and complexity, routed to the appropriate pipeline intensity (Light or Heavy), and validated at every stage.

## How It Works

```
User Request
    |
    v
+--------------------------------------------------------------+
|  PHASE 0: TRIAGE                                             |
|  task-orchestrator --> context-classifier                     |
|  (classify type, complexity, severity, persona)              |
+--------------------------------------------------------------+
    |
    v
+--------------------------------------------------------------+
|  PHASE 1: PLANNING                                           |
|  orchestrator-documenter --> architect-interrogator           |
|  (select pipeline, interrogate design for COMPLEXA)          |
+--------------------------------------------------------------+
    |
    v
+--------------------------------------------------------------+
|  PHASE 2: EXECUTION                                          |
|  executor-controller --> implementer --> spec-reviewer        |
|  --> quality-reviewer --> quality-gate-router --> pre-tester  |
|  (TDD, vertical slices, adaptive batching)                   |
+--------------------------------------------------------------+
    |
    v
+--------------------------------------------------------------+
|  PHASE 3: VALIDATION & CLOSURE                               |
|  adversarial-reviewer --> sanity-checker --> final-validator  |
|  --> final-adversarial-orchestrator --> finishing-branch       |
|  (blind review, Go/No-Go, merge/PR/discard)                 |
+--------------------------------------------------------------+
```

## Installation

### Prerequisites

- [Gemini CLI](https://github.com/google-gemini/gemini-cli) installed and configured
- `~/.gemini/` directory exists

### Option 1: Gemini CLI Native (recommended)

```bash
gemini extensions install https://github.com/fernandoxavier02/pepiline-orchestrator-gemini
```

That's it. The Gemini CLI handles everything automatically.

To update later:

```bash
gemini extensions update pipeline-orchestrator
```

### Option 2: Automated Script

```bash
git clone https://github.com/fernandoxavier02/pepiline-orchestrator-gemini.git
cd pepiline-orchestrator-gemini
chmod +x install.sh
./install.sh
```

### Option 3: Symlink (for development)

```bash
git clone https://github.com/fernandoxavier02/pepiline-orchestrator-gemini.git
cd pepiline-orchestrator-gemini
gemini extensions link .
```

Changes to the repo reflect immediately after restarting the Gemini CLI session.

### Verify Installation

```bash
# Check extension is recognized
gemini extensions list

# Or manually verify
ls ~/.gemini/extensions/pipeline-orchestrator/gemini-extension.json  # Must exist
ls ~/.gemini/extensions/pipeline-orchestrator/agents/*.md | wc -l    # Should be 15
ls ~/.gemini/extensions/pipeline-orchestrator/skills/*.md | wc -l    # Should be 31
find ~/.gemini/extensions/pipeline-orchestrator/references -name "*.md" | wc -l  # Should be 24
```

### Uninstall

```bash
# Via Gemini CLI
gemini extensions disable pipeline-orchestrator

# Or complete removal
chmod +x uninstall.sh && ./uninstall.sh
```

---

## Usage

```bash
# Submit any task -- the orchestrator classifies and routes automatically
/pipeline "Refactor the authentication module to use dependency injection"

# The pipeline will:
# 1. Classify: Feature, MEDIA complexity
# 2. Select: implement-light pipeline
# 3. Execute: TDD -> implement -> spec review -> quality review
# 4. Validate: adversarial review -> sanity check -> Go/No-Go
```

### Flags

| Flag | Effect |
|------|--------|
| `--hotfix` | Elevates severity, routes to heavy pipeline |
| `--grill` | Activates design interrogator for deep design review |
| `--review-only` | Audit mode — generates report, no implementation |

The orchestrator handles everything from classification to branch completion. You approve at key gates; the agents handle the rest.

---

## Agent Reference

| # | Agent | Phase | Role |
|---|-------|-------|------|
| 1 | `task-orchestrator` | 0a | **Mandatory entry point** — classifies type, complexity, severity, and selects persona |
| 2 | `context-classifier` | 0a | Classifies complexity, collects context, blocks source-of-truth conflicts |
| 3 | `orchestrator-documenter` | 0b-1 | Selects pipeline type + intensity (Light/Heavy), delivers instructions to executor |
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

| Pipeline | Light | Heavy | When |
|----------|-------|-------|------|
| Bug Fix | `bugfix-light` | `bugfix-heavy` | Fixing known issues |
| Feature | `implement-light` | `implement-heavy` | New functionality |
| User Story | `user-story-light` | `user-story-heavy` | User-facing stories |
| Audit | `audit-light` | `audit-heavy` | Code analysis (read-only) |
| Adversarial | `adversarial-light` | `adversarial-heavy` | Security-focused work |
| UX Simulation | `ux-sim-light` | `ux-sim-heavy` | User experience testing |

**Complexity to Intensity mapping:**

| Complexity | Intensity | Agents Active |
|------------|-----------|---------------|
| SIMPLES | Light | 5-7 agents, minimal gates |
| MEDIA | Light or Heavy | 8-12 agents, proportional gates |
| COMPLEXA | Heavy | All 15 agents, full adversarial review |

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

---

## File Structure

```
pipeline-orchestrator/
├── gemini-extension.json          # Extension manifest (v2.0.0)
├── GEMINI.md                      # Context file (auto-loaded at session start)
├── BRIDGE_SPEC.md                 # Claude Code -> Gemini CLI mapping docs
├── agents/                        # 15 agent stub definitions
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
├── skills/                        # 31 mega-prompt skill files
│   ├── pipeline-task-orchestrator.md          # Core (15)
│   ├── pipeline-context-classifier.md
│   ├── ...
│   ├── pipeline-bugfix-diagnostic-agent.md    # Domain: Bugfix (3)
│   ├── pipeline-bugfix-root-cause-analyzer.md
│   ├── pipeline-bugfix-regression-tester.md
│   ├── pipeline-audit-intake.md               # Domain: Audit (4)
│   ├── pipeline-audit-domain-analyzer.md
│   ├── pipeline-audit-compliance-checker.md
│   ├── pipeline-audit-risk-matrix-generator.md
│   ├── pipeline-feature-vertical-slice-planner.md   # Domain: Feature (3)
│   ├── pipeline-feature-implementer.md
│   ├── pipeline-feature-integration-validator.md
│   ├── pipeline-adversarial-security-scanner.md     # Domain: Adversarial (3)
│   ├── pipeline-adversarial-architecture-critic.md
│   ├── pipeline-adversarial-review-coordinator.md
│   ├── pipeline-ux-simulator.md               # Domain: UX (3)
│   ├── pipeline-ux-accessibility-auditor.md
│   └── pipeline-ux-qa-validator.md
├── commands/
│   └── pipeline.toml              # /pipeline command entry point
├── references/                    # Runtime reference files (24 files)
│   ├── checklists/                # Security checklists (7)
│   │   ├── auth.md
│   │   ├── crypto.md
│   │   ├── injection.md
│   │   ├── input-validation.md
│   │   ├── business-logic.md
│   │   ├── data-integrity.md
│   │   └── error-handling.md
│   ├── gates/                     # Gate definitions (2)
│   │   ├── macro-gate-questions.md
│   │   └── micro-gate-checklist.md
│   ├── pipelines/                 # Pipeline type definitions (12)
│   │   ├── bugfix-light.md / bugfix-heavy.md
│   │   ├── implement-light.md / implement-heavy.md
│   │   ├── user-story-light.md / user-story-heavy.md
│   │   ├── audit-light.md / audit-heavy.md
│   │   ├── adversarial-light.md / adversarial-heavy.md
│   │   └── ux-sim-light.md / ux-sim-heavy.md
│   ├── complexity-matrix.md
│   ├── glossary.md
│   ├── sentinel-integration.md
│   └── team-registry.md
├── install.sh                     # Alternative manual installer
├── uninstall.sh                   # Uninstaller
└── README.md
```

### Two-Tier Agent Pattern

Each agent has two files:

1. **Agent stub** (`agents/*.md`) — 38-52 lines. Thin dispatcher that declares the agent's role and loads the corresponding skill.
2. **Mega-prompt skill** (`skills/pipeline-*.md`) — 415-734 lines. Contains the full agent logic, decision trees, and inline orchestration.

This differs from Claude Code where agents are subprocesses. In Gemini CLI, all orchestration is **inline** — the mega-prompt skill IS the agent execution.

---

## Key Adaptations from Claude Code

| Claude Code | Gemini CLI | Notes |
|-------------|------------|-------|
| `Task` / `Agent` tool | `activate_skill` + inline execution | No isolated subagent dispatch |
| `Bash` | `run_shell_command` | All shell execution |
| `AskUserQuestion` | `ask_user` | User input/confirmation |
| `Read` / `Write` / `Edit` | `read_file` / `write_file` / `edit_file` | File operations |
| `Grep` / `Glob` | `run_shell_command` with `grep` / `find` | Search operations |
| `TodoWrite` | Inline YAML tracking blocks | Progress tracking |
| 23 agents (subprocesses) | 15 agents (inline mega-prompts) | 8 absorbed into inline logic |

See `BRIDGE_SPEC.md` for the complete mapping.

---

## For Extension Gallery

To make this extension discoverable in the [Gemini CLI Extension Gallery](https://geminicli.com/extensions/), add the GitHub topic `gemini-cli-extension` to the repository settings.

## Credits

- **Original Plugin**: Pipeline Orchestrator for Claude Code by [Fernando Xavier](https://github.com/fernandoxavier02)
- **Gemini Port**: [Fernando Xavier](https://github.com/fernandoxavier02)

## License

MIT License

---

<div align="center">
  <strong>Built by <a href="https://github.com/fernandoxavier02">Fernando Xavier</a></strong>
  <br/>
  <a href="https://fxstudioai.com">FX Studio AI</a> — Business Automation with AI
</div>
