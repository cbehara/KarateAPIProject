Feature: To Test Negative Scenarios for Signout API
  I want to verify the /cc/api/sso/signout endpoint returns error codes for negative scenarios

  Background: 
    * url baseUrl
    * path ssoBase + '/signout'

  Scenario: SSO-T26: POST/sso/signout-With Expired Accesstoken
    # Provide Expired Access Token
    Given request {}
    And header token = 'eyJraWQiOiI0YUpVdlwvQndtaGVjWnB5Q0hHWkRKRkhqbWVRbHI2RHFFaENHcUVvUkljYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIyNmYwYzFhYS00ZWRlLTRjZGUtOWE4OC1jNjkwNTBlODUxNmQiLCJjb2duaXRvOmdyb3VwcyI6WyJEQ0NfVXNlciJdLCJldmVudF9pZCI6ImFmYWUwNWRjLTk0OTctMTFlOC04YjExLWE1OGQ2Njk0NTAyMSIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE1MzMwMjM5ODQsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC51cy1lYXN0LTEuYW1hem9uYXdzLmNvbVwvdXMtZWFzdC0xXzcwcDJXTUJGRSIsImV4cCI6MTUzMzAyNzU4NCwiaWF0IjoxNTMzMDIzOTg0LCJqdGkiOiJjZjQyYTIzYi05MGU0LTQ3OTctYTY5OS05YjA4MjM5ODFmY2MiLCJjbGllbnRfaWQiOiI0MjhlbmU4NnJzdmw1dWgzNjJwa2pwcHYxbyIsInVzZXJuYW1lIjoiYXV0b19zcGVjYWxlcnRzcmlnaHRyYWlsQHFlcm9vZmluZ3N1cHBsaWVzLmNvbSJ9.khdpBUn09GgLRdL3CGkn4UQi53CqbrfSe43IefVGyTUZ0TQIrRw8PLKFIcoZr5QqBujMixKNMKRyMMqKh5lbwiQMs6OsLSEZhY5Z7LQ4I4YpKPe2Ofi8MUmPK8tC-vA1FDUxZ0g9dzJO8uaab4FqvpXVLPVPr3jaMDblA1lnNF61OkqxkmvKUHJOzm8NJ65DuiFhuTYiqEyHTo268Vjl0vuC39MfO5Nsfo7gSPUqcIvop2ENZ1UwXne8ChK4b_dNG2ZA618upVDACnAp0OUrLgNukmtLY4LgVhSLnjItKkypx-LVSAPqIxaTE-DTLBT7yKiKV8KMCTgxBSk_7x57ug'
    When method POST
    Then status 400
    And match response.message == "Access Token has expired"
    And match response.status == "Bad Request"

  Scenario: SSO-T27: POST/sso/signout-With Empty Accesstoken
    # Provide blank access token in Header
    Given request {}
    And header token = ''
    When method POST
    Then status 400
    And match response.message == "email/passwords should not be blank"
    And match response.status == "Bad Request"

  Scenario: SSO-T28: POST/sso/signout-With invalid resource path
    # Provide incorrect resource  name as "signouts" instead of "signout"
    Given request {}
    And header token = ''
    And path ssoBase + '/signouts'
    When method GET
    Then status 404
    And match response.message == "No message available"
    And match response.error == "Not Found"

  Scenario: SSO-T67: POST/sso/signout-With invalid access token
    # Provide Invalid Access Token
    Given request {}
    And header token = 'eyJraWQiOiJKbFdnTFIxR3BmNWlkQ2NJUDVYbFBodHlZTHdjR2NTZ1k1N2JTczZianRnPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJiNjZiODYyYi0zM2M5LTQ3NzctYTliMi1hNThiNGJmZGMyZWYiLCJjb2duaXRvOmdyb3VwcyI6WyJEQ0NfVXNlciJdLCJldmVudF9pZCI6IjU2MWUwN2QxLTk4ZDMtMTFlOC1iNTdhLWExYzdjNjQ4ODA1NyIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE1MzM0ODk0MDgsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC51cy1lYXN0LTEuYW1hem9uYXdzLmNvbVwvdXMtZWFzdC0xX0VpdzdiRE1sQiIsImV4cCI6MTUzMzQ5MzAwOCwiaWF0IjoxNTMzNDg5NDA4LCJqdGkiOiI0YTFmYzkyMi0wMTk1LTQxNjgtOWJhOC1iYzQ1NTVhMTU4M2EiLC'
    When method POST
    Then status 400
    And match response.message == "Invalid Access Token"
    And match response.status == "Bad Request"
