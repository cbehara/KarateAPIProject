Feature: To Test Negative Scenarios for Refresh API
  I want to verify the /cc/api/sso/refresh endpoint returns error codes for negative scenarios

  Background: 
    * url baseUrl
    * path ssoBase + '/refresh'
    # Get credentials from file
    * def credentials = read('data/valid-credentials-body.json')
    * def email = credentials.email
    * def password = credentials.password
    # Sign in and get token
    * def signIn = call read('../common_generateRefreshToken.feature') { email: '#(email)', password: '#(password)' }
    * def refreshToken = signIn.refreshToken
    * def idToken = signIn.idToken
    * header x-dda-refresh-token = refreshToken
    * header Authorization = idToken

  Scenario: SSO-T21: POST/sso/refresh- With invalid token
    Given request {}
    When header x-dda-refresh-token = 'xyz'
    When method post
    Then status 400
    And match response.status == "Bad Request"
    And match response.message == "Invalid Refresh Token"

  Scenario: SSO-T23: POST/sso/refresh- With Empty refreshtoken/Authorization
    Given request {}
    When header x-dda-refresh-token = ' '
    When header uthorization = ' '
    When method post
    Then status 400
    And match response.status == "Bad Request"
    And match response.message == "Refresh Token/AccessToken cannot be blank"

  Scenario: SSO-T24: POST/sso/refresh- With invalid resource path
    Given request {}
    And path ssoBase + '/refreshs'
    When method get
    Then status 404
    And match response.error == "Not Found"
    And match response.message == "No message available"
