Feature: To Test Positive Scenario for signup API
  I want to verify the /cc/api/sso/signup endpoint returns expected response

  Background: 
    * url baseUrl
    * path ssoBase + '/signup'

  Scenario: SSO-T6: POST/sso/signup- With Valid Username and password that data is already avaliable in old SSO not available in new sso
    * def body1 = call read('generate-unique-signup-body.js')
    Given request body1
    When method post
    Then status 200
    And match response.message == "Signup Request Success"
    And match response.status == "OK"
   #
    # Validate data from database
    #* def creds = { username: '#(dbCUSUsername)', password: '#(dbCUSPassword)', url: '#(dbCUSUrl)' }
    #* def dbConn = Java.type('com.ddaqe.utils.DBConnector')
    #* def db = new dbConn(creds)
    # Verify that UserDeatils in response matches those in database
    #* def UserDetailsQuery = "select * from cou_common_user where User_Name like 'auto-signup%'"
    #* def UserDetail = db.readRows(UserDetailsQuery);
    #* print UserDetail
    #* match UserDetail contains {USER_NAME: '#(body1.email)' }
