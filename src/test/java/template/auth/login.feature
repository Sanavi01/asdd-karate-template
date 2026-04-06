Feature: Auth - Login

  Background:
    * url baseUrl

  @smoke @auth
  Scenario: Successful login with valid credentials
    Given path 'login'
    And form field email = read('classpath:data/auth/login-valid-credentials.json').email
    And form field password = read('classpath:data/auth/login-valid-credentials.json').password
    When method post
    Then status 200
    And match response.responseCode == 200
    And match response.message == 'User exists!'

  @negative @auth
  Scenario: Login fails with invalid password
    Given path 'login'
    And form field email = read('classpath:data/auth/login-valid-credentials.json').email
    And form field password = 'wrong-password-123'
    When method post
    Then status 200
    And match response.responseCode == 404
    And match response.message == 'User not found!'

  @negative @auth
  Scenario: Login fails with unregistered email
    Given path 'login'
    And form field email = 'nonexistent@example.com'
    And form field password = 'anypassword'
    When method post
    Then status 200
    And match response.responseCode == 404

  @contract @auth
  Scenario: Login response has expected structure
    Given path 'login'
    And form field email = read('classpath:data/auth/login-valid-credentials.json').email
    And form field password = read('classpath:data/auth/login-valid-credentials.json').password
    When method post
    Then status 200
    And match response == read('classpath:schemas/auth/login-response.schema.json')
