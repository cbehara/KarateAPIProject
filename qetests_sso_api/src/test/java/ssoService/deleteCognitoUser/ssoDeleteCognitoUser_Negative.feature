Feature: To Test Negative Scenarios for DeleteCognitoUser API
  I want to verify the /cc/api/sso/deleteCognitoUser endpoint returns error codes for negative scenarios

  Background: 
    * url baseUrl
    * path ssoBase + '/deleteCognitoUser'

  Scenario: SSO-T34: DELETE/sso/deleteCognitoUser-With blank email id
    # Provide blank email id in Request body
    Given request { "email": " "}
    When method delete
    Then status 400
    And match response.message == "Email should not be blank"
    And match response.status == "Bad Request"

  Scenario: SSO-T36: DELETE/sso/deleteCognitoUser-With already DeleteCongitoUser
    # Provide already DeleteCongitoUser in Request body
    Given request { "email": "auto-signup2@qeroofingsupplies.com"}
    When method delete
    Then status 400
    And match response.message == "User does not exist."
    And match response.status == "Bad Request"

  Scenario: SSO-T37: DELETE/sso/deleteCognitoUser-With invalid resource path
    # Provide incorrect resource  name as "deleteCognitoUsers" instead of "deleteCognitoUser"
    Given request {"email": "auto-signup2@qeroofingsupplies.com"}
    And path ssoBase + '/deleteCognitoUsers'
    When method delete
    Then status 404
    And match response.message == "No message available"
    And match response.error == "Not Found"
