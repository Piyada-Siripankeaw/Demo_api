*** Keywords ***

Login Session
    [Arguments]    ${username}    ${password}    ${expect_status}    #${expect_status_json}    ${expect_message_json}  
    common.Create on Session    loginSession    ${Setting}[local_host]
    ${request_body}    Create Dictionary    username=${username}   password=${password}
    ${resp_login}    POST On Session    loginSession    /login    json=${request_body}    expected_status=${expect_status}
    [RETURN]    ${resp_login}
   #${last_response_code}    Set Variable    ${resp_login.status_code}
    #IF    ${last_response_code} == '200'
    #    common.Check Should be equal    ${resp_login.json()['status']}    ${expect_status_json}
    #ELSE
    #    common.Check Should be equal    ${resp_login.json()['status']}    ${expect_status_json}
    #common.Check Should be equal    ${resp_login.json()['message']}    ${expect_message_json} 
    #END
      
