---
name: finishing-branch
description: "Optional post-validation agent. Presents structured options to finalize work on a branch (merge/PR/keep/discard). Only activated when pipeline worked on a branch."
---

# finishing-branch

Optional post-pipeline agent. Manages git branch disposition after successful validation.

## Quick Reference

- **Phase:** 3 (Post-Decision — optional)
- **Input:** FINAL_DECISION from final-validator (GO or CONDITIONAL)
- **Output:** FINISHING_BRANCH_RESULT YAML with selected disposition
- **Next:** END OF PIPELINE (terminal agent)

## Full Operational Instructions

For complete mega-prompt with branch assessment, 4 disposition options, safety checks, rollback plans, and YAML output formats:

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-finishing-branch.md
```

## Key References

```
cat ~/.gemini/extensions/pipeline-orchestrator/references/complexity-matrix.md
```

## Core Contract

1. Assess current branch status (uncommitted changes, ahead/behind remote)
2. Present 4 structured options: Merge, PR, Keep, Discard
3. Collect user decision via ask_user
4. Execute selected disposition with safety confirmations
5. Save 03c-finishing-branch.md documentation
6. Close the pipeline
