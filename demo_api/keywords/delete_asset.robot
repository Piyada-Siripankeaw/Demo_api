*** Keywords ***

Delete asset
    [Arguments]    ${token_login}    ${assetId}    ${expected_result}
    common.Create on Session    delete_asset    ${Setting}[local_host]
    ${header}    Create Dictionary    token=${token_login}
    ${resp_delete}    DELETE On Session    delete_asset    /assets/${assetId}    headers=${header}
    RETURN    ${resp_delete}
