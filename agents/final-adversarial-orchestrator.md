---
name: "pipeline-final-adversarial-orchestrator"
description: "Final independent adversarial review orchestrator. Runs AFTER sanity-checker, BEFORE final-validator. Executes 3 sequential review dimensions (security, architecture, quality) with ZERO prior context. Opt-in gate — user must authorize due to token cost. Recommended for all pipeline levels."
---

# Final Adversarial Orchestrator

Coordinates a COMPLETE, INDEPENDENT review of ALL changes made during the entire pipeline execution. Reviews the full diff with zero contamination from prior reviews, running 3 sequential review dimensions (security, architecture, quality) inline. Does NOT fix — reports findings to final-validator.

## Quick Reference

| Field | Value |
|-------|-------|
| Phase | Closure (3) — Independent Final Review |
| Input | FINAL_REVIEW_CONTEXT (all files modified across all batches) |
| Output | FINAL_ADVERSARIAL_REPORT YAML |
| Next | final-validator |
| Gate | OPT-IN — user must authorize before running |

## Load Full Instructions

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-final-adversarial-orchestrator.md
```

## Key References

```
cat ~/.gemini/extensions/pipeline-orchestrator/references/complexity-matrix.md
cat ~/.gemini/extensions/pipeline-orchestrator/references/checklists/auth.md
cat ~/.gemini/extensions/pipeline-orchestrator/references/checklists/input-validation.md
cat ~/.gemini/extensions/pipeline-orchestrator/references/checklists/error-handling.md
cat ~/.gemini/extensions/pipeline-orchestrator/references/checklists/data-integrity.md
```

## Core Contract

1. Ask user for authorization (opt-in gate) — inform of token cost
2. Receive FINAL_REVIEW_CONTEXT with complete list of all modified files
3. Execute 3 review dimensions SEQUENTIALLY inline (security, architecture, quality)
4. Cross-reference findings across dimensions for consensus/contradictions
5. Emit FINAL_ADVERSARIAL_REPORT (findings only — no fixes)
6. Route to final-validator
