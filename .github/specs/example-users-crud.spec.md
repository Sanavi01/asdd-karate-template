# Spec: Users CRUD

status: APPROVED

## Summary
This spec covers the full CRUD lifecycle for the Users API at `automationexercise.com`. It validates user creation, retrieval by email, account update, and account deletion — including happy path and negative scenarios.

## Domain
users

## Scope
**In scope:**
- Create new user account (`POST /createAccount`)
- Get user by email (`GET /getUserDetailByEmail`)
- Update user account (`PUT /updateAccount`)
- Delete user account (`DELETE /deleteAccount`)

**Out of scope:**
- Admin operations
- Password reset flow
- Social login

---

## Scenarios

### Scenario 1: Successful user creation
| Field | Value |
|-------|-------|
| Method | `POST` |
| Endpoint | `/createAccount` |
| Preconditions | Email must not be registered |
| Input | Data file: `data/users/create-user-request.json` |
| Expected Status | `200` |
| Response Assertions | `response.responseCode == 201`, `response.message == 'User created!'` |
| Tags | `@smoke @users` |

### Scenario 2: Create user with already registered email
| Field | Value |
|-------|-------|
| Method | `POST` |
| Endpoint | `/createAccount` |
| Preconditions | Email already exists in the system |
| Input | Existing user's email in form params |
| Expected Status | `200` |
| Response Assertions | `response.responseCode == 400`, `response.message == 'Email already exists!'` |
| Tags | `@negative @users` |

### Scenario 3: Get user details by email
| Field | Value |
|-------|-------|
| Method | `GET` |
| Endpoint | `/getUserDetailByEmail` |
| Preconditions | User must exist with the given email |
| Input | Query param: `email=<user-email>` |
| Expected Status | `200` |
| Response Assertions | `response.responseCode == 200`, `response.user != null`, `response.user.email == <user-email>` |
| Tags | `@smoke @users` |

### Scenario 4: Get user details for non-existent email
| Field | Value |
|-------|-------|
| Method | `GET` |
| Endpoint | `/getUserDetailByEmail` |
| Preconditions | Email not registered |
| Input | Non-existent email as query param |
| Expected Status | `200` |
| Response Assertions | `response.responseCode == 404`, `response.message == 'Account not found!'` |
| Tags | `@negative @users` |

### Scenario 5: Successful account update
| Field | Value |
|-------|-------|
| Method | `PUT` |
| Endpoint | `/updateAccount` |
| Preconditions | User must exist with valid credentials |
| Input | Data file: `data/users/update-user-request.json` (includes email + password) |
| Expected Status | `200` |
| Response Assertions | `response.responseCode == 200`, `response.message == 'User updated!'` |
| Tags | `@regression @users` |

### Scenario 6: Successful account deletion
| Field | Value |
|-------|-------|
| Method | `DELETE` |
| Endpoint | `/deleteAccount` |
| Preconditions | User must exist with valid credentials |
| Input | Form params: email + password |
| Expected Status | `200` |
| Response Assertions | `response.responseCode == 200`, `response.message == 'Account deleted!'` |
| Tags | `@regression @users` |

---

## Data Requirements
- `data/users/create-user-request.json` — Full user registration payload with all required fields
- `data/users/update-user-request.json` — Update payload with email, password, and fields to update

## Schema Requirements
- `schemas/users/user.schema.json` — Schema for the `user` object in `GET /getUserDetailByEmail` response
- `schemas/users/user-response.schema.json` — Generic response schema with `responseCode` and `message`

## Helper Requirements
- No auth token helper needed (this API uses form params for auth)

## Risks
- Random email must be generated per test run to avoid conflicts on create
- `automationexercise.com` is a public test API; it may have instability

## Approval Criteria
- [x] All happy path scenarios are defined
- [x] At least 2 negative scenarios per endpoint
- [x] Data requirements are documented
- [x] Schema requirements are documented
- [x] Domain is identified
