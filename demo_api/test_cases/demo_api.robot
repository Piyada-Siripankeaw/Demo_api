*** Settings ***
Resource    ${CURDIR}/../resources/import.robot

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
    ${Expect_status_int}    common.Convert data to string    ${resp_login.json()['status']}
    Log    ${Expect_status_int}
    common.Check Should be equal    ${Expect_status_int}    500
    common.Check Should be equal    ${resp_login.json()['error']}    Internal Server Error
    common.Check should be empty    ${resp_login.json()['message']}


TC-006 login fail (password = null)
    ${resp_login}    login_keyword.login Session    ${request_body}[valid][username]    ${request_body}[invalid_null][password]    500
    ${Expect_status_int}    common.Convert data to string    ${resp_login.json()['status']}
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

TC-010 Create new asset
    ${resp_login}    Login_keyword.Login Session    ${request_body}[valid][username]    ${request_body}[valid][password]   200
    create_new_asset.Send service create new asset    ${resp_login.json()['message']}    a006    macbook pro m1    1   true    200

TC-011 Verify data index 5 (create new asset) 
    ${resp_login}    Login_keyword.Login Session    ${request_body}[valid][username]    ${request_body}[valid][password]    200
    ${resp_all_asset}    get_all_asset.Send service get all asset    ${resp_login.json()['message']}    200
    ${resp_all_asset_data_from_index_assetId}    common.Get data from json by index    ${resp_all_asset.json()}    5    assetId
    ${resp_all_asset_data_from_index_assetName}    common.Get data from json by index    ${resp_all_asset.json()}    5    assetName
    ${resp_all_asset_data_from_index_assetType}    common.Get data from json by index    ${resp_all_asset.json()}    5    assetType
    ${resp_all_asset_data_from_index_inUse}    common.Get data from json by index    ${resp_all_asset.json()}    5    inUse
    common.Check Should be equal    ${resp_all_asset_data_from_index_assetId}     a006
    common.Check Should be equal    ${resp_all_asset_data_from_index_assetName}    macbook pro m1
    ${final_data_resp_all_asset_data_from_index_assetType}    common.Convert data to string    ${resp_all_asset_data_from_index_assetType}
    common.Check Should be equal    ${final_data_resp_all_asset_data_from_index_assetType}    1
    ${final_data_resp_all_asset_data_from_index_inUse}    common.Convert data to string    ${resp_all_asset_data_from_index_inUse}
    Log    ${final_data_resp_all_asset_data_from_index_inUse} 
    common.Check Should be equal with ignore case    ${final_data_resp_all_asset_data_from_index_inUse}    true    ignore_case=True

    

