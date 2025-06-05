*** Settings ***
Resource    common.robot
*** Keywords ***

Send service create new asset
    [Arguments]    ${token_login}    ${assetId}    ${assetName}    ${assetType}    ${inUse}    ${expected_status}
    common.Create on Session    create_new_asset    ${setting}[local_host]
    ${header}    Create Dictionary    token=${token_login}
    ${request_body}    Create Dictionary    assetId=${assetId}    assetName=${assetName}    assetType=${assetType}    inUse=${inUse}        
    ${resp_create_new_asset}    POST On Session    create_new_asset    /assets    headers=${header}    json=${request_body}    expected_status=${expected_status}
    RETURN    ${resp_create_new_asset}