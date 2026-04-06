Feature: Users - CRUD Operations

  Background:
    * url baseUrl
    # Generate a unique email for this test session to avoid conflicts
    * def uniqueEmail = 'testuser' + Math.floor(Math.random() * 999999) + '@karate.test'

  @smoke @users
  Scenario: Successful user creation
    Given path 'createAccount'
    And def payload = read('classpath:data/users/create-user-request.json')
    And set payload.email = uniqueEmail
    And form fields payload
    When method post
    Then status 200
    And match response.responseCode == 201
    And match response.message == 'User created!'

  @negative @users
  Scenario: Create user with already registered email fails
    # First, create the user
    Given path 'createAccount'
    And def payload = read('classpath:data/users/create-user-request.json')
    And set payload.email = uniqueEmail
    And form fields payload
    When method post
    Then status 200
    And match response.responseCode == 201
    # Now try to create the same user again
    Given path 'createAccount'
    And form fields payload
    When method post
    Then status 200
    And match response.responseCode == 400
    And match response.message == 'Email already exists!'

  @smoke @users
  Scenario: Get user details by email
    # Create user first
    Given path 'createAccount'
    And def payload = read('classpath:data/users/create-user-request.json')
    And set payload.email = uniqueEmail
    And form fields payload
    When method post
    Then status 200
    And match response.responseCode == 201
    # Now retrieve the user
    Given path 'getUserDetailByEmail'
    And param email = uniqueEmail
    When method get
    Then status 200
    And match response.responseCode == 200
    And match response.user != null
    And match response.user.email == uniqueEmail
    And match response == read('classpath:schemas/users/user-detail-response.schema.json')

  @negative @users
  Scenario: Get user details for non-existent email
    Given path 'getUserDetailByEmail'
    And param email = 'does-not-exist-' + uniqueEmail
    When method get
    Then status 200
    And match response.responseCode == 404
    And match response.message == 'Account not found!'

  @regression @users
  Scenario: Update user account successfully
    # Create user first
    Given path 'createAccount'
    And def createPayload = read('classpath:data/users/create-user-request.json')
    And set createPayload.email = uniqueEmail
    And form fields createPayload
    When method post
    Then status 200
    And match response.responseCode == 201
    # Update the user
    Given path 'updateAccount'
    And def updatePayload = read('classpath:data/users/update-user-request.json')
    And set updatePayload.email = uniqueEmail
    And form fields updatePayload
    When method put
    Then status 200
    And match response.responseCode == 200
    And match response.message == 'User updated!'

  @regression @users
  Scenario: Delete user account successfully
    # Create user first
    Given path 'createAccount'
    And def payload = read('classpath:data/users/create-user-request.json')
    And set payload.email = uniqueEmail
    And form fields payload
    When method post
    Then status 200
    And match response.responseCode == 201
    # Delete the user
    Given path 'deleteAccount'
    And form field email = uniqueEmail
    And form field password = payload.password
    When method delete
    Then status 200
    And match response.responseCode == 200
    And match response.message == 'Account deleted!'
