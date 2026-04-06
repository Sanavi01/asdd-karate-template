Feature: Auth Helper - Get Token
# Reusable feature for obtaining an auth token.
# Call this from other features using:
#   * def authResult = call read('classpath:helpers/auth/get-token.feature')
#   * def token = authResult.token

  Scenario: Get auth token
    Given url baseUrl
    And path 'login'
    And form field email = credentials.email
    And form field password = credentials.password
    When method post
    Then status 200
    # Extract token from response — adjust field name for your actual API
    * def token = response.token || ''
    * def userId = response.userId || ''
