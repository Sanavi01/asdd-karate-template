# ASDD Karate Template

A complete, reusable template for API test automation using [Karate](https://karatelabs.github.io/karate/) with the ASDD (Agent-Spec-Driven Development) workflow powered by GitHub Copilot.

---

## What Is This?

This template gives you:

- ✅ A **complete Karate project scaffold** ready to run
- ✅ An **ASDD workflow** connecting requirements → specs → implementation
- ✅ **4 AI agents** with defined roles and instructions
- ✅ **4 skills (prompts)** for driving the workflow with Copilot
- ✅ **Domain-based organization** for features, runners, data, and schemas
- ✅ **Example tests** against a real public API
- ✅ **Documentation** explaining every concept

---

## Quick Start

### Prerequisites
- Java 17+
- Maven 3.8+ (or use the included `mvnw` wrapper)
- Git
- GitHub Copilot (for agent-driven workflow)

### Run the Example Tests

```bash
# Clone this template
git clone https://github.com/Sanavi01/asdd-karate-template.git
cd asdd-karate-template

# Run all tests
./mvnw test

# Run only smoke tests
./mvnw test -Dkarate.options="--tags @smoke"

# Run a specific domain
./mvnw test -Dtest="template.users.UsersRunner"

# Run against a specific environment
./mvnw test -Dkarate.env=staging
```

Test reports are generated at: `target/karate-reports/`

---

## Repository Structure

```
asdd-karate-template/
│
├── 📋 .github/
│   ├── copilot-instructions.md          ← Main Copilot context (read first)
│   ├── instructions/                    ← Agent behavior definitions
│   │   ├── asdd.instructions.md         ← ASDD workflow rules
│   │   ├── orchestrator.instructions.md ← @Orchestrator agent
│   │   ├── spec-generator.instructions.md ← @SpecGenerator agent
│   │   ├── karate-engineer.instructions.md ← @KarateEngineer agent
│   │   └── reviewer.instructions.md    ← @Reviewer agent
│   ├── prompts/                         ← Skills (slash commands)
│   │   ├── asdd-orchestrate.prompt.md   ← Run full ASDD workflow
│   │   ├── generate-spec.prompt.md      ← Generate spec from requirement
│   │   ├── implement-karate.prompt.md   ← Implement Karate from spec
│   │   └── validate-spec-implementation.prompt.md ← Validate implementation
│   ├── requirements/                    ← Feature requirements (your input)
│   │   ├── _template.md                 ← Requirement template
│   │   └── example-users-crud.md        ← Example requirement
│   └── specs/                           ← Feature specs (generated)
│       ├── _template.spec.md            ← Spec template
│       └── example-users-crud.spec.md   ← Example spec (APPROVED)
│
├── 📚 docs/
│   ├── asdd-workflow.md                 ← Full workflow explanation
│   ├── agent-interaction.md             ← How agents work together
│   ├── skills-guide.md                  ← How to use skills
│   └── karate-conventions.md            ← Naming, tags, structure rules
│
├── ☕ src/test/java/
│   ├── karate-config.js                 ← Environment config (baseUrl, etc.)
│   ├── logback-test.xml                 ← Logging config
│   └── template/
│       ├── RunAllTests.java             ← Master runner
│       ├── auth/
│       │   ├── AuthRunner.java          ← Auth domain runner
│       │   └── login.feature            ← Auth feature file
│       ├── users/
│       │   ├── UsersRunner.java         ← Users domain runner
│       │   └── users-crud.feature       ← Users CRUD feature file
│       └── products/
│           ├── ProductsRunner.java      ← Products domain runner
│           └── products.feature         ← Products feature file
│
└── 📁 src/test/resources/
    ├── data/                            ← JSON request payloads
    │   ├── auth/login-valid-credentials.json
    │   ├── users/create-user-request.json
    │   ├── users/update-user-request.json
    │   └── products/products-search-params.json
    ├── helpers/                         ← Reusable JS utilities and features
    │   ├── common.js                    ← randomEmail(), randomString(), etc.
    │   └── auth/get-token.feature       ← Reusable auth token helper
    └── schemas/                         ← JSON response schemas (Karate format)
        ├── auth/login-response.schema.json
        ├── users/user-detail-response.schema.json
        ├── users/user-response.schema.json
        └── products/product.schema.json
```

---

## ASDD Workflow

The core philosophy: **No Karate code without an approved spec.**

```
Requirement → Spec (DRAFT) → [Human Approval] → Karate Implementation → Validation
```

### The Four Phases

| Phase | Who | Input | Output |
|-------|-----|-------|--------|
| 1. Requirement | Human | — | `.github/requirements/<name>.md` |
| 2. Spec | @SpecGenerator | Requirement | `.github/specs/<name>.spec.md` (DRAFT) |
| 3. Approval | Human | Spec | Spec with `status: APPROVED` |
| 4. Implementation | @KarateEngineer | Approved Spec | Feature + Runner + Data + Schemas |
| 5. Validation | @Reviewer | Spec + Feature | Review report |

---

## Starting a New Project with This Template

### Step 1: Use this template

Click **"Use this template"** on GitHub, or:

```bash
git clone https://github.com/Sanavi01/asdd-karate-template.git my-api-tests
cd my-api-tests
```

### Step 2: Configure your environment

Edit `src/test/java/karate-config.js`:

```javascript
function fn() {
  var env = karate.env || 'qa';
  var config = {
    baseUrl: 'https://your-api.com/v1'  // ← Change this
  };
  return config;
}
```

### Step 3: Write your first requirement

```bash
cp .github/requirements/_template.md .github/requirements/my-feature.md
# Edit the file with your feature details
```

### Step 4: Use Copilot to generate the spec

In GitHub Copilot Chat:
```
/generate-spec my-feature
```

### Step 5: Review and approve the spec

Open `.github/specs/my-feature.spec.md` and change:
```
status: DRAFT
```
to:
```
status: APPROVED
```

### Step 6: Implement with Copilot

```
/implement-karate my-feature
```

### Step 7: Run your tests

```bash
./mvnw test -Dtest="template.<domain>.<Domain>Runner"
```

---

## AI Agents

This template includes 4 AI agents configured via `.github/instructions/`:

### 🎯 @Orchestrator
Coordinates the full workflow. Tell it to "start ASDD for my-feature" and it handles the rest.

### 📝 @SpecGenerator
Transforms requirement files into detailed automation specs. Never writes Karate code.

### ⚙️ @KarateEngineer
Implements Karate tests from APPROVED specs only. Creates features, runners, data files, and schemas.

### 🔍 @Reviewer
Validates that implementations match their specs. Reports gaps without rewriting code.

> 📖 See [docs/agent-interaction.md](docs/agent-interaction.md) for the full interaction model.

---

## Skills (Slash Commands)

| Skill | Purpose |
|-------|---------|
| `/asdd-orchestrate` | Run the full workflow end-to-end |
| `/generate-spec` | Generate a spec from a requirement |
| `/implement-karate` | Implement Karate from an approved spec |
| `/validate-spec-implementation` | Check implementation vs spec |

> 📖 See [docs/skills-guide.md](docs/skills-guide.md) for detailed usage.

---

## Running Tests

### All Tests
```bash
./mvnw test
```

### By Domain
```bash
./mvnw test -Dtest="template.auth.AuthRunner"
./mvnw test -Dtest="template.users.UsersRunner"
./mvnw test -Dtest="template.products.ProductsRunner"
```

### By Tag
```bash
./mvnw test -Dkarate.options="--tags @smoke"
./mvnw test -Dkarate.options="--tags @regression"
./mvnw test -Dkarate.options="--tags @smoke and not @wip"
```

### By Environment
```bash
./mvnw test -Dkarate.env=local
./mvnw test -Dkarate.env=qa
./mvnw test -Dkarate.env=staging
```

---

## Example: The Users CRUD Flow

This template includes a complete working example using the [Automation Exercise API](https://automationexercise.com/api_list):

| File | Description |
|------|-------------|
| `.github/requirements/example-users-crud.md` | The requirement |
| `.github/specs/example-users-crud.spec.md` | The APPROVED spec |
| `src/test/java/template/users/users-crud.feature` | The Karate tests |
| `src/test/resources/data/users/create-user-request.json` | Create payload |
| `src/test/resources/schemas/users/user-detail-response.schema.json` | Response schema |

Run just this example:
```bash
./mvnw test -Dtest="template.users.UsersRunner"
```

---

## Karate Key Concepts

### Feature File Anatomy
```gherkin
Feature: Domain - Description

  Background:          ← Runs before every scenario
    * url baseUrl      ← Never hardcode URLs

  @smoke @domain       ← Always tag scenarios
  Scenario: Name
    Given path 'endpoint'
    And request read('classpath:data/domain/file.json')
    When method post
    Then status 200
    And match response.field == 'value'
    And match response == read('classpath:schemas/domain/schema.json')
```

### Schema Validation
```json
{
  "id": "#number",
  "name": "#string",
  "email": "#regex .+@.+\\..+",
  "score": "##number",
  "tags": "#[] #string"
}
```

### Key Karate Syntax
| Syntax | Purpose |
|--------|---------|
| `* url baseUrl` | Set base URL |
| `Given path 'users'` | Append to URL |
| `And param key = 'value'` | Query parameter |
| `And header Auth = token` | Request header |
| `And request payload` | Set request body |
| `And form fields payload` | Form-encoded body |
| `When method get` | Execute HTTP method |
| `Then status 200` | Assert status code |
| `And match response.x == 'y'` | Assert field value |
| `And def x = response.field` | Extract to variable |
| `* def result = call read('...')` | Call helper feature |

---

## Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Domain | lowercase | `users`, `auth` |
| Runner | PascalCase + `Runner` | `UsersRunner` |
| Feature | kebab-case | `users-crud.feature` |
| Data file | kebab-case + purpose | `create-user-request.json` |
| Schema | kebab-case + `.schema.json` | `user.schema.json` |
| Spec | kebab-case + `.spec.md` | `users-crud.spec.md` |
| Requirement | kebab-case + `.md` | `users-crud.md` |

---

## Documentation

| Doc | Description |
|-----|-------------|
| [docs/asdd-workflow.md](docs/asdd-workflow.md) | Full ASDD workflow with diagrams |
| [docs/agent-interaction.md](docs/agent-interaction.md) | How the 4 agents interact |
| [docs/skills-guide.md](docs/skills-guide.md) | How to use skills/prompts |
| [docs/karate-conventions.md](docs/karate-conventions.md) | Naming, tags, structure |
| [.github/copilot-instructions.md](.github/copilot-instructions.md) | Main Copilot context |

---

## Tech Stack

| Technology | Version | Purpose |
|-----------|---------|---------|
| Java | 17+ | Runtime |
| Karate | 1.5.2 | API testing DSL |
| JUnit 5 | 5.10.2 | Test runner |
| Maven | 3.9.x | Build tool |
| Logback | 1.4.x | Logging |

---

## License

This template is provided as-is for educational and project starter purposes.