Feature: To Test Positive Scenarios for Sigin API
  I want to verify the /cc/api/sso/sigin  endpoint returns expected response

  Background: 
    * url baseUrl
    * path ssoBase + '/signin'

  Scenario: SSO-T2: POST/sso/signin-With valid username and password
    Given request read('data/valid-credentials-body.json')
    When method POST
    Then status 200
    And match response.message == "Signin Successful"
    And match response.status == "OK"
    And match response.data.expiresIn == 3600
    And match response.data.tokenType == "Bearer"
    And match response.data.accessToken == '#string'
    And match response.data.refreshToken == '#string'
    And match response.data.idToken == '#string'

