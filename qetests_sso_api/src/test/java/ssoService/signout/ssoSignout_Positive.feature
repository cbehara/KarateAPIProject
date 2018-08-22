Feature: To Test Positive Scenarios for Signout API
  I want to verify the /cc/api/sso/signout  endpoint returns expected response

  Background: 
    * url baseUrl
    * path ssoBase + '/signout'
    # Get credentials from file
    * def credentials = read('data/valid-credentials-body.json')
    * def email = credentials.email
    * def password = credentials.password
    # Sign in and get token
    * def signIn = call read('../common_generateRefreshToken.feature') { email: '#(email)', password: '#(password)' }
    * def accessToken = signIn.accessToken
    * header token = accessToken

  Scenario: SSO-T25: POST/sso/signout-With  valid Accesstoken
    #Provide Valid Access token in header
    Given request {}
    When method POST
    Then status 200
    And match response.message == "SignOut Successful"
    And match response.status == "OK"
