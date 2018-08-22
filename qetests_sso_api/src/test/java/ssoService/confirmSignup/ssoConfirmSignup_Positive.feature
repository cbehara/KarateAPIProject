Feature: To Test Positive Scenario for confirmsignup  API
  I want to verify the /cc/api/sso/confirmsignup endpoint returns expected response

  Background: 
    * url baseUrl
    * path ssoBase + '/confirmsignup'

  Scenario: SSO-T81: PUT/sso/confirmsignup-With Valid Username and confirmcode
    Given request { "email" : "#(email)","confirmCode" : "#(confirmCode)"}
    When method post
    Then status 200
    And match response.message == "Confirm Signup Successful"
    And match response.status == "OK"
