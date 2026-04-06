---
mode: agent
description: Implement Karate tests from an APPROVED spec file
---

# Implement Karate

Implement Karate API tests from the approved spec:
**`.github/specs/${input:featureName:Feature name (e.g., users-crud)}.spec.md`**

## Instructions

1. Read the spec file: `.github/specs/${input:featureName}.spec.md`

2. **STOP if status is `DRAFT`** — tell the user to approve the spec first

3. Extract from the spec:
   - Domain name
   - All scenarios with their endpoints, methods, inputs, and assertions
   - Required data files
   - Required schema files

4. Create the feature file:
   - Path: `src/test/java/template/<domain>/${input:featureName}.feature`
   - Include Background with `* url baseUrl`
   - One Scenario per spec scenario
   - Apply correct tags
   - Use `read('classpath:data/<domain>/...')` for request bodies
   - Use `match response == read('classpath:schemas/<domain>/...')` for schema validation

5. Create or update the Runner:
   - Path: `src/test/java/template/<domain>/<Domain>Runner.java`
   - If runner already exists, verify it includes the new feature

6. Create data files for each request payload:
   - Path: `src/test/resources/data/<domain>/<name>.json`

7. Create schema files for response validation:
   - Path: `src/test/resources/schemas/<domain>/<name>.schema.json`
   - Use `#string`, `#number`, `#boolean` Karate schema markers

8. Confirm all created files and their paths
