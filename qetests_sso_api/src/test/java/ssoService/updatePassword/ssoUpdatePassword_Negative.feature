Feature: To Test Negative Scenarios for updatepassword API
  I want to verify the /cc/api/sso/updatepassword endpoint returns error codes for negative scenarios

  Background: 
    * url baseUrl
    * path ssoBase + '/updatepassword'
    # Get credentials from credentials file
    * def CredentialsBody = read('data/valid-credentials-body.json')
    * def email = CredentialsBody.email
    * def password = CredentialsBody.password
    # Get credentials from file
    * def InvalidCredentialsBody = read('data/invalid-credentials-body.json')
    * def validemail = InvalidCredentialsBody.validemail
    * def validpassword = InvalidCredentialsBody.validpassword
    * def invalidemail = InvalidCredentialsBody.invalidemail
    * def invalidpassword = InvalidCredentialsBody.invalidpassword
    * def confirmCode = InvalidCredentialsBody.confirmCode
    * def notconfirmedemail = InvalidCredentialsBody.notconfirmedemail
    * def invalidpasswordformat = InvalidCredentialsBody.invalidpasswordformat

  Scenario: SSO-T11: POST/sso/updatepassword-With invalid confirmCode
    Given request { "email": "#(email)" , "password": "#(password)" , "confirmCode": "#(confirmCode)"}
    When method post
    Then status 400
    And match response.message == "Invalid code provided, please request a code again."
    And match response.status == "Bad Request"

  Scenario: SSO-T12: POST/sso/updatepassword-  With blank password
    Given request { "email": "#(email)" , "password": " " , "confirmCode": "#(confirmCode)"}
    When method post
    Then status 400
    And match response.message == "email/passwords/confirmCode should not be blank"
    And match response.status == "Bad Request"

  Scenario: SSO-T5: POST/sso/updatepassword-With  empty confirmcode
    Given request { "email": "#(validemail)" , "password": "#(validpassword)" , "confirmCode": " "}
    When method post
    Then status 400
    And match response.message == "email/passwords/confirmCode should not be blank"
    And match response.status == "Bad Request"

  Scenario: SSO-T64: POST/sso/updatepassword- With user not available in old sso(CUS)
    Given request { "email": "#(invalidemail)" , "password": "#(validpassword)" , "confirmCode": "#(confirmCode)"}
    When method post
    Then status 500
    And match response.message == "Password Update Failed, Operation not completed.   "
    And match response.status == "Internal Server Error"

  Scenario: SSO-T78: POST/sso/updatepassword-With spaces in password
    Given request { "email": "#(email)" , "password": "#(invalidpasswordformat)" , "confirmCode": "#(confirmCode)"}
    When method post
    Then status 400
    And match response.message == "1. Password policy for numeric characters not met \n2. Password policy for Uppercase alphabetic character not met \n3. Password policy for Special characters not met \n4. Password policy for minimum number of characters not met"
    And match response.status == "Bad Request"
