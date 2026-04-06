# Karate Conventions

## Project Structure

```
src/test/
├── java/
│   ├── karate-config.js              ← Environment config (REQUIRED)
│   ├── logback-test.xml              ← Logging config
│   └── template/
│       ├── RunAllTests.java          ← Master runner
│       ├── auth/
│       │   ├── AuthRunner.java       ← Domain runner
│       │   └── login.feature         ← Feature file
│       ├── users/
│       │   ├── UsersRunner.java
│       │   └── users-crud.feature
│       └── products/
│           ├── ProductsRunner.java
│           └── products.feature
└── resources/
    ├── data/
    │   ├── auth/                     ← Auth request payloads
    │   ├── users/                    ← User request payloads
    │   └── products/                 ← Product request payloads
    ├── helpers/
    │   ├── common.js                 ← Shared utilities
    │   └── auth/
    │       └── get-token.feature     ← Reusable auth helper
    └── schemas/
        ├── auth/                     ← Auth response schemas
        ├── users/                    ← User response schemas
        └── products/                 ← Product response schemas
```

---

## Naming Conventions

### Domains
- Lowercase, singular noun: `auth`, `users`, `products`, `orders`
- Maps to Java package, directory name, and tag

### Feature Files
- Kebab-case: `users-crud.feature`, `login.feature`, `product-search.feature`
- Located in: `src/test/java/template/<domain>/`

### Runner Classes
- PascalCase + `Runner` suffix: `AuthRunner`, `UsersRunner`, `ProductsRunner`
- Package: `template.<domain>`

### Data Files
- Kebab-case + purpose suffix: `create-user-request.json`, `login-valid-credentials.json`
- Located in: `src/test/resources/data/<domain>/`

### Schema Files
- Kebab-case + `.schema.json`: `user-detail-response.schema.json`, `product.schema.json`
- Located in: `src/test/resources/schemas/<domain>/`

---

## Tags

Every scenario must have at least one domain tag and one type tag:

| Tag | Usage |
|-----|-------|
| `@smoke` | Critical path, fast tests. Run in CI on every commit |
| `@regression` | Full regression coverage. Run nightly or pre-release |
| `@negative` | Error and edge case scenarios |
| `@contract` | Schema/contract validation tests |
| `@wip` | Work in progress — excluded from CI by default |
| `@auth` | Authentication domain |
| `@users` | Users domain |
| `@products` | Products domain |

### Tag Combinations
```gherkin
@smoke @auth          ← Smoke test for auth
@negative @users      ← Negative test for users
@contract @products   ← Contract test for products
@wip @users           ← WIP — not run in CI
```

### Running by Tag
```bash
mvn test -Dkarate.options="--tags @smoke"
mvn test -Dkarate.options="--tags @regression and not @wip"
mvn test -Dkarate.options="--tags @auth"
```

---

## Feature File Structure

```gherkin
Feature: <Domain> - <Description>

  Background:
    * url baseUrl
    # Common setup for all scenarios

  @smoke @<domain>
  Scenario: <Descriptive scenario name>
    Given path '<endpoint>'
    And request read('classpath:data/<domain>/<name>.json')
    When method post
    Then status 200
    And match response.<field> == <expected>
    And match response == read('classpath:schemas/<domain>/<name>.schema.json')
```

### Key Rules
1. Always use `* url baseUrl` in Background (never hardcode URLs)
2. Use `read('classpath:...')` for request bodies and schema validation
3. Every scenario must have at least one `match` or `assert` statement
4. Tag every scenario

---

## Runner Class Structure

```java
package template.<domain>;

import com.intuit.karate.junit5.Karate;

class <Domain>Runner {

    @Karate.Test
    Karate test<Domain>() {
        return Karate.run("<feature-name>").relativeTo(getClass());
    }
}
```

### To run multiple features:
```java
@Karate.Test
Karate testAll() {
    return Karate.run(getClass());  // runs all .feature files in the same directory
}
```

---

## karate-config.js

The `karate-config.js` file is the central configuration point:

```javascript
function fn() {
  var env = karate.env || 'qa';

  var config = {
    env: env,
    baseUrl: 'https://api.example.com'
  };

  if (env === 'local') {
    config.baseUrl = 'http://localhost:8080';
  }

  // Add shared variables here:
  // config.apiKey = 'test-key';
  // config.timeout = 5000;

  return config;
}
```

All variables returned from `karate-config.js` are available in every feature file automatically.

---

## Schema Validation (Karate Fuzzy Matching)

Karate uses its own schema matching syntax — not JSON Schema:

```json
{
  "id": "#number",
  "name": "#string",
  "active": "#boolean",
  "score": "#? _ >= 0",
  "email": "#regex .+@.+\\..+",
  "tags": "#[] #string",
  "address": "##string"
}
```

| Marker | Meaning |
|--------|---------|
| `#string` | Any string |
| `#number` | Any number |
| `#boolean` | Any boolean |
| `#array` | Any array |
| `#object` | Any object |
| `##string` | Optional string (can be null) |
| `#? _ > 0` | Custom JS predicate |
| `#[] #string` | Array of strings |
| `#regex <pattern>` | Regex match |

---

## Data Files

Request payloads go in `src/test/resources/data/<domain>/`.

### Usage in feature files:
```gherkin
# Load entire file as request body
And request read('classpath:data/users/create-user-request.json')

# Load file and modify a field
And def payload = read('classpath:data/users/create-user-request.json')
And set payload.email = uniqueEmail
And request payload

# Use form fields (for form-encoded requests)
And def payload = read('classpath:data/users/create-user-request.json')
And form fields payload
```

---

## Helper Features

Reusable scenarios go in `src/test/resources/helpers/`.

### Calling a helper:
```gherkin
# Call and capture output
* def authResult = call read('classpath:helpers/auth/get-token.feature') { email: 'user@test.com', password: 'pass' }
* def token = authResult.token

# Use the token
* header Authorization = 'Bearer ' + token
```

### Calling common.js utilities:
```gherkin
* def common = read('classpath:helpers/common.js')
* def randomEmail = call read('classpath:helpers/common.js') randomEmail
```

---

## Environments

| Environment | Command | Use Case |
|-------------|---------|----------|
| `qa` (default) | `mvn test` | Regular development |
| `local` | `mvn test -Dkarate.env=local` | Local server |
| `staging` | `mvn test -Dkarate.env=staging` | Pre-production |
| `prod` | `mvn test -Dkarate.env=prod` | Read-only prod checks |

---

## Adding a New Domain

1. Create the directory: `src/test/java/template/<domain>/`
2. Create the runner: `<Domain>Runner.java`
3. Create the feature: `<name>.feature`
4. Create data directory: `src/test/resources/data/<domain>/`
5. Create schema directory: `src/test/resources/schemas/<domain>/`
6. Add data files and schema files as needed
7. Create requirement: `.github/requirements/<name>.md`
8. Generate spec: `/generate-spec <name>`
9. Approve spec and implement: `/implement-karate <name>`
