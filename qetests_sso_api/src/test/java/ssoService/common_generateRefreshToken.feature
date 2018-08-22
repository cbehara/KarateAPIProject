@ignore
Feature: SSO Service: SignIn
  Shared feature file that enables signin

  Background: 
    * url baseUrl
    * path ssoBase + '/signin'

  Scenario: Sign In with Provided Credentials and Get Refresh token
    Given request { email: '#(email)', password: '#(password)' }
    When method post
    Then status 200
    And def refreshToken = response.data.refreshToken
    And def idToken = response.data.idToken
    And def accessToken = response.data.accessToken
