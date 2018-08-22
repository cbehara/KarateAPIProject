Feature: To Validate updateuser  API
  I want to verify the /lookup/companyType endpoint returns expected response
  
Background: 
     * url baseUrl
  	* path ssoBase + '/updateuser'  
      
  Scenario: SSO-T30: PUT/sso/updateuser-With valid Json Body
    Given request ''
    When method get
    Then status 200
    # Verify that response contains one of the valid company types
    And match $['data']['companyTypes'][*]['id'] contains '00010'
    And match $['data']['companyTypes'][*]['name'] contains 'Designer'
    # Save values of one of the response data
    * def companyId = $['data']['companyTypes'][9]['id']
    * print companyId
    * def companyName = $['data']['companyTypes'][9]['name']
    * print companyName
    * def responseCount =  $['data']['metaData']['count']
    * print responseCount    
    # Validate data from database
    * def creds = { username: '#(dbRPTUsername)', password: '#(dbRPTPassword)', url: '#(dbRPTUrl)' }
    * def dbConn = Java.type('com.ddaqe.utils.DBConnector')
    * def db = new dbConn(creds)
    * def companiesQuery = "SELECT CODE_ID,  CODE_REMARK FROM RPT.lkc_lookup_code WHERE TYPE_ID LIKE 'CNTY' AND ACTIVE_IND LIKE 'Y' AND CODE_ID <> '0' ORDER BY CODE_ID"
    * def companies = db.readRows(companiesQuery);
    * print companies
    * match companies contains { CODE_ID: '#(companyId)',  CODE_REMARK: '#(companyName)' }
    # Verify that number of records in response matches those in database
    * def companiesCountQuery = "SELECT count(CODE_ID) FROM RPT.lkc_lookup_code WHERE TYPE_ID LIKE 'CNTY' AND ACTIVE_IND LIKE 'Y' AND CODE_ID <> '0'"
    * def companiesCount = db.readValue(companiesCountQuery)
    * print companiesCount
    * match companiesCount == responseCount
    