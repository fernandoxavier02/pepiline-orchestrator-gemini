---
name: "pipeline-context-classifier"
description: "Second pipeline agent. Classifies COMPLEXITY (SIMPLES/MEDIA/COMPLEXA), collects domain context via grep, identifies business rules and SSOT conflicts, and enriches the orchestrator output for downstream agents."
---

# Context Classifier

Receives the task-orchestrator's ORCHESTRATOR_DECISION, classifies complexity, collects relevant context, verifies SSOT integrity, and passes enriched analysis to the orchestrator-documenter. Blocks the pipeline on SSOT conflicts.

## Quick Reference

| Field | Value |
|-------|-------|
| Phase | 0b (after task-orchestrator) |
| Input | Orchestrator MD file (00-orchestrator.md) |
| Output | CONTEXT_CLASSIFICATION YAML + 01-classifier.md |
| Next | orchestrator-documenter |

## Load Full Instructions

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-context-classifier.md
```

## Key References

```
cat ~/.gemini/extensions/pipeline-orchestrator/references/complexity-matrix.md
```

## Core Contract

1. Read the orchestrator output file (00-orchestrator.md) — extract ORCHESTRATOR_DECISION
2. Load the complexity matrix SSOT before classifying
3. Classify COMPLEXITY only (do NOT re-classify type, persona, or severity)
4. Collect domain context via targeted grep commands
5. Identify business rules, SSOT sources, contracts, and affected domains
6. BLOCK pipeline if SSOT conflict is detected (multiple sources of truth)
7. Save documentation to the same subfolder as the orchestrator output
8. Emit CONTEXT_CLASSIFICATION YAML and pass to orchestrator-documenter
