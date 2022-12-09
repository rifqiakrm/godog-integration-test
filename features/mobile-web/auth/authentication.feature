Feature: Authentication
      In order login to the system, I need to login
      with my username and password

  Background:
  This section runs before every Scenario. Its main purpose is to generate random user data
  and save it under provided key in scenario cache.

    Given I save "http://localhost:8090" as "APP_URL"
    Given I save "test@gmail.com" as "USER_EMAIL"
    Given I save "123456" as "USER_PASSWORD"
    Given I save "123457" as "USER_PASSWORD_INVALID"
    Given I save "application/json" as "CONTENT_TYPE_JSON"

  Scenario: Login with valid credentials
  As application user
  I would like to login to my account with a valid credentials

    #---------------------------------------------------------------------------------------------------
    # We send HTTP(s) request using pre-generated data to login with valid credentials.
    # Accessing saved data from scenario cache is done through template syntax from text/template package.
    Given I prepare new "POST" request to "{{.APP_URL}}/v1/user/login" and save it as "LOGIN_REQUEST"
    Given I set following headers for prepared request "LOGIN_REQUEST":
    """
    {
        "Content-Type":"{{.CONTENT_TYPE_JSON}}"
    }
    """
    Given I set following body for prepared request "LOGIN_REQUEST":
    """
    {
        "username":"{{.USER_EMAIL}}",
        "password":"{{.USER_PASSWORD}}"
    }
    """
    When I send request "LOGIN_REQUEST"
    Then the response status code should not be 400
    But the response status code should be 200
    And the response body should have format "JSON"
    And the "JSON" node "data.token" should be "string"
    And the "JSON" node "message" should be "string" of value "success"
    And I save from the last response "JSON" node "data.token" as "AUTH_TOKEN"

  Scenario: Login with invalid credentials
  As application user
  I would like to login to my account with an invalid credentials

    #---------------------------------------------------------------------------------------------------
    # We send HTTP(s) request using pre-generated data to login with valid credentials.
    # Accessing saved data from scenario cache is done through template syntax from text/template package.
    Given I prepare new "POST" request to "{{.APP_URL}}/v1/user/login" and save it as "LOGIN_REQUEST"
    Given I set following headers for prepared request "LOGIN_REQUEST":
    """
    {
        "Content-Type":"{{.CONTENT_TYPE_JSON}}"
    }
    """
    Given I set following body for prepared request "LOGIN_REQUEST":
    """
   {
        "username":"{{.USER_EMAIL}}",
        "password":"{{.USER_PASSWORD_INVALID}}"
    }
    """
    When I send request "LOGIN_REQUEST"
    Then the response status code should not be 200
    But the response status code should be 401
    And the response body should have format "JSON"