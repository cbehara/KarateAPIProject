Feature: To Test Negative Scenarios for Sigin API
  I want to verify the /cc/api/sso/sigin endpoint returns error codes for negative scenarios

  Background: 
    * url baseUrl
    * path ssoBase + '/signin'
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
    * def notconfirmedemail = InvalidCredentialsBody.notconfirmedemail
    * def invalidpasswordformat = InvalidCredentialsBody.invalidpasswordformat

  Scenario: SSO-T1: POST/sso/signin-With User account does not exists in Cognito User Pool
    # Provide incorrect parameter name as "sigin" instead of "sigins"
    Given request { "email": "#(invalidemail)" , "password": "#(validpassword)"}
    When method post
    Then status 400
    And match response.message == "User does not exist."
    And match response.status == "Bad Request"

  Scenario: SSO-T56: POST/sso/signin-With user Acount in Cognito and Not Cus
    # Provide user Acount in Cognito and Not Cus
    Given request { "email": "#(notconfirmedemail)" , "password": "#(validpassword)"}
    When method post
    Then status 400
    And match response.message == "User is not confirmed."
    And match response.status == "Bad Request"

  Scenario: SSO-T3: POST/sso/signin-With invalid username or password
    # Provide invalid username or password
    And print "email : " + validemail
    Given request { "email": '#(validemail)' , "password": '#(invalidpassword)' }
    And print "Request is : " + request
    When method post
    Then status 400
    And match response.message == "Incorrect username or password."
    And match response.status == "Bad Request"

  Scenario: SSO-T4: POST/sso/signin-With empty username or password
    # Don't Provide  username or password
    Given request { "email": "  " , "password": "#(validpassword)"}
    When method post
    Then status 400
    And match response.message == "email/passwords should not be blank"
    And match response.status == "Bad Request"

  Scenario: SSO-T85: POST/sso/signin-With invalid resource path
    # Provide incorrect parameter name as "sigin" instead of "sigins"
    Given request read('data/valid-credentials-body.json')
    And path ssoBase + '/sigins'
    When method POST
    Then status 404
    And match response.message == "No message available"
    And match response.error == "Not Found"
