*** Settings ***

#Library
Library    RequestsLibrary
Library    Collections

#Keyword
Resource    ${CURDIR}/../keywords/login_keyword.robot
Resource    ${CURDIR}/../keywords/common.robot
Resource    ${CURDIR}/../keywords/get_all_asset.robot
Resource    ${CURDIR}/../keywords/create_new_asset.robot
Resource    ${CURDIR}/../keywords/delete_asset.robot
Resource    ${CURDIR}/../keywords/get_asset_type.robot
Resource    ${CURDIR}/../keywords/modify_asset.robot

#data test
Variables    ${CURDIR}/data_test/setting.yaml

