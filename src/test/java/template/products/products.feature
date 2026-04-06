Feature: Products - List and Search

  Background:
    * url baseUrl

  @smoke @products
  Scenario: Get all products list
    Given path 'productsList'
    When method get
    Then status 200
    And match response.responseCode == 200
    And match response.products != null
    And match each response.products == read('classpath:schemas/products/product.schema.json')

  @smoke @products
  Scenario: Get all brands list
    Given path 'brandsList'
    When method get
    Then status 200
    And match response.responseCode == 200
    And match response.brands != null
    And match response.brands[0].brand != null

  @regression @products
  Scenario: Search products by keyword
    Given path 'searchProduct'
    And form field search_product = 'top'
    When method post
    Then status 200
    And match response.responseCode == 200
    And match response.products != null

  @negative @products
  Scenario: Search product with empty search term
    Given path 'searchProduct'
    When method post
    Then status 200
    And match response.responseCode == 400
    And match response.message == 'Bad request, search_product parameter is missing in POST request.'

  @negative @products
  Scenario: POST to products list endpoint is not allowed
    Given path 'productsList'
    When method post
    Then status 200
    And match response.responseCode == 405
    And match response.message == 'This request method is not supported.'
