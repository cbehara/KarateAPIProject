Feature: To Test Negative Scenarios for DeleteCognitoUser API
  I want to verify the /cc/api/sso/deleteCognitoUser  endpoint returns expected response

  Background: 
    * url baseUrl

  Scenario: SSO-T35: DELETE/sso/deleteCognitoUser-With valid User Email
    # Signup and create new user
    Given path ssoBase + '/signup'
    * def signup = call read('../generate-unique-signup-body.js')
    * def emailid = signup.email
    * print "Email is >>>> " + emailid
    And request signup
    When method post
    Then status 200
    #Provide Valid User email
    Given path ssoBase + '/deleteCognitoUser'
    And request {"email": "#(emailid)"}
    When method DELETE
    Then status 200
    And match response.message == "User Deleted Successfully"
   
