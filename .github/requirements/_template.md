# Requirement: <feature-name>

## Objective
<!-- Describe what this API feature should prove/test. Be specific about the business intent. -->

## Domain
<!-- e.g., auth, users, products, orders -->

## API Base URL
<!-- e.g., https://api.example.com/v1 -->
<!-- If using an env-specific URL, describe each environment -->

## Endpoints to Test
<!-- List all endpoints this feature should cover -->
- `<METHOD> /path` — Description
- `<METHOD> /path/{id}` — Description

## Authentication
<!-- Describe auth requirements: None / API Key / Bearer Token / Basic Auth -->
<!-- Specify how credentials are obtained for testing -->

## Expected Behavior (Happy Path)
<!-- Describe what correct behavior looks like -->
- When ...
- Then ...

## Validation Rules
<!-- What specific fields, types, or values should be validated? -->
- Response must contain ...
- Status code must be ...
- Field `<name>` must be of type ...

## Test Data Requirements
<!-- What data is needed? Who creates it? Any preconditions in the system? -->
- Need existing user with ID ...
- Need valid auth token ...

## Edge Cases & Negative Scenarios
<!-- Describe known error conditions to test -->
- Missing required fields → expect 400
- Invalid credentials → expect 401
- Resource not found → expect 404

## Notes
<!-- Additional context, constraints, or links to API docs -->
- API docs: <url>
- Rate limiting: ...
- Known issues: ...
