# Skills Guide

## What Are Skills?

Skills are reusable, parameterized prompts stored as `.prompt.md` files in `.github/prompts/`. They represent the "commands" you use to interact with the ASDD system.

In GitHub Copilot, skills are available as slash commands in the chat panel.

---

## Available Skills

### `/asdd-orchestrate`
**File:** `.github/prompts/asdd-orchestrate.prompt.md`  
**Purpose:** Run the full ASDD workflow for a feature from start to finish

**When to use:** When starting a new feature from scratch, or to check the status of an existing one.

**What it does:**
1. Checks if a requirement file exists
2. Generates spec if missing
3. Reports if spec needs approval
4. Triggers implementation if spec is approved
5. Runs validation after implementation
6. Reports final status

**Example:**
```
/asdd-orchestrate users-crud
```

---

### `/generate-spec`
**File:** `.github/prompts/generate-spec.prompt.md`  
**Purpose:** Convert a requirement file into an automation spec

**When to use:** When you have a requirement file and want to generate the spec without running the full orchestration.

**Input:** Feature name (maps to `.github/requirements/<name>.md`)  
**Output:** `.github/specs/<name>.spec.md` with `status: DRAFT`

**Example:**
```
/generate-spec users-crud
```

---

### `/implement-karate`
**File:** `.github/prompts/implement-karate.prompt.md`  
**Purpose:** Implement Karate tests from an APPROVED spec

**When to use:** When the spec is already approved and you're ready to generate the Karate code.

**Pre-condition:** Spec must have `status: APPROVED`  
**Input:** Feature name (maps to `.github/specs/<name>.spec.md`)  
**Output:** Feature file, Runner, Data files, Schema files

**Example:**
```
/implement-karate users-crud
```

---

### `/validate-spec-implementation`
**File:** `.github/prompts/validate-spec-implementation.prompt.md`  
**Purpose:** Compare the spec against the Karate implementation to find gaps

**When to use:** After implementation is complete, to verify quality and coverage.

**Input:** Feature name  
**Output:** Validation report with coverage table and issues list

**Example:**
```
/validate-spec-implementation users-crud
```

---

## Adding New Skills

To add a new skill:

1. Create `.github/prompts/<skill-name>.prompt.md`
2. Add the following frontmatter:
   ```yaml
   ---
   mode: agent
   description: <One-line description>
   ---
   ```
3. Write the instructions using `${input:<name>:<description>}` for parameters
4. Reference the skill in the appropriate agent instruction files

---

## Skill Parameters

Skills can accept input using the `${input:name:description}` syntax:

```markdown
Generate spec for: **${input:featureName:Feature name (e.g., users-crud)}**
```

When the skill is invoked in Copilot, the user is prompted to provide the value.

---

## Skill vs Agent Interaction

| | Skill (Prompt) | Agent (Instruction) |
|--|---------------|---------------------|
| **File location** | `.github/prompts/` | `.github/instructions/` |
| **File format** | `*.prompt.md` | `*.instructions.md` |
| **Invocation** | `/skill-name` | Referenced in context |
| **Purpose** | Parameterized tasks | Behavioral guidelines |
| **Reusability** | High (parameterized) | Contextual |
