*** Keywords ***

Create on Session
    [Arguments]    ${alias}    ${url}
    Create Session    ${alias}    ${url}

Check Should be equal
    [Arguments]    ${first}    ${second}
    Should be equal    ${first}    ${second}

Check Should be equal with ignore case
    [Arguments]    ${first}    ${second}    ${ignore_case}
    Should be equal    ${first}    ${second}    ignore_case=${ignore_case}

Check response code
    [Arguments]    ${expected_status}    ${response}
    Status Should Be    ${expected_status}    ${response}

Check should be empty
    [Arguments]    ${expect_empty}
    Should Be Empty    ${expect_empty}

Convert data to string
    [Arguments]    ${item}
    ${convert_to_string}    Convert To String    ${item}
    RETURN   ${convert_to_string}

Get data from json by index
    [Arguments]    ${resp_json}    ${index}    ${field_name}
    ${resp_full_data_from_index}    Get from List    ${resp_json}    ${index}
    ${resp_data_from_index}    Get from Dictionary    ${resp_full_data_from_index}    ${field_name}
    RETURN    ${resp_data_from_index}

Check json data after delete
    [Arguments]    ${item}
    ${resp_data_json}    Get Length    ${item}
    RETURN    ${resp_data_json}

Check should be true
    [Arguments]    ${condition}
    Should be true   ${condition} 

Load file json
    [Arguments]    ${file_name}
    ${json}    Load Json From File    ${file_name}
    RETURN    ${json}        

Check should not be empty
    [Arguments]    ${item}
    Should Not Be Empty    ${item}    