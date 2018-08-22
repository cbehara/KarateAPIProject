Feature: To Test Positive Scenarios for reset API
  I want to verify the /cc/api/sso/reset  endpoint returns expected response

  Background: 
    * url baseUrl
    * path ssoBase + '/reset'
    # Get credentials from credentials file
    * def CredentialsBody = read('data/valid-credentials-body.json')
    * def email = CredentialsBody.email

  Scenario: SSO-T14: POST/sso/reset-With valid Username
    Given request { "email": "#(email)"}
    When method post
    Then status 200
    And match response.message == "Forget Password Request Submitted and sent mail to c***@g***.com"
    And match response.status == "OK"
