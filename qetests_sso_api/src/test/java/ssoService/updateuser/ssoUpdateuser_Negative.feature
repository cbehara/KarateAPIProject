Feature: To Test Negative Scenarios for Updateuser API
  I want to verify the /cc/api/sso/updateuser endpoint returns error codes for negative scenarios
  
  Background: 
    * url baseUrl
  	* path ssoBase + '/updateuser'  
      
  Scenario: SSO-T84: PUT/sso/updateuser-With invalid resource path 
  # Provide incorrect parameter name as "updateusers" instead of "updateuser"
  	Given request read('data/valid-updateuser-body.json')
  	#And header Authorization = auth
    And path ssoBase + '/updateusers'
    When method PUT
    Then status 404
    And match response.error == "Not Found"

	Scenario: SSO-T33: PUT/sso/updateuser-With Expired Access Token
	# Provide incorrect value for expired Access token
  	Given request read('data/valid-updateuser-body.json')
  	And header token = 'eyJraWQiOiI0YUpVdlwvQndtaGVjWnB5Q0hHWkRKRkhqbWVRbHI2RHFFaENHcUVvUkljYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI5YmRlZTVjOC1mMTgzLTQ4ZTQtOTg0OS04Mzg3NDMwZDViNjYiLCJjb2duaXRvOmdyb3VwcyI6WyJEQ0NfVXNlciJdLCJldmVudF9pZCI6ImIwYzRkNDlmLTkxODQtMTFlOC04ZWI2LWRiMDk0OTRiY2UyOSIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE1MzI2ODU5NzIsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC51cy1lYXN0LTEuYW1hem9uYXdzLmNvbVwvdXMtZWFzdC0xXzcwcDJXTUJGRSIsImV4cCI6MTUzMjY4OTU3MiwiaWF0IjoxNTMyNjg1OTcyLCJqdGkiOiJiNTUyZDRhNS03YTM3LTRhYzctODIzNy1hNjY0YjA5OWNjN2EiLCJjbGllbnRfaWQiOiI0MjhlbmU4NnJzdmw1dWgzNjJwa2pwcHYxbyIsInVzZXJuYW1lIjoiY2hha3JhdmFydGhpYmVoYXJhKzM0QGdtYWlsLmNvbSJ9.k-KfiOm2B_vRmX5QtuTzA35H3b33dhQON2F0GpOrbVAL8zO4rcTLf3HOs3rktQ749VpMgXVU4ZoUynVm-0QgN7xAI5zW0ZW0Xq8Vc_YqX5xKAaxz8lKAcZPiGWjq2r3wnVCUuRDVxWZa3esqnA9NM0CF8bnrZienZiFu8QTAwCNXhVshN6k9O1gLJF6FeVGivM8auHh_vsKjSIYeoczhItR44mriyQjhW-DBpIkdPr4Llwxt4fIz0Eelp7qzgK5VcZel885GCGJaCylJwypGs_I0dwTsz9NBaI7uemmhkNSO6NB47UGZ5uxaIZqPdXKM4K6RkA4qIoHq_71Ts0eT8w'
    When method PUT
    Then status 400
    And match response.message == "Access Token has expired"
    