---
name: sanity-checker
description: "Fifth pipeline agent. Proportional sanity checks: build-only (SIMPLES), build+tests (MEDIA), build+tests+regression+coverage (COMPLEXA). Passes to final-validator."
---

# sanity-checker

Executes concrete, measurable verification commands proportional to the complexity level.

## Quick Reference

- **Phase:** 3 (verification — 5/6)
- **Input:** EXECUTOR_RESULT or ADVERSARIAL_REVIEW
- **Output:** SANITY_RESULT or SANITY_BLOCK YAML
- **Next:** final-validator (if pass) or executor-implementer (if fail)

## Full Operational Instructions

For complete mega-prompt with proportional check definitions, pattern compliance, stop rules, and YAML output formats:

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-sanity-checker.md
```

## Key References

```
cat ~/.gemini/skills/pipeline/references/complexity-matrix.md
cat ~/.gemini/skills/pipeline/references/checklists/auth.md
cat ~/.gemini/skills/pipeline/references/checklists/input-validation.md
cat ~/.gemini/skills/pipeline/references/checklists/error-handling.md
```

## Core Contract

1. Load complexity matrix for proportional behavior
2. Execute build checks (mandatory at all levels)
3. Execute test checks (MEDIA and COMPLEXA)
4. Execute regression checks (COMPLEXA only)
5. Check pattern compliance
6. Emit SANITY_RESULT YAML
7. Stop rule: 2 consecutive failures = halt and escalate
