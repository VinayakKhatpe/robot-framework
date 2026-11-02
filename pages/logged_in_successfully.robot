*** Settings ***
Library    Browser

*** Variables ***
${LOGGED_IN_LOG_OUT_LINK}    role=link[name="Log out"]
${LOGGED_IN_PAGE_PATH}       practicetestautomation.com/logged-in-successfully/

*** Keywords ***
Verify Logged In Successfully Url
    Get Url    *=    ${LOGGED_IN_PAGE_PATH}

Verify Log Out Link Is Visible
    Wait For Elements State    ${LOGGED_IN_LOG_OUT_LINK}    visible    15s

Click Log Out Link
    Click    ${LOGGED_IN_LOG_OUT_LINK}
