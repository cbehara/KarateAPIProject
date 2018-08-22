Feature: SSO Service: Confirmignup
   I want to verify the /cc/api/sso/confirmsignup Negative scenarios for SSO Service Confirmignup API

  Background: 
    * url baseUrl
    * path ssoBase + '/confirmsignup'
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
    * def invalidpasswordformat = InvalidCredentialsBody.invalidpasswordformat
    * def confirmCode = InvalidCredentialsBody.confirmCode
    * def notconfirmedemail = InvalidCredentialsBody.notconfirmedemail

  Scenario: SSO-T79: POST/sso/confirmsignup-With already confirmed user
    Given request { "email" : "#(email)","confirmCode" : "#(confirmCode)"}
    When method post
    Then status 400
    And match response.message == "User cannot be confirm. Current status is CONFIRMED"
    And match response.status == "Bad Request"

  Scenario: SSO-T83: POST/sso/confirmsignup- With valid invalid username and invalid confirmccode
    Given request {"email" : "#(invalidemail)","confirmCode" : "#(confirmCode)"}
    When method post
    Then status 400
    And match response.message == "Username/client id combination not found"
    And match response.status == "Bad Request"

  Scenario: SSO-T82: POST/sso/confirmsignup- With empty username/Confirmcode
    Given request { "email" : "#(email)","confirmCode" : " "}
    When method post
    Then status 400
    And match response.message == "email/confirmCode should not be blank"
    And match response.status == "Bad Request"

  Scenario: SSO-T80: POST/sso/confirmsignup- With valid username and invalid Confirmcode
    Given request {"email" : "#(notconfirmedemail)","confirmCode" : "#(confirmCode)"}
    When method post
    Then status 400
    And match response.message == "Invalid code provided, please request a code again."
    And match response.status == "Bad Request"
