*** Settings ***

#Library
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

#Keyword
Resource    ${CURDIR}/../keywords/login_keyword.robot
Resource    ${CURDIR}/../keywords/common.robot
Resource    ${CURDIR}/../keywords/get_all_asset.robot
Resource    ${CURDIR}/../keywords/create_new_asset.robot
Resource    ${CURDIR}/../keywords/delete_asset.robot
Resource    ${CURDIR}/../keywords/get_asset_type.robot
Resource    ${CURDIR}/../keywords/modify_asset.robot
Resource     ${CURDIR}/../keywords/login_json.robot

#data test
Variables    ${CURDIR}/data_test/setting.yaml
