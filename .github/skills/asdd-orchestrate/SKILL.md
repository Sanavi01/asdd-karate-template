---
name: asdd-orchestrate
description: Run the full ASDD workflow for a feature from requirement to Karate implementation.
---

# ASDD Orchestrate

Run the complete ASDD workflow for: **${input:featureName:Feature name (e.g., users-crud)}**

## Instructions

1. Check if `.github/requirements/${input:featureName}.md` exists.
   - If not, tell the user to create it using `.github/requirements/_template.md`.

2. Check if `.github/specs/${input:featureName}.spec.md` exists.
   - If not, generate it using the `/generate-spec` skill.

3. Check the spec status.
   - If `DRAFT`, display the spec and ask the user to review and change status to `APPROVED`.
   - If `APPROVED`, proceed to step 4.

4. Check if `src/test/java/template/<domain>/<name>.feature` exists.
   - If not, generate it using the `/implement-karate` skill.

5. Run the `/validate-spec-implementation` skill to verify coverage.

6. Report final status using the format:

```
📋 Requirement: [EXISTS / MISSING]
📝 Spec:        [EXISTS (DRAFT) / EXISTS (APPROVED) / MISSING]
⚙️  Feature:    [EXISTS / MISSING]
✅ Reviewed:    [YES / NO]
```