# Spec: <feature-name>

status: DRAFT

## Summary
<!-- One-paragraph description of what is being tested and why. -->

## Domain
<!-- e.g., auth, users, products -->

## Scope
<!-- What is included and excluded from this test spec. -->
**In scope:**
- ...

**Out of scope:**
- ...

## Scenarios

### Scenario 1: <Scenario Name>
| Field | Value |
|-------|-------|
| Method | `GET / POST / PUT / DELETE / PATCH` |
| Endpoint | `/path` |
| Preconditions | List of required preconditions |
| Input | Data file: `data/<domain>/<file>.json` |
| Expected Status | `200` |
| Response Assertions | `responseCode == 200`, `response.field != null` |
| Tags | `@smoke @<domain>` |

### Scenario 2: <Scenario Name>
| Field | Value |
|-------|-------|
| Method | |
| Endpoint | |
| Preconditions | |
| Input | |
| Expected Status | |
| Response Assertions | |
| Tags | |

<!-- Add more scenarios as needed -->

## Data Requirements
<!-- List all data files that need to be created for this spec -->
- `data/<domain>/<name>-request.json` — Description

## Schema Requirements
<!-- List response schemas to be validated -->
- `schemas/<domain>/<name>.schema.json` — Description

## Helper Requirements
<!-- List any shared helpers needed -->
- `helpers/auth/get-token.feature` — Get auth token if needed

## Risks
<!-- Any known risks, dependencies, or concerns -->
- ...

## Approval Criteria
<!-- What must be true for this spec to be APPROVED -->
- [ ] All happy path scenarios are defined
- [ ] At least 2 negative scenarios per endpoint
- [ ] Data requirements are documented
- [ ] Schema requirements are documented
- [ ] Domain is identified
