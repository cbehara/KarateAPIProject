Feature: How to Use the Utils
  Contains examples of using utils and sample scenarios for accessing DB

  Background: 
  #* url baseUrl
  #* header Authorization = call read('config-auth.js')
  #* path call read('config-path.js')
  
   
  Scenario: INTG-TXXXX: Connect to Oracle
   Refer to https://github.com/intuit/karate/tree/master/karate-demo > dogs.feature
    * def creds = { username: '#(dbCUSUsername)', password: '#(dbCUSPassword)', url: '#(dbCUSUrl)' }
    * def dbConn = Java.type('com.ddaqe.utils.DBConnector')
    * def db = new dbConn(creds)
    * def output1 = db.readValue('SELECT count(COU_SYS_ID) FROM COU_COMMON_USER');
    * print 'single value:', output1
    * def output2 = db.readRow('SELECT * FROM COU_COMMON_USER WHERE COU_SYS_ID = 3000');
    * print 'single row:', output2
    * def output3 = db.readRows('SELECT * FROM COU_COMMON_USER WHERE ROWNUM <= 3');
    * print 'multiple rows:', output3
    
  Scenario: INTG-TXXXX: Connect to Mongo
    * def mongoDbConn = Java.type('com.ddaqe.utils.MongoDBConnector')
    * def mdb = new mongoDbConn(mongoDbUrl, 'tag_db')
    * def out1 = mdb.readDoc('{ prefLabel: "A.C. Horn" }', 'Corporation')
    * print 'single doc:', out1
    * print out1.additionalType
    * print out1.altLabels
    * match out1.prefLabel == 'A.C. Horn'
    * def out2 = mdb.readDocs('{ prefLabel: /Horn/ }', 'Corporation')
    * print 'multiple docs:', out2
    * def out3 = mdb.readDocCount('{ prefLabel: /A.C./ }', 'Corporation')
    * print 'count is', out3

  Scenario: INTG-TXXXX: Get current date & time
  	# Get NOW in 'yyyyMMddHHmmss' format, e.g. 20180716154629
    * def currentDateTime = call read('classpath:util-get-date.js') 'yyyyMMddHHmmss'
    * print currentDateTime
    # Get NOW in 'MM/dd/yyy HH:mm:ss a' format, e.g. 07/16/2018 15:46:29 PM
    * def currentDateTime = call read('classpath:util-get-date.js') 'MM/dd/yyy HH:mm:ss a'
    * print currentDateTime

  Scenario: INTG-TXXXX: Get system time
    * def systemTime = call read('classpath:util-get-system-time.js')
    * print systemTime
