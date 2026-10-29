*** Settings ***
Resource    ../resources/common.robot
Resource    ../pages/smartbear_home_page.robot

Suite Setup       Open Browser To SmartBear
Suite Teardown    Close Browser Session

*** Test Cases ***
Verify SmartBear Page Loads With Logo
    [Documentation]    Verifies the SmartBear logo is visible on the homepage
    [Tags]    smoke
    Verify SmartBear Logo Is Visible

Verify SmartBear Page Loads With Menu Items
    [Documentation]    Verifies navigation menu items are displayed on the homepage
    [Tags]    smoke
    Verify Menu Items Are Displayed
