String selectedCountryCode = '+1';
String enteredNumber = '';

String backendURL = '50.19.21.57';

//Fetched User Variables
String NUMBER = '';// ignore: non_constant_identifier_names
String NAME = '';// ignore: non_constant_identifier_names
String IMAGE = '';// ignore: non_constant_identifier_names
String DOB = '';// ignore: non_constant_identifier_names
String GENDER = '';// ignore: non_constant_identifier_names
String CURRENCY_CODE = '';// ignore: non_constant_identifier_names
String SYMBOL = '';// ignore: non_constant_identifier_names
String BALANCE = ' --';// ignore: non_constant_identifier_names
String PIN = '';// ignore: non_constant_identifier_names
String ReloadlyUrl = 'https://topups-sandbox.reloadly.com/';
// String authToken = 'eyJraWQiOiI1N2JjZjNhNy01YmYwLTQ1M2QtODQ0Mi03ODhlMTA4OWI3MDIiLCJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3MjI1IiwiaXNzIjoiaHR0cHM6Ly9yZWxvYWRseS1zYW5kYm94LmF1dGgwLmNvbS8iLCJodHRwczovL3JlbG9hZGx5LmNvbS9zYW5kYm94Ijp0cnVlLCJodHRwczovL3JlbG9hZGx5LmNvbS9wcmVwYWlkVXNlcklkIjoiNzIyNSIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyIsImF1ZCI6Imh0dHBzOi8vdG9wdXBzLWhzMjU2LXNhbmRib3gucmVsb2FkbHkuY29tIiwibmJmIjoxNjIwMDUzNzQ1LCJhenAiOiI3MjI1Iiwic2NvcGUiOiJzZW5kLXRvcHVwcyByZWFkLW9wZXJhdG9ycyByZWFkLXByb21vdGlvbnMgcmVhZC10b3B1cHMtaGlzdG9yeSByZWFkLXByZXBhaWQtYmFsYW5jZSByZWFkLXByZXBhaWQtY29tbWlzc2lvbnMiLCJleHAiOjE2MjAxNDAxNDUsImh0dHBzOi8vcmVsb2FkbHkuY29tL2p0aSI6Ijc0ODBhYjI5LTljNDktNGU3YS1hMWU1LWFmYzgzMTBhZWExZCIsImlhdCI6MTYyMDA1Mzc0NSwianRpIjoiYTgwMDE2NmYtM2ViNy00YzJjLWFlOWQtYWI2NzU2Y2E4MjU2In0.rHq7PvzbODpwiPPsYJkM1ZM5zv_qGv0QJ-GSSfLE2w0';
String tokenType = 'Bearer';
String authToken = 'eyJraWQiOiI1N2JjZjNhNy01YmYwLTQ1M2QtODQ0Mi03ODhlMTA4OWI3MDIiLCJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3MjI1IiwiaXNzIjoiaHR0cHM6Ly9yZWxvYWRseS1zYW5kYm94LmF1dGgwLmNvbS8iLCJodHRwczovL3JlbG9hZGx5LmNvbS9zYW5kYm94Ijp0cnVlLCJodHRwczovL3JlbG9hZGx5LmNvbS9wcmVwYWlkVXNlcklkIjoiNzIyNSIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyIsImF1ZCI6Imh0dHBzOi8vdG9wdXBzLWhzMjU2LXNhbmRib3gucmVsb2FkbHkuY29tIiwibmJmIjoxNjIwMTQ4MjE4LCJhenAiOiI3MjI1Iiwic2NvcGUiOiJzZW5kLXRvcHVwcyByZWFkLW9wZXJhdG9ycyByZWFkLXByb21vdGlvbnMgcmVhZC10b3B1cHMtaGlzdG9yeSByZWFkLXByZXBhaWQtYmFsYW5jZSByZWFkLXByZXBhaWQtY29tbWlzc2lvbnMiLCJleHAiOjE2MjAyMzQ2MTgsImh0dHBzOi8vcmVsb2FkbHkuY29tL2p0aSI6ImFlNDlkZWJkLTNhOTYtNDFkMC1iMjczLTAwYmNmNTk1MmU4NSIsImlhdCI6MTYyMDE0ODIxOCwianRpIjoiMjdmN2RiNzktMDM2Yy00NzJhLTlmYjQtYmYzN2FhMTc1YTQ2In0.jwkm02xiNq2XDsmtN2rbw2tkH4Sdttq4cX6Z9QwRC30';