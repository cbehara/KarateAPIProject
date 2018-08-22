function(creds) {
	var authString = creds.username + ':' + creds.password;
	var Base64 = Java.type('java.util.Base64');
	var encoded = Base64.getEncoder().encodeToString(authString.bytes);
	return 'Basic ' + encoded;
}

// Not working...but to use, use following in feature file
//* header Authorization = call read('classpath:basic-auth.js') { username: 'normapp', password: 'password' }
