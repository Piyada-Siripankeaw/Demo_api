*** Settings ***

Resource    ${CURDIR}/../resources/import.robot

*** Test Cases ***
TC-001 Login Success
    [Tags]    login_testcase    
    ${resp}    login_json.Login with json body   login_success.json    200
    common.Check Should be equal    ${resp.json()['status']}    success
    common.Check should not be empty    ${resp.json()['message']}

TC-002 Login fail with invalid username
    [Tags]    login_testcase    
    ${resp}    login_json.Login with json body    login_invalid_username.json    401
    common.Check Should be equal    ${resp.json()['status']}    error
    common.Check Should be equal    ${resp.json()['message']}    invalid username or password

TC-003 Login fail with invalid password
    [Tags]    login_testcase    
    ${resp}    login_json.Login with json body    login_invalid_password.json    401
    common.Check Should be equal    ${resp.json()['status']}    error
    common.Check Should be equal    ${resp.json()['message']}    invalid username or password

TC-004 Login fail with empty username
    [Tags]    login_testcase    
    ${resp}    login_json.Login with json body    login_empty_username.json    401
    common.Check Should be equal    ${resp.json()['status']}    error
    common.Check Should be equal    ${resp.json()['message']}    invalid username or password


TC-005 Login fail with empty password
    [Tags]    login_testcase    
    ${resp}    login_json.Login with json body    login_empty_password.json    401
    common.Check Should be equal    ${resp.json()['status']}    error
    common.Check Should be equal    ${resp.json()['message']}    invalid username or password

TC-006 Login fail with empty username and password
    [Tags]    login_testcase
    ${resp}    login_json.Login with json body    login_empty_username and password.json    401
    common.Check Should be equal    ${resp.json()['status']}    error
    common.Check Should be equal    ${resp.json()['message']}    invalid username or password 