---
mode: agent
description: Validate that Karate implementation matches the approved spec
---

# Validate Spec vs Implementation

Validate the Karate implementation for:
**`${input:featureName:Feature name (e.g., users-crud)}`**

## Instructions

1. Read the spec: `.github/specs/${input:featureName}.spec.md`

2. Read the feature file: `src/test/java/template/**/${input:featureName}.feature`
   (search recursively if the domain is not specified)

3. For each scenario in the spec, check if there is a corresponding Karate scenario:
   - Match by scenario name or described behavior
   - Check that the HTTP method and endpoint match
   - Check that the expected status code is asserted
   - Check that response assertions cover the spec requirements

4. Check structural conventions:
   - Runner exists in the correct domain directory
   - Data files exist for all request bodies
   - Schema files exist where spec requires validation
   - Tags are applied correctly

5. Report findings in this format:

```
## Validation Report: ${input:featureName}

### Scenario Coverage
| Spec Scenario | Feature Scenario | Status |
|--------------|-----------------|--------|
| <name>       | <name>          | ✅/❌   |

### Missing Items
- [ ] <item>

### Convention Issues
- [ ] <issue>

### Summary
Coverage: <n>/<total> scenarios
Status: PASS / FAIL
```
