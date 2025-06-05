*** Settings ***
Resource    ${CURDIR}/../resources/import.robot

*** Keywords ***
Print Header Values
    [Arguments]    ${headers}
    Log     ${headers['Content-Type']}
    Log     ${headers['Authorization']}

*** Test Cases ***
Unpack Dictionary To Keyword
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer abc123
    Print Header Values    ${headers}
