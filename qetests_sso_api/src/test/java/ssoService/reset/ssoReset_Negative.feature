Feature: To Test Negative Scenarios for reset API
  I want to verify the /cc/api/sso/reset endpoint returns error codes for negative scenarios

  Background: 
    * url baseUrl
    * path ssoBase + '/reset'
    # Get credentials from invalid-credentials file
    * def InvalidCredentialsBody = read('data/invalid-credentials-body.json')
    * def validemail = InvalidCredentialsBody.validemail
    * def validpassword = InvalidCredentialsBody.validpassword
    * def invalidemail = InvalidCredentialsBody.invalidemail
    * def invalidpassword = InvalidCredentialsBody.invalidpassword
    * def notconfirmedemail = InvalidCredentialsBody.notconfirmedemail
    * def invalidpasswordformat = InvalidCredentialsBody.invalidpasswordformat

  Scenario: SSO-T13: POST/sso/reset-With invalid Username
    Given request { "email": "#(invalidemail)"}
    When method post
    Then status 400
    And match response.message == "Username/client id combination not found."
    And match response.status == "Bad Request"

  Scenario: SSO-T62: POST/sso/reset-With no registered/verified email or phone_number
    Given request { "email": "#(notconfirmedemail)"}
    When method post
    Then status 400
    And match response.message == "Cannot reset password for the user as there is no registered/verified email or phone_number"
    And match response.status == "Bad Request"

  Scenario: SSO-T15: POST/sso/reset-With Empty Username
    Given request { "email": ' ' }
    When method post
    Then status 400
    And match response.message == "Email should not be blank"
    And match response.status == "Bad Request"

  Scenario: SSO-T16: POST/sso/reset-With invalid resource path
    Given request {"email": "#(validemail)"}
    And path ssoBase + '/resets'
    When method get
    Then status 404
    And match response.error == "Not Found"
    And match response.message == "No message available"
