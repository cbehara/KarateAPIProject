# Dodge SSO 2.0 API tests

This project contains tests for the SSO 2.0 APIs. 
It is based on [Karate](https://github.com/intuit/karate).

## Setup

This project expects JDK 1.8 (at least jdk1.8.0_162), Maven 3.5.2 and JUnit 4. 
Refer to [Karate Training](https://confluence.construction.com/confluence/display/AUTO/Karate+Training) for IDE setup.

1. Clone the repo
2. To open project, import as Maven project into a workspace (in Eclipse, File > Import... > Existing Maven Projects).
3. Install Oracle JDBC driver to local Maven by running the following from command line: 

	`mvn install:install-file -Dfile=src/main/resources/ojdbc7.jar -DgroupId=com.oracle -DartifactId=ojdbc7 -Dversion=12.1.0.2 -Dpackaging=jar`

## Running tests

__NOTE__: If you encounter errors running tests:
* from Command Line, run `mvn clean compile`
* in eclipse, right-click project and select maven > update project

### Running in Dev environment

Default environment is Dev.

To run only smoke tests for a service (runs tests in parallel):

`mvn test -Dtest=[service_folder_name].SmokeTestParallel`

e.g. `mvn test -Dtest=ssoService.SmokeTestParallel`


To run full regression suite for a service (runs tests in parallel):

`mvn test -Dtest=[service_folder_name].RegressionTestParallel`

e.g. `mvn test -Dtest=ssoService.RegressionTestParallel`


To run entire test suite (including all services) in one thread:

`mvn test`

To run entire regression suite, including all services (runs tests in parallel):

`mvn test -Dtest=RegressionTestParallel`


To run the all tests for a specific endpoint:

`mvn test -Dtest=[api_runner_file_name]` 

e.g. `mvn test -Dtest=SpecRunner`


### Running in QA and other environments

To run tests in other environments, append the following to the command: `-DargLine="-Dkarate.env=qa"`

E.g. run ssoService regression test in QA as follows:

`mvn test -Dtest=ssoService.RegressionTestParallel -DargLine="-Dkarate.env=qa"`


## Reports

Individual html, xml and json reports are saved to `target/surefire-reports`.
When using TestParallel.java, summary HTML reports are also saved to `target/cucumber-html-reports`; `overview-features.html` is root file.

## Logging

A log file `target/karate.log` is generated with each run.

To reduce information written to log files, change the log level from DEBUG to INFO:
In logback-test.xml, change `<logger name="com.intuit" level="DEBUG"/>` to `<logger name="com.intuit" level="INFO"/>`.

## Creating new tests

Refer to [Usage Guidelines](https://confluence.construction.com/confluence/display/AUTO/Karate+Usage+Guidelines).
