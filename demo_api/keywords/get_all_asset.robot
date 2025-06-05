*** Keywords ***

Send service get all asset
    [Arguments]    ${token_login}    ${expect_status} 
    common.Create on Session    getallasset    ${setting}[local_host]
    ${header}    Create Dictionary    token=${token_login}
    ${resp_asset}    Get on Session    getallasset    /assets    headers=${header}   expected_status=${expect_status}
    RETURN    ${resp_asset}