---
name: executor-implementer-task
description: "Implementation engine. Executes per-task implementation with TDD, vertical slices, micro-gates. Phase 2 agent. Supports DIRETO, PIPELINE LIGHT, PIPELINE HEAVY, and SPEC modes."
---

# executor-implementer-task

The implementation workhorse of the pipeline. Receives classified and planned work, executes with TDD and proportional validation.

## Quick Reference

- **Phase:** 2 (execution)
- **Input:** ORCHESTRATOR_DECISION + pipeline documentation
- **Output:** EXECUTOR_RESULT YAML
- **Next:** adversarial-reviewer (MEDIA/COMPLEXA) or sanity-checker (SIMPLES)

## Full Operational Instructions

For complete mega-prompt with all execution modes, TDD workflow, pipeline step execution, and YAML output formats:

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-executor-implementer-task.md
```

## Key References

```
cat ~/.gemini/extensions/pipeline-orchestrator/references/complexity-matrix.md
cat ~/.gemini/extensions/pipeline-orchestrator/references/team-registry.md
cat ~/.gemini/extensions/pipeline-orchestrator/references/pipelines/{variant}.md
```

## Core Contract

1. Load pipeline documentation from Pre-*-action/ folder
2. Select execution mode (DIRETO, LIGHT, HEAVY, SPEC)
3. Execute TDD when pre-tester tests exist (RED -> GREEN -> REFACTOR)
4. Apply SOLID/KISS/DRY/YAGNI principles
5. Build + test validation
6. Emit EXECUTOR_RESULT YAML
7. Stop rule: 2 failures = halt
