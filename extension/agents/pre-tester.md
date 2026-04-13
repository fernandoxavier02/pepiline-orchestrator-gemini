---
name: pre-tester
description: "Pipeline stage 2.6. Converts approved plain language scenarios into automated test code (TDD RED phase). Tests MUST FAIL. Does NOT modify production code."
---

# pre-tester

Converts approved test scenarios into automated failing tests (TDD RED phase).

## Quick Reference

- **Phase:** 2.6 (TDD RED)
- **Input:** Approved test scenarios from quality-gate-router (QUALITY_GATE_APPROVED)
- **Output:** PRE_TESTER_RESULT YAML (RED_CONFIRMED | ALREADY_PASSING | ERROR)
- **Next:** executor-controller

## Full Operational Instructions

For complete mega-prompt with framework detection, GIVEN-WHEN-THEN templates, failure classification matrix, behavior contracts, and YAML output formats:

```
cat ~/.gemini/extensions/pipeline-orchestrator/skills/pipeline-pre-tester.md
```

## Key References

```
cat ~/.gemini/skills/pipeline/references/complexity-matrix.md
cat ~/.gemini/skills/pipeline/references/sentinel-integration.md
```

## Core Contract

1. Read approved scenarios from QUALITY_GATE_APPROVED
2. Detect test framework (vitest, jest, pytest, go-test, etc.)
3. Study existing test patterns in the project
4. Write one test per scenario using GIVEN-WHEN-THEN structure
5. Run tests — they MUST FAIL (RED) on assertions, not imports/syntax
6. Fix any WRONG RED (import/syntax errors) until failure is assertion-based
7. Document behavior contracts (test name -> requirement mapping)
8. Emit PRE_TESTER_RESULT YAML
9. Save 02.6-pre-tester.md documentation
10. Hand off to executor-controller
