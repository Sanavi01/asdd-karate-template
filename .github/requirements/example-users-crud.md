# Requirement: Users CRUD

## Objective
Validate the full CRUD lifecycle for the Users API: create a user, retrieve it, update it, and delete it. Confirm the API behaves correctly for valid and invalid inputs.

## Domain
users

## API Base URL
https://automationexercise.com/api

## Endpoints to Test
- `POST /createAccount` — Create a new user account
- `GET /getUserDetailByEmail` — Get user details by email
- `PUT /updateAccount` — Update user account details
- `DELETE /deleteAccount` — Delete a user account

## Authentication
- `DELETE /deleteAccount` and `PUT /updateAccount` require Basic Auth (email + password as form params)
- Other endpoints use form parameters only

## Expected Behavior (Happy Path)
- When a new user is created with all required fields, the API returns status 200 with `{ "responseCode": 201, "message": "User created!" }`
- When an existing user's details are retrieved, the API returns status 200 with a user object
- When a user's information is updated with valid data, the API returns status 200 with success message
- When a user is deleted with correct credentials, the API returns status 200 with success message

## Validation Rules
- `POST /createAccount` response must contain `responseCode` and `message`
- `GET /getUserDetailByEmail` response must contain `responseCode: 200` and a nested `user` object
- `user` object must contain: `id`, `name`, `email`, `title`, `birth_day`, `birth_month`, `birth_year`
- All `responseCode` fields must be integers

## Test Data Requirements
- Need a unique email per test run (use random email generation)
- Valid user payload must include: name, email, password, title, birth_date, birth_month, birth_year, firstname, lastname, company, address1, country, state, city, zipcode, mobile_number

## Edge Cases & Negative Scenarios
- Create user with already-registered email → expect responseCode 400
- Get user details for non-existent email → expect responseCode 404
- Delete account with invalid credentials → expect responseCode 401

## Notes
- API docs: https://automationexercise.com/api_list
- No API key required for most endpoints
- This is a public test API — suitable for learning
