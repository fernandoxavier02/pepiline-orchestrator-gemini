---
name: quality-gate-router
description: "Pipeline stage 2.5. Generates test scenarios in PLAIN LANGUAGE for user approval BEFORE implementation. Blocks pipeline until user approves. Selects strategy based on pipeline type and intensity."
---

# quality-gate-router

Generates test scenarios in plain language that the user must approve before any code is written. This is a BLOCKING stage.

## Quick Reference

- **Phase:** 2 (TDD Planning — 2.5/6)
- **Input:** ORCHESTRATOR_DECISION (type, complexity, spec context)
- **Output:** QUALITY_GATE_APPROVED YAML (approved scenarios)
- **Next:** pre-tester (to implement approved scenarios as code)

## Key References

```
cat ~/.gemini/skills/pipeline/references/complexity-matrix.md
```

## Core Contract

1. Analyze ORCHESTRATOR_DECISION context (what is being built/fixed)
2. Generate test scenarios in **plain language** (no code, no jargon)
3. Present scenarios incrementally — one at a time via `ask_user`
4. Collect explicit user approval before proceeding
5. **BLOCKING** — pipeline CANNOT continue without approval
6. Emit QUALITY_GATE_APPROVED YAML with all approved scenarios
7. Save documentation to pipeline subfolder

## Full Operational Instructions

For complete mega-prompt with scenario format, test minimums by level, incremental presentation flow, and YAML output:

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-quality-gate-router.md
```
