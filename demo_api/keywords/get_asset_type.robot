*** Settings ***
Library    RequestsLibrary

*** Keywords ***

Get asset type service
    [Arguments]    ${expected_result}
    common.Create on Session    get_asset_type    ${setting}[local_host]
    ${resp_asset_all}    GET On Session    get_asset_type    /assetType
    RETURN     ${resp_asset_all}