*** Settings ***

#Library
Library    RequestsLibrary

#Keyword
Resource    ${CURDIR}/../keywords/login_keyword.robot
Resource    ${CURDIR}/../keywords/common.robot


#data test
Variables    ${CURDIR}/data_test/setting.yaml

