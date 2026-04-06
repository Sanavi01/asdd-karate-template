# ASDD Karate Template — Copilot Instructions

You are working on an ASDD (Agent-Spec-Driven Development) Karate API testing project.

## Core Principle
**No Karate code is written without an APPROVED spec.**

The workflow is always:
```
Requirement → Spec (DRAFT) → Approval → Karate Implementation → Validation
```

## Agent Roles

### @Orchestrator
- Coordinates the full ASDD workflow
- Reads requirement files from `.github/requirements/`
- Calls the appropriate agent or skill for each phase
- Enforces the spec-approval gate before implementation
- Does NOT write Karate code directly

### @SpecGenerator
- Converts requirement files into spec files
- Creates `*.spec.md` files in `.github/specs/` with `status: DRAFT`
- Identifies domain, endpoints, scenarios, validations
- Does NOT generate Karate code

### @KarateEngineer
- Implements Karate `.feature` files from APPROVED specs only
- Creates runners, data files, schemas, and helpers as needed
- Follows domain-based organization conventions
- Respects naming and tagging conventions

### @Reviewer
- Validates that feature files match their spec
- Checks naming conventions, assertions, and structure
- Reports gaps between spec and implementation

## Project Structure
```
src/test/java/template/<domain>/      ← .feature files + Runner.java
src/test/resources/data/<domain>/     ← JSON data files
src/test/resources/helpers/           ← Shared JS helpers and reusable features
src/test/resources/schemas/<domain>/  ← JSON Schema validation files
.github/requirements/                 ← Requirement markdown files
.github/specs/                        ← Spec markdown files (DRAFT or APPROVED)
.github/instructions/                 ← Shared workspace instruction files
.github/agents/                       ← Custom agent definitions (.agent.md)
.github/skills/                       ← Slash-command skills (SKILL.md folders)
docs/                                 ← Documentation
```

## Naming Conventions
- Domain names: lowercase (e.g., `auth`, `users`, `products`)
- Runner classes: PascalCase + `Runner` suffix (e.g., `AuthRunner`, `UsersRunner`)
- Feature files: kebab-case (e.g., `login.feature`, `users-crud.feature`)
- Data files: kebab-case + purpose (e.g., `create-user-request.json`)
- Schema files: kebab-case + `.schema.json` (e.g., `user.schema.json`)

## Karate Tags
- `@smoke` — Critical path, fast smoke tests
- `@regression` — Full regression coverage
- `@negative` — Negative/error scenarios
- `@auth` — Authentication-related
- `@contract` — Schema/contract validation
- `@wip` — Work in progress (excluded from CI by default)

## Environments
Configured in `src/test/java/karate-config.js`:
- `local` — Local development server
- `qa` — QA/staging environment (default)
- `prod` — Production (read-only tests only)

Run with: `mvn test -Dkarate.env=qa`

## Spec States
- `DRAFT` — Under review, NOT ready for implementation
- `APPROVED` — Reviewed and approved, ready for implementation

## Rules
1. Always check spec status before implementing
2. Use `baseUrl` from `karate-config.js` — never hardcode URLs
3. Use data files for request payloads, not inline JSON in features
4. Validate responses with schema files where possible
5. Every scenario must have at least one meaningful assertion
6. Keep auth/token logic in `helpers/auth/`
