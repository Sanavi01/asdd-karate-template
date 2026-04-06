# Agent Interaction Model

## Overview

This template uses four AI agents that work together in a defined sequence. Each agent has a specific role, clear inputs and outputs, and boundaries that prevent overlap.

---

## Agents

### 🎯 @Orchestrator
**File:** `.github/instructions/orchestrator.instructions.md`

| Attribute | Detail |
|-----------|--------|
| Role | Workflow coordinator |
| Trigger | User starts a new feature or asks for status |
| Input | Feature name or requirement path |
| Output | Status report + delegation to correct agent |
| Boundary | Does NOT write Karate code |

**Decision logic:**
```
No requirement? → Ask user to create one
No spec? → Call @SpecGenerator
Spec is DRAFT? → Ask user to approve
Spec is APPROVED, no feature? → Call @KarateEngineer
Feature exists? → Call @Reviewer
```

**Example invocation:**
```
@Orchestrator start ASDD for users-crud
```

---

### 📝 @SpecGenerator
**File:** `.github/instructions/spec-generator.instructions.md`

| Attribute | Detail |
|-----------|--------|
| Role | Requirement → Spec translator |
| Trigger | @Orchestrator delegates, or user invokes directly |
| Input | `.github/requirements/<name>.md` |
| Output | `.github/specs/<name>.spec.md` with `status: DRAFT` |
| Boundary | Does NOT write Gherkin or Karate code |

**What it produces:**
- Identified domain
- List of concrete test scenarios
- Data file requirements
- Schema requirements
- Risk notes

**Example invocation:**
```
@SpecGenerator generate spec for .github/requirements/users-crud.md
```

---

### ⚙️ @KarateEngineer
**File:** `.github/instructions/karate-engineer.instructions.md`

| Attribute | Detail |
|-----------|--------|
| Role | Karate test implementer |
| Trigger | @Orchestrator delegates after spec is APPROVED |
| Input | `.github/specs/<name>.spec.md` (must be APPROVED) |
| Output | Feature file, Runner, Data files, Schema files |
| Boundary | Refuses to work on DRAFT specs |

**Files it creates:**
```
src/test/java/template/<domain>/<name>.feature
src/test/java/template/<domain>/<Domain>Runner.java
src/test/resources/data/<domain>/<name>.json
src/test/resources/schemas/<domain>/<name>.schema.json
```

**Example invocation:**
```
@KarateEngineer implement .github/specs/users-crud.spec.md
```

---

### 🔍 @Reviewer
**File:** `.github/instructions/reviewer.instructions.md`

| Attribute | Detail |
|-----------|--------|
| Role | Quality validator |
| Trigger | After implementation, or on-demand |
| Input | Spec file + Feature file |
| Output | Review report with gaps and issues |
| Boundary | Does NOT rewrite code — reports only |

**What it validates:**
- Coverage: all spec scenarios are implemented
- Assertions: every scenario has meaningful checks
- Conventions: naming, tags, structure
- No hardcoded URLs or credentials

**Example invocation:**
```
@Reviewer validate users-crud
```

---

## Interaction Diagram

```
User
 │
 ├─ "Start ASDD for users-crud"
 │
 ▼
@Orchestrator
 │
 ├─ [No spec] → @SpecGenerator → Creates DRAFT spec
 │
 ├─ [DRAFT spec] → "Please approve the spec" → User approves
 │
 ├─ [APPROVED spec, no feature] → @KarateEngineer → Creates feature
 │
 └─ [Feature exists] → @Reviewer → Review report
                                        │
                                        └─ Issues found → @KarateEngineer fixes
                                        └─ PASS → Done ✅
```

---

## Agent Boundaries Summary

| Agent | Can Write Specs | Can Write Karate | Can Review | Can Orchestrate |
|-------|----------------|-----------------|------------|----------------|
| @Orchestrator | No | No | No | ✅ |
| @SpecGenerator | ✅ | No | No | No |
| @KarateEngineer | No | ✅ | No | No |
| @Reviewer | No | No | ✅ | No |

---

## Using Agents in GitHub Copilot Chat

All agents are configured via `.github/instructions/` files with `applyTo` metadata. GitHub Copilot automatically respects these instructions when working on matching file paths.

To invoke a specific agent role, address it by name in chat:
```
@workspace [agent instructions apply automatically based on context]
```

Or explicitly reference the agent role:
```
Act as the Karate Engineer and implement the spec at .github/specs/users-crud.spec.md
```
