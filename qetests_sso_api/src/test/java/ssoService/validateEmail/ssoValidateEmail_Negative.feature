Feature: To Test Negative Scenarios for validateEmail API
  I want to verify the /cc/api/sso/validateEmail endpoint returns error codes for negative scenarios

  Background: 
    * url baseUrl
    * path ssoBase + '/validateEmail'
    # Get credentials from credentials file
    * def CredentialsBody = read('data/valid-credentials-body.json')
    * def email = CredentialsBody.email
    * def password = CredentialsBody.password
    # Get credentials from invalid-credentials file
    * def InvalidCredentialsBody = read('data/invalid-credentials-body.json')
    * def validemail = InvalidCredentialsBody.validemail
    * def validpassword = InvalidCredentialsBody.validpassword
    * def invalidemail = InvalidCredentialsBody.invalidemail
    * def invalidpassword = InvalidCredentialsBody.invalidpassword

  Scenario: SSO-T57: GET/sso/validateEmail-With User email is available in both CUS and Cognito
    Given params {email : "#(validemail)"}
    When method GET
    Then status 400
    And match response.message == "chakravarthi.behera@harman.com: User account already exists, user should signin or reset password"
    And match response.status == "Bad Request"

  Scenario: SSO-T60: GET/sso/validateEmail-With User email is not available in CUS but available in Cognito
    Given params {email : "auto-signup+1@qeroofingsupplies.com"}
    When method GET
    Then status 400
    And match response.message == "auto-signup+1@qeroofingsupplies.com: User is not confirmed, Registeration is incomplete."
    And match response.status == "Bad Request"

  Scenario: SSO-T59: GET/sso/validateEmail-With User email is available in CUS but not in Cognito
    Given params {email : "auto-signup2@qeroofingsupplies.com"}
    When method GET
    Then status 400
    And match response.message == "auto-signup2@qeroofingsupplies.com: User cannot register, account already exists."
    And match response.status == "Bad Request"
