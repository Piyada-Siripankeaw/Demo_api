*** Settings ***
Library    RequestsLibrary
*** Keywords ***

Create on Session
    [Arguments]    ${alias}    ${url}
    Create Session    ${alias}    ${url}

Check Should be equal
    [Arguments]    ${first}    ${second}
    Should be equal    ${first}    ${second}
Check response code
    [Arguments]    ${expected_status}    ${response}
    Status Should Be    ${expected_status}    ${response}

Check should be empty
    [Arguments]    ${expect_empty}
    Should Be Empty    ${expect_empty}

Convert integer to string
    [Arguments]    ${item}
    ${convert_to_string}    Convert To String    ${item}
    RETURN   ${convert_to_string}
