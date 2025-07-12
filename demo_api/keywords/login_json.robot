*** Keywords ***

Login with json body
    [Arguments]    ${file_name}    ${expect_result}
    common.Create on Session   login_with_json    ${Setting}[local_host]
    ${json_path}    Set Variable   ${CURDIR}/../resources/data_test/json_file/${file_name}
    ${json_body}    common.Load file json   ${json_path}
    ${resp_login}    POST On Session    login_with_json    /login    json=${json_body}    expected_status=${expect_result}
    RETURN    ${resp_login} 
    