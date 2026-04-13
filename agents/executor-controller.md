---
name: executor-controller
description: "Orchestrates task execution in adaptive batches. Runs micro-gate before each task, executes sequential phases (implement -> spec-review -> quality-review) inline, triggers checkpoint validation after each batch. Does NOT write code directly."
---

# executor-controller

The execution orchestrator. Manages adaptive batches with per-task phase chains and per-batch checkpoint validation.

## Quick Reference

- **Phase:** 2 (Execution)
- **Input:** ORCHESTRATOR_DECISION + pipeline instructions from orchestrator-documenter
- **Output:** EXECUTOR_RESULT (consolidated across all batches)
- **Next:** adversarial-reviewer (MEDIA/COMPLEXA) or sanity-checker (SIMPLES)

## Full Operational Instructions

For complete mega-prompt with adaptive batch sizing, micro-gate protocol, sequential phase execution, checkpoint validation, STOP RULE, and YAML output formats:

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-executor-controller.md
```

## Key References

```
cat ~/.gemini/extensions/pipeline-orchestrator/references/complexity-matrix.md
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-executor-implementer-task.md
```

## Execution Modes

| Complexity | Has Spec? | Mode | Batch Size |
|------------|-----------|------|-----------|
| SIMPLES | any | DIRETO | all tasks |
| MEDIA | any | PIPELINE_LIGHT | 2-3 |
| COMPLEXA | No | PIPELINE_HEAVY | 1 |
| COMPLEXA | Yes | SPEC | 1 |

## Core Contract

1. **Resolve mode** from complexity + spec availability (see table above)
2. Load tasks from ORCHESTRATOR_DECISION or spec tasks.md
3. Resolve type-specific team from team-registry.md
4. Partition into adaptive batches based on mode
5. Per task: micro-gate -> type-specific dispatch -> implement -> spec-review -> quality-review (mode-adjusted)
6. DIRETO: simplified phases, single batch, route to sanity-checker
7. PIPELINE_LIGHT/HEAVY/SPEC: full phases, type-specific teams, checkpoint per batch
8. Report-only types (Audit, UX, Adversarial review-only): skip spec+quality review
9. STOP RULE: 2 consecutive failures = stop immediately
10. Consolidate EXECUTOR_RESULT, route to next agent
