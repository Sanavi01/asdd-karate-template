---
applyTo: "**"
---

# ASDD Workflow Instructions

## What is ASDD?

ASDD (Agent-Spec-Driven Development) is a structured workflow for building API test automation where every test is traceable to an approved specification.

## The Golden Rule
> **No Karate implementation without an APPROVED spec.**

## Workflow Phases

### Phase 1: Requirement
A human writes a requirement file describing what needs to be tested:
- Location: `.github/requirements/<feature-name>.md`
- Use the template: `.github/requirements/_template.md`

### Phase 2: Spec Generation
The `@SpecGenerator` agent reads the requirement and produces a spec:
- Location: `.github/specs/<feature-name>.spec.md`
- Initial status: `DRAFT`
- Use the template: `.github/specs/_template.spec.md`

### Phase 3: Approval
A human (or reviewer agent) reviews the spec and changes status:
```
status: DRAFT → status: APPROVED
```
Nothing proceeds until this happens.

### Phase 4: Karate Implementation
The `@KarateEngineer` agent implements the tests from the APPROVED spec:
- Feature file: `src/test/java/template/<domain>/<name>.feature`
- Runner: `src/test/java/template/<domain>/<Domain>Runner.java`
- Data: `src/test/resources/data/<domain>/<name>.json`
- Schema: `src/test/resources/schemas/<domain>/<name>.schema.json`

### Phase 5: Validation
The `@Reviewer` agent validates the implementation against the spec.

## Traceability Matrix
Each requirement maps to:
- 1 spec file
- 1 or more feature files
- N scenarios (one per behavior)

## Key Files
| File | Purpose |
|------|---------|
| `.github/requirements/_template.md` | Start here for new features |
| `.github/specs/_template.spec.md` | Spec structure |
| `src/test/java/karate-config.js` | Environment config |
| `src/test/resources/helpers/common.js` | Shared utilities |
