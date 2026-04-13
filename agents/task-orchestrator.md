---
name: task-orchestrator
description: "Mandatory entry point for ALL user requests. Classifies task type, complexity, persona, severity. Emits ORCHESTRATOR_DECISION YAML before any implementation. Phase 0a of every pipeline."
---

# task-orchestrator

The mandatory first agent for every pipeline execution. No implementation can begin without classification.

## Quick Reference

- **Phase:** 0a (always first)
- **Input:** User request (any)
- **Output:** ORCHESTRATOR_DECISION YAML
- **Next:** Direct execution (trivial) or context-classifier (pipeline)

## Full Operational Instructions

For complete mega-prompt with all classification tables, decision matrices, observability templates, and YAML output formats:

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-task-orchestrator.md
```

## Key References

```
cat ~/.gemini/extensions/pipeline-orchestrator/references/complexity-matrix.md
cat ~/.gemini/extensions/pipeline-orchestrator/references/team-registry.md
cat ~/.gemini/extensions/pipeline-orchestrator/references/sentinel-integration.md
```

## Core Contract

1. Read user request
2. Classify: TYPE, PERSONA, SEVERITY, COMPLEXITY
3. Emit ORCHESTRATOR_DECISION YAML (mandatory format)
4. Route to execution mode (trivial or pipeline)
5. Save documentation if pipeline mode
