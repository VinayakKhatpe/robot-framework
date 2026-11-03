*** Settings ***
Library    Browser

*** Variables ***
${SMARTBEAR_LOGO}       img[alt*="SmartBear"]
${NAV_MENU}             nav
${LOGIN_HEADING}            role=heading[name="Test login"]
${LOGIN_USERNAME_INPUT}     id=username
${LOGIN_PASSWORD_INPUT}     id=password
${LOGIN_SUBMIT_BUTTON}      id=submit
${LOGIN_ERROR_MESSAGE}      id=error
${LOGIN_PAGE_PATH}          practicetestautomation.com/practice-test-login
${TEST_LOGIN_USERNAME}    role=textbox[name="Username"]
${TEST_LOGIN_PASSWORD}    role=textbox[name="Password"]
${TEST_LOGIN_SUBMIT}    role=button[name="Submit"]

*** Keywords ***
Verify SmartBear Logo Is Visible
    Wait For Elements State    ${SMARTBEAR_LOGO}    visible    15s

Verify Menu Items Are Displayed
    Wait For Elements State    ${NAV_MENU}    visible    15s
    Get Element Count    ${NAV_MENU} >> a    >=    1

Verify Login Form Is Displayed
    Wait For Elements State    ${LOGIN_HEADING}    visible    15s
    Wait For Elements State    ${LOGIN_USERNAME_INPUT}    visible    15s
    Wait For Elements State    ${LOGIN_PASSWORD_INPUT}    visible    15s
    Wait For Elements State    ${LOGIN_SUBMIT_BUTTON}    visible    15s

Enter Login Username
    [Arguments]    ${username}
    Fill Text    ${LOGIN_USERNAME_INPUT}    ${username}

Enter Login Password
    [Documentation]    For negative test data only. The real password is typed with Fill Secret in resources/practice_test_login.robot.
    [Arguments]    ${password}
    Fill Text    ${LOGIN_PASSWORD_INPUT}    ${password}

Clear Login Fields
    Fill Text    ${LOGIN_USERNAME_INPUT}    ${EMPTY}
    Fill Text    ${LOGIN_PASSWORD_INPUT}    ${EMPTY}

Click Login Submit Button
    Click    ${LOGIN_SUBMIT_BUTTON}

Verify Login Username Field Shows
    [Arguments]    ${expected_username}
    Get Property    ${LOGIN_USERNAME_INPUT}    value    ==    ${expected_username}

Verify Login Password Field Is Masked
    Get Attribute    ${LOGIN_PASSWORD_INPUT}    type    ==    password

Verify Login Fields Are Empty
    Get Property    ${LOGIN_USERNAME_INPUT}    value    ==    ${EMPTY}
    Get Property    ${LOGIN_PASSWORD_INPUT}    value    ==    ${EMPTY}

Verify Login Error Message
    [Arguments]    ${expected_error}    ${operator}=equal
    Wait For Elements State    ${LOGIN_ERROR_MESSAGE}    visible    15s
    Get Text    ${LOGIN_ERROR_MESSAGE}    ${operator}    ${expected_error}

Verify User Is On Login Page
    Get Url    *=    ${LOGIN_PAGE_PATH}
    Wait For Elements State    ${LOGIN_SUBMIT_BUTTON}    visible    15s
