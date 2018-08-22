package ssoService.deleteCognitoUser;

import org.junit.runner.RunWith;

import com.intuit.karate.junit4.Karate;

import cucumber.api.CucumberOptions;

@RunWith(Karate.class)
@CucumberOptions(features = "classpath:ssoService/deleteCognitoUser/ssoDeleteCognitoUser_Positive.feature")
public class SSODeleteCognitoUserSingleRunner {
			// This will run only the feature files listed under Cucumber Options
			// https://github.com/intuit/karate#cucumber-options
			//
			// Modify as needed to use while testing out scripts
			// Example for running one script:
			// @CucumberOptions(features = "classpath:sampleService/e2e/sample-utils.feature")
			// Example for running 1+ scripts:
			// @CucumberOptions(features = {
			// 		"classpath:sampleService/e2e/sample-utils.feature",
			// 		"classpath:sampleService/e2e/e2e-another-file.feature"})

}
