# ASDD Workflow Guide

## Overview

ASDD (Agent-Spec-Driven Development) is a structured process for building API test automation with traceability and consistency. It uses AI agents and defined skills to move from business requirement to tested automation.

## The Four Phases

```
Requirement → Spec (DRAFT) → Approval → Karate Implementation → Validation
```

---

## Phase 1: Requirement

**Who:** Human (QA engineer, product owner, developer)  
**Output:** `.github/requirements/<feature-name>.md`  
**Template:** `.github/requirements/_template.md`

The requirement describes:
- What API behavior needs to be tested
- Which endpoints are in scope
- What the expected behavior is
- What edge cases exist
- Authentication requirements

### Example
```
.github/requirements/users-crud.md
```

---

## Phase 2: Spec Generation

**Who:** `@SpecGenerator` agent (or human)  
**Input:** Requirement file  
**Output:** `.github/specs/<feature-name>.spec.md` with `status: DRAFT`  
**Skill:** `/generate-spec`

The spec defines:
- Concrete test scenarios (one per behavior)
- Input data references
- Expected HTTP status codes
- Response assertions
- Schema validation requirements

### Rules
- Each spec starts with `status: DRAFT`
- No Karate code is generated at this stage
- Each scenario must have clear, testable assertions

---

## Phase 3: Approval

**Who:** Human reviewer (or `@Reviewer` agent)  
**Action:** Change `status: DRAFT` → `status: APPROVED` in the spec file

This is the **approval gate** — nothing proceeds to implementation without it.

### What to review in a spec
- Are all relevant endpoints covered?
- Are negative scenarios included?
- Are data requirements realistic?
- Are assertions specific and verifiable?

---

## Phase 4: Karate Implementation

**Who:** `@KarateEngineer` agent  
**Input:** `*.spec.md` with `status: APPROVED`  
**Output:**
- `src/test/java/template/<domain>/<name>.feature`
- `src/test/java/template/<domain>/<Domain>Runner.java`
- `src/test/resources/data/<domain>/<name>.json`
- `src/test/resources/schemas/<domain>/<name>.schema.json`

**Skill:** `/implement-karate`

### Gate Check
```
spec status == APPROVED? → YES → Implement
                         → NO  → Stop, ask user to approve
```

---

## Phase 5: Validation

**Who:** `@Reviewer` agent  
**Input:** Spec file + Feature file  
**Skill:** `/validate-spec-implementation`

Validates:
- All spec scenarios are implemented
- Assertions match spec expectations
- Conventions are followed
- No scenarios are missing

---

## Full Workflow Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                         ASDD WORKFLOW                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  👤 Human                                                            │
│  └─ Write requirement file                                           │
│     .github/requirements/<name>.md                                   │
│                                                                      │
│  🤖 @SpecGenerator (or /generate-spec skill)                        │
│  └─ Reads requirement                                                │
│  └─ Creates .github/specs/<name>.spec.md (status: DRAFT)            │
│                                                                      │
│  👤 Human Reviewer                                                   │
│  └─ Reviews spec                                                     │
│  └─ Changes status: DRAFT → status: APPROVED                        │
│                                                                      │
│  🤖 @KarateEngineer (or /implement-karate skill)                    │
│  └─ Checks spec status == APPROVED                                   │
│  └─ Creates feature file, runner, data, schemas                      │
│                                                                      │
│  🤖 @Reviewer (or /validate-spec-implementation skill)              │
│  └─ Compares spec vs implementation                                  │
│  └─ Reports gaps or issues                                           │
│                                                                      │
│  👤 Human                                                            │
│  └─ Runs tests: mvn test                                             │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Starting a New Feature

### Step 1: Create the requirement
```bash
cp .github/requirements/_template.md .github/requirements/my-feature.md
# Edit my-feature.md with the feature details
```

### Step 2: Generate the spec
In GitHub Copilot Chat:
```
@SpecGenerator generate spec for .github/requirements/my-feature.md
```
Or use the skill:
```
/generate-spec my-feature
```

### Step 3: Approve the spec
Open `.github/specs/my-feature.spec.md` and change:
```
status: DRAFT
```
to:
```
status: APPROVED
```

### Step 4: Implement
In GitHub Copilot Chat:
```
@KarateEngineer implement .github/specs/my-feature.spec.md
```
Or use the skill:
```
/implement-karate my-feature
```

### Step 5: Run the tests
```bash
# Run all tests
mvn test

# Run by domain
mvn test -Dtest="template.users.UsersRunner"

# Run by tag
mvn test -Dkarate.options="--tags @smoke"

# Run in specific environment
mvn test -Dkarate.env=staging
```
