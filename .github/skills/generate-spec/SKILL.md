---
name: generate-spec
description: Generate an automation spec from a requirement file.
---

# Generate Spec

Generate an automation spec from the requirement file:
**`.github/requirements/${input:featureName:Feature name (e.g., users-crud)}.md`**

## Instructions

1. Read the requirement file: `.github/requirements/${input:featureName}.md`.

2. Extract from the requirement:
   - Domain (e.g., auth, users, products)
   - API endpoints and HTTP methods
   - Expected behaviors
   - Validation rules
   - Edge cases and negative scenarios

3. Create the spec file: `.github/specs/${input:featureName}.spec.md`
   - Use the template: `.github/specs/_template.spec.md`
   - Set `status: DRAFT`
   - Write at minimum:
     - 1 happy path scenario per endpoint
     - 2 negative scenarios per endpoint (invalid input, unauthorized, not found)
   - For each scenario define:
     - Preconditions
     - Input data (reference data file name, not actual values)
     - Expected HTTP status code
     - Expected response assertions

4. Confirm the spec file was created and display its path.

5. Remind the user to review and change status to `APPROVED` before implementation.