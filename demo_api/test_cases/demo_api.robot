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

TC_012 Modify data index 5
    ${resp_login}    Login_keyword.Login Session    ${request_body}[valid][username]    ${request_body}[valid][password]    200
    ${resp_modify_json}    modify_asset.Modify asset    ${resp_login.json()['message']}    a006    macbook pro m1 update    2    false    200
    ${resp_get_all_asset}    get_all_asset.Send service get all asset    ${resp_login.json()['message']}    200
    ${last_assetName}    common.Get data from json by index    ${resp_get_all_asset.json()}    5    assetName
    ${last_assetType}    common.Get data from json by index    ${resp_get_all_asset.json()}    5    assetType
    ${last_assetType_string}    common.Convert data to string    ${last_assetType}
    ${last_inUse}    common.Get data from json by index    ${resp_get_all_asset.json()}    5    inUse
    ${last_inUse_string}    common.Convert data to string    ${last_inUse}
    common.Check Should be equal    ${last_assetName}    macbook pro m1 update
    common.Check Should be equal    ${last_assetType_string}    2
    common.Check Should be equal with ignore case    ${last_inUse_string}    false    ignore_case=True



TC_013 Delete asset
    ${resp_login}    Login_keyword.Login Session    ${request_body}[valid][username]    ${request_body}[valid][password]    200
    ${resp_delete}    Delete_asset.Delete asset    ${resp_login.json()['message']}    a006    200
    common.Check Should be equal    ${resp_delete.json()['status']}    success
    common.Check should be empty    ${resp_delete.json()['message']}
    ${resp_get_all_asset}    get_all_asset.Send service get all asset    ${resp_login.json()['message']}    200
    ${length_of_resp_get_all_aseet}    common.Check json data after delete    ${resp_get_all_asset.json()}
    common.Check should be true    ${length_of_resp_get_all_aseet} < 6



TC_014 Get Assete Type
    ${resp_all_asset}    get_asset_type.Get asset type service    200
    ${resp_all_asset_length}    Get Length    ${resp_all_asset.json()}
    IF    ${resp_all_asset_length} > 0
        Log    Have data
        FOR    ${counter}    IN RANGE    0    ${resp_all_asset_length}
            Log    ${counter}
            ${data_typeid}    common.Get data from json by index    ${resp_all_asset.json()}     ${counter}    typeId
            ${data_typeName}    common.Get data from json by index    ${resp_all_asset.json()}    ${counter}   typeName
            Log    ${data_typeid}
            Log    ${data_typeName}
            ${data_typeid_string}    common.Convert data to string    ${data_typeid}
            # # สร้างตัวแปรชื่อ dynamic เช่น ${data_typeid_0}, ${data_typeName_0}
            # ${data_typeid_counter}    Set Variable    data_type_${counter}
            # Set Test Variable    ${data_typeid_counter}    ${data_typeid_string}
            # ${data_typeName_counter}    Set Variable    data_name_${counter}
            # Set Test Variable    ${data_typeName_counter}    ${data_typeName}
            IF    ${counter} == 0
                common.Check Should be equal    ${data_typeid_string}    1
                common.Check Should be equal    ${data_typeName}    laptop
            ELSE
                common.Check Should be equal    ${data_typeid_string}    2
                common.Check Should be equal    ${data_typeName}    mobile
            END            
        END
            Log    End loop
    ELSE
        Log   No data
    END