Feature: To Test Positive Scenario for Refresh API
  I want to verify the /cc/api/sso/refresh  endpoint returns expected response

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

  Scenario: SSO-T22: POST/sso/refresh- With valid token
    #Provide valid Authorization and Refresh token in header
    Given request {}
    When method post
    Then status 200
    And match response.message == "Refresh Successful"
    And match response.status == "OK"
