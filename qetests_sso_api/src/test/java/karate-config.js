function() {    
  var env = karate.env; // Get system property 'karate.env'
  if (!env) {	// Set to this if no env provided
    env = 'qa';
  }
  karate.log('karate.env system property is:', env);
  
  // Set base config
  var config = {
  dbCUSUsername: 'cus_read_user',
    ssoBase: 'cc/api/sso'
  }
  
  // Override here only if different from base e.g. config.foo = 'bar';
  if (env == 'dev') {
    config.baseUrl = 'https://api.dodgedev.com';
    config.mongoDbUrl = 'mongodb://qa_user:qauser@cluster0-shard-00-00-rbged.mongodb.net:27017,cluster0-shard-00-01-rbged.mongodb.net:27017,cluster0-shard-00-02-rbged.mongodb.net:27017/?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin';
     config.dbCUSUrl = 'jdbc:oracle:thin:@//AE-D-ORA-CUSD-PRIM-V.construction.com:1521/cusd_dg';
     config.dbCUSPassword = 'bdred225';
  } else if (env == 'qa') {
	config.baseUrl = 'https://qa.api.construction.com';
	config.mongoDbUrl = 'mongodb://qa_user:qauser@dda-mongo-qa-shard-00-00-fcvxs.mongodb.net:27017,dda-mongo-qa-shard-00-01-fcvxs.mongodb.net:27017,dda-mongo-qa-shard-00-02-fcvxs.mongodb.net:27017/?ssl=true&replicaSet=dda-mongo-qa-shard-0&authSource=admin';
    config.dbCUSUrl = 'jdbc:oracle:thin:@//AE-Q-ORA-CUSQ-PRIM-V.construction.com:1524/cusq_dg';
    config.dbCUSPassword = 'bdronl533';
  } 
  
  // Timeout if a connection or servers don't respond within 5 seconds
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);
  
  return config;
}