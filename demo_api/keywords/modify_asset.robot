*** Keywords ***

Modify asset
    [Arguments]    ${token_login}    ${assetId}    ${assetName}    ${assetType}    ${inUse}    ${expected_result}
    common.Create on Session    modify_asset    ${setting}[local_host]
    ${header}    Create Dictionary    token=${token_login}    
    ${request_body}    Create Dictionary    assetId=${assetId}    assetName=${assetName}    assetType=${assetType}    inUse=${inUse}
    ${resp_modify_asset}    PUT On Session    modify_asset    /assets    headers=${header}    json=${request_body}    expected_status=${expected_result}
    RETURN    ${resp_modify_asset}