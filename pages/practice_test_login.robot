*** Settings ***
Library    Browser

*** Variables ***
${SMARTBEAR_LOGO}       img[alt*="SmartBear"]
${NAV_MENU}             nav

*** Keywords ***
Verify SmartBear Logo Is Visible
    Wait For Elements State    ${SMARTBEAR_LOGO}    visible    15s

Verify Menu Items Are Displayed
    Wait For Elements State    ${NAV_MENU}    visible    15s
    Get Element Count    ${NAV_MENU} >> a    >=    1
