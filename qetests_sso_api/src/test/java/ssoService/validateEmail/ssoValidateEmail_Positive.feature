Feature: To Test Positive Scenarios for validateEmail API
  I want to verify the /cc/api/sso/validateEmail  endpoint returns expected response

  Background: 
    * url baseUrl
    * path ssoBase + '/validateEmail'
    # Get credentials from invalid-credentials file
    * def InvalidCredentialsBody = read('data/invalid-credentials-body.json')
    * def validemail = InvalidCredentialsBody.validemail
    * def validpassword = InvalidCredentialsBody.validpassword
    * def invalidemail = InvalidCredentialsBody.invalidemail
    * def invalidpassword = InvalidCredentialsBody.invalidpassword

  Scenario: SSO-T58: GET/sso/validateEmail-With User email is available in neither in CUS and nor in Cognito
    Given params {email : "#(invalidemail)"}
    When method GET
    Then status 200
    And match response.message == "chakri@gmail.com: User email is valid for registration."
    And match response.status == "OK"
