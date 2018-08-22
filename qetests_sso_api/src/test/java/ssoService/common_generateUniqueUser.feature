@ignore
Feature: SSO Service: SignUp
  Shared feature file that enables signup

  Background: 
    * url baseUrl
    * path ssoBase + '/signup'

  Scenario: Signup with Provided unique json body and Get unqiue User
    * def body1 = call read('generate-unique-signup-body.js')
    And print "Email is >>>> " + body1.email
    Given request body1
    When method post
    Then status 200
    * def emailid = body1.email
