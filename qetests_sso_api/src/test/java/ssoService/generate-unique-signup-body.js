function() {	// Generates unique values for sso signup
	var now = java.lang.System.currentTimeMillis();
	var signupBody = {
	  email: "auto-signup+" + now + "@erindoorandwindow.com",
	  password: "Automation123!",
	  firstName: "Auto-SignUp",
	  lastName: "Testuser",
	  company: "DDA",
	  phone: "9740601389",
      address1 : "13th Street.47 W 13th St,New York,NY 10011,USA.20 Cooper Square.20 Cooper Square,New York,NY 10003, USA",
      city : "New York",
      state : "NY",
      zipCode : "10003",
      country : "USA"
	};
	
	return signupBody;
}