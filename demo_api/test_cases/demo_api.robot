*** Settings ***
Resource    ${CURDIR}/../resources/import.robot
Resource    ../keywords/get_all_asset.robot

*** Variables ***


*** Test Cases ***

TC-001 Verify when input wrong username or password
    common.Create on Session    loginSession    ${Setting}[local_host]
    ${request_body}    Create Dictionary    username=${request_body}[invalid][username]    password=${request_body}[invalid][password]
    ${resp}    POST On Session    loginSession    /login    json=${request_body}   expected_status=401
    Log To Console    ${resp.json()}
    Should be equal    ${resp.json()['status']}    error
    Should be equal    ${resp.json()['message']}    invalid username or password

TC-002 Login success
    ${resp_login}    login_keyword.Login Session    ${request_body}[valid][username]    ${request_body}[valid][password]    200
    common.Check Should be equal    ${resp_login.json()['status']}    success

TC-003 login fail (invalid username)
    ${resp_login}    login_keyword.login Session    ${request_body}[invalid][username]    ${request_body}[valid][password]    401
    common.Check Should be equal    ${resp_login.json()['status']}    error
    common.Check Should be equal    ${resp_login.json()['message']}    invalid username or password

TC-004 login fail (invalid password)
    ${resp_login}    login_keyword.login Session    ${request_body}[valid][username]    ${request_body}[invalid][password]    401
    common.Check Should be equal    ${resp_login.json()['status']}    error
    common.Check Should be equal    ${resp_login.json()['message']}    invalid username or password

TC-005 login fail (username = null)
    ${resp_login}    login_keyword.login Session    ${request_body}[invalid_null][username]    ${request_body}[valid][password]    500
    ${Expect_status_int}    common.Convert integer to string    ${resp_login.json()['status']}
    Log    ${Expect_status_int}
    common.Check Should be equal    ${Expect_status_int}    500
    common.Check Should be equal    ${resp_login.json()['error']}    Internal Server Error
    common.Check should be empty    ${resp_login.json()['message']}


TC-006 login fail (password = null)
    ${resp_login}    login_keyword.login Session    ${request_body}[valid][username]    ${request_body}[invalid_null][password]    500
    ${Expect_status_int}    common.Convert integer to string    ${resp_login.json()['status']}
    Log    ${Expect_status_int}
    common.Check Should be equal    ${Expect_status_int}    500
    common.Check Should be equal    ${resp_login.json()['error']}    Internal Server Error
    common.Check should be empty    ${resp_login.json()['message']}


#TC GET all asset
TC-007 Get all asset success
    ${resp_login}    login_keyword.Login Session    ${request_body}[valid][username]    ${request_body}[valid][password]    200
    ${token_from_login}    Set Variable    ${resp_login.json()['message']}
    Log    ${token_from_login} 
    get_all_asset.Send service get all asset    ${token_from_login}    200

TC-008 Get all asset fail (invalid token)
    get_all_asset.Send service get all asset    ${header}[invalid][token_random]    401

TC-009 Get all asset fail {token=null}
    get_all_asset.Send service get all asset    ${header}[invalid][token_null]    401



# TC-00X Verfiy that can get asset list from get api correctly
#     common.Create on Session    loginSession    ${Setting}[local_host]
#     ${request_body}    Create Dictionary    username=${request_body}[valid][username]    password=${request_body}[valid][password]
#     ${resp}    POST On Session    loginSession    /login    json=${request_body}   expected_status=200
#     ${token}    Set Variable    ${resp.json()['message']}
#     Log    ${token}

#     common.Create on Session    getAsset    ${Setting}[local_host]
#     ${header}    Create Dictionary    token=${token}
#     ${resp_asset}    GET On Session    getAsset   /assets    headers=${header}    expected_status=200
    


    

