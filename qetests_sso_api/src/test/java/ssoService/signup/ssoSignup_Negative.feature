Feature: To Test Negative Scenarios for Signup API
  I want to verify the /cc/api/sso/signup endpoint returns error codes for negative scenarios

  Background: 
    * url baseUrl
    * path ssoBase + '/signup'
    # Get credentials from invalid-credentials file
    * def InvalidCredentialsBody = read('data/invalid-credentials-body.json')
    * def validemail = InvalidCredentialsBody.validemail
    * def validpassword = InvalidCredentialsBody.validpassword
    * def invalidemail = InvalidCredentialsBody.invalidemail
    * def invalidpassword = InvalidCredentialsBody.invalidpassword
    * def invalidpasswordformat = InvalidCredentialsBody.invalidpasswordformat
    # Get credentials from invalid-Signup-credentials file
    * def invalidsignupbody = read('data/invalid-signup-body.json')
    * def firstName = invalidsignupbody.firstName
    * def lastName = invalidsignupbody.lastName
    * def company = invalidsignupbody.company
    * def phone = invalidsignupbody.phone
    * def address1 = invalidsignupbody.address1
    * def city = invalidsignupbody.city
    * def state = invalidsignupbody.state
    * def zipCode = invalidsignupbody.zipCode
    * def country = invalidsignupbody.country

  Scenario: SSO-T61: POST/sso/signup-With Valid Username and password that data is already avaliable in new SSO
    # Provide already exist user account in request body
    Given request read('data/invalid-signup-body.json')
    When method post
    Then status 400
    And match response.message == "chakravarthibehara+103@gmail.com: User account already exists, user should signin or reset password"
    And match response.status == "Bad Request"

  Scenario: SSO-T8: POST/sso/signup-With valid username and invalid password format
    # Provide invalid password format in request body
    Given request { "email" : "chakravarthibehara+5379@gmail.com","password" : "#(invalidpasswordformat)","firstName" : "#(firstName)","lastName" : "#(lastName)","company" : "#(company)", "phone" : "#(phone)","address1" : "#(address1)","city" : "#(city)","state" : "#(state)", "zipCode" : "#(zipCode)","country" : "#(country)" }
    When method post
    Then status 400
    And match response.message == "1. Password policy for numeric characters not met \n2. Password policy for Uppercase alphabetic character not met \n3. Password policy for Special characters not met \n4. Password policy for minimum number of characters not met"
    And match response.status == "Bad Request"

  Scenario: SSO-T7: POST/sso/signup-With empty username/password
    # Donot Provide Username/password  in request body
    Given request { "email" : " ","password" : "#(validpassword)","firstName" : "#(firstName)","lastName" : "#(lastName)","company" : "#(company)", "phone" : "#(phone)","address1" : "#(address1)","city" : "#(city)","state" : "#(state)", "zipCode" : "#(zipCode)","country" : "#(country)"}
    When method post
    Then status 400
    And match response.message == "Some of required mandatory fields are missing [firstName, lastName, phoneNumber, company, email, password, address1, city, state, zipCode, country]"
    And match response.status == "Bad Request"
