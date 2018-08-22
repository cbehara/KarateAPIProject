Feature: To Test Negative Scenarios for Getuser API
  I want to verify the /cc/api/sso/getuser  endpoint returns expected response

  Background: 
    * url baseUrl
    * path ssoBase + '/getuser'
    # Get credentials from file
    * def credentials = read('data/valid-credentials-body.json')
    * def email = credentials.email
    * def password = credentials.password
    # Sign in and get token
    * def signIn = call read('../common_generateRefreshToken.feature') { email: '#(email)', password: '#(password)' }
    * def accessToken = signIn.accessToken
    * header token = accessToken

  Scenario: SSO-T91: GET/sso/getuser- With valid token
    #Provide Valid Access token in header
    When method GET
    Then status 200
    And match response.message == "User Data Lookup"
    And match response.status == "OK"
    And match response.data[6].value == "chakravarthibehara+5378@gmail.com"
    And match response.data[5].value == "1554572"
    # Validate data from database
    #* def creds = { username: '#(dbCUSUsername)', password: '#(dbCUSPassword)', url: '#(dbCUSUrl)' }
    #* def dbConn = Java.type('com.ddaqe.utils.DBConnector')
    #* def db = new dbConn(creds)
    # Verify that UserDeatils in response matches those in database
    #* def UserDetailsQuery = "select * from cou_common_user where User_Name like 'chakravarthibehara+5378@gmail.com%'"
    #* def UserDetail = db.readRow(UserDetailsQuery);
    #* print UserDetail
