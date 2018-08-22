Feature: To Test Positive Scenarios for updatepassword API
  I want to verify the /cc/api/sso/updatepassword  endpoint returns expected response

  Background: 
    * url baseUrl
    * path ssoBase + '/updatepassword'

  Scenario: SSO-T10: POST/sso/updatepassword- With valid confirmCode
    Given request { "email": "#(email)" , "password": "#(password)" , "confirmCode": "#(confirmCode)"}
    When method POST
    Then status 200
    And match response.message == "Password Update Success"
    And match response.status == "OK"
