*** Settings ***
Library    Browser
Resource    ../pages/practice_test_login.robot
Resource    ../pages/logged_in_successfully.robot

*** Variables ***
${BROWSER}          chromium
${BASE_URL}         https://practicetestautomation.com/practice-test-login
${TIMEOUT}          15s
${USERNAME}         student
${PASSWORD}         Password123
${login_message}     Logged In Successfully
${login_message_locator}    css=h1.post-title
${login_page_title}    Practice Test Login Page
${logged_in_successfully_url}    https://practicetestautomation.com/logged-in-successfully/
${login_success_text}    Congratulations ${USERNAME}. You successfully logged in!
${username_error_message}    Your username is invalid!
${password_error_message}    Your password is invalid!
${invalid_username}    incorrectUser
${invalid_password}    incorrectPassword
${wrong_case_username}    Student
${wrong_case_password}    password123

*** Keywords ***
Open Browser To practicetestautomation
    New Browser    ${BROWSER}    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${BASE_URL}
    Wait For Load State    networkidle    timeout=${TIMEOUT}

Close Browser Session
    Close Browser

login to practicetestautomation
    Fill Text    id=username    ${USERNAME}
    Fill Text    id=password    ${PASSWORD}
    click    id=submit

Launch Browser And Login To practicetestautomation
    Open Browser To practicetestautomation
    login to practicetestautomation
 
verify login page loads
    Wait For Elements State   ${login_message_locator}     visible    ${TIMEOUT}
    ${actual_message}=    Get Text    ${login_message_locator}
    Should Be Equal    ${actual_message}    ${login_message}

Open Practice Test Login Page
    Go To    ${BASE_URL}
    Wait For Load State    networkidle    timeout=${TIMEOUT}
    Verify Login Form Is Displayed

Enter Student Password
    [Documentation]    Types the student password without writing it to the log.
    Fill Secret    ${LOGIN_PASSWORD_INPUT}    $PASSWORD

Verify Logged In Successfully Page Is Displayed
    Verify Logged In Successfully Url
    verify login page loads
    Get Text    body    *=    ${login_success_text}
    Verify Log Out Link Is Visible

Verify Login Is Refused With Error
    [Arguments]    ${expected_error}    ${operator}=equal
    Verify Login Error Message    ${expected_error}    ${operator}
    Verify User Is On Login Page

Record Direct Access To Logged In Successfully Page
    [Documentation]    KAN-2 TC-2 last step, for information only: opens the success page without logging in and logs whether it can be reached, for the product owner. It does not fail the test.
    Go To    ${logged_in_successfully_url}
    Wait For Load State    networkidle    timeout=${TIMEOUT}
    ${heading_count}=    Get Element Count    ${login_message_locator}
    IF    ${heading_count} > 0
        Log    KAN-2: ${logged_in_successfully_url} can be reached directly without logging in (heading '${login_message}' is shown). Report this to the product owner.    WARN
    ELSE
        Log    KAN-2: ${logged_in_successfully_url} cannot be reached directly without logging in.
    END

Student Logs In With Valid Credentials And Logs Out
    [Documentation]    KAN-2 TC-1: The student logs in with valid credentials, reaches the success page and logs out to an empty login page.
    Open Practice Test Login Page
    Enter Login Username    ${USERNAME}
    Verify Login Username Field Shows    ${USERNAME}
    Enter Student Password
    Verify Login Password Field Is Masked
    Click Login Submit Button
    Verify Logged In Successfully Page Is Displayed
    Click Log Out Link
    Verify User Is On Login Page
    Verify Login Form Is Displayed
    Verify Login Fields Are Empty

Login Is Refused For Invalid Empty And Wrong Case Credentials
    [Documentation]    KAN-2 TC-2: Login is refused for invalid, empty and wrong-case credentials. Each attempt starts on a freshly loaded login page, so the check cannot pass on an error message left over from the previous attempt.
    # Unknown username with the valid password
    Open Practice Test Login Page
    Enter Login Username    ${invalid_username}
    Enter Student Password
    Click Login Submit Button
    Verify Login Is Refused With Error    ${username_error_message}
    # Valid username with a wrong password
    Open Practice Test Login Page
    Enter Login Username    ${USERNAME}
    Enter Login Password    ${invalid_password}
    Click Login Submit Button
    Verify Login Is Refused With Error    ${password_error_message}
    # Both fields empty
    Open Practice Test Login Page
    Clear Login Fields
    Click Login Submit Button
    Verify Login Is Refused With Error    ${username_error_message}
    # Wrong-case username (capital S)
    Open Practice Test Login Page
    Enter Login Username    ${wrong_case_username}
    Enter Student Password
    Click Login Submit Button
    Verify Login Is Refused With Error    is invalid!    contains
    # Wrong-case password (lower-case p)
    Open Practice Test Login Page
    Enter Login Username    ${USERNAME}
    Enter Login Password    ${wrong_case_password}
    Click Login Submit Button
    Verify Login Is Refused With Error    ${password_error_message}
    # Opening the success page directly (result recorded, not asserted)
    Record Direct Access To Logged In Successfully Page

Valid Student Logs In Sees The Success Page And Logs Out
    [Documentation]    KAN-2 TC-1: Valid student logs in, sees the success page and logs out
    # Open https://practicetestautomation.com/practice-test-login/
    # Verify the page shows a Username field, a Password field and a "Submit" button
    Wait For Elements State    ${TEST_LOGIN_USERNAME}    visible
    Wait For Elements State    ${TEST_LOGIN_PASSWORD}    visible
    Wait For Elements State    ${TEST_LOGIN_SUBMIT}    visible
    # Type "student" into the Username field; verify the field shows "student"
    Fill Text    ${TEST_LOGIN_USERNAME}    ${USERNAME}
    Get Text    body    *=    {{username}}
    # Type "Password123" into the Password field; verify the input is masked
    Fill Secret    ${TEST_LOGIN_PASSWORD}    $PASSWORD
    Wait For Elements State    ${TEST_LOGIN_PASSWORD}    visible
    # Click "Submit"
    Click    ${TEST_LOGIN_SUBMIT}
    Get Text    body    *=    Logged In Successfully
    # Verify the URL contains "/logged-in-successfully/"
    Get Url    *=    /logged-in-successfully/
    # Verify the page heading reads "Logged In Successfully"
    Get Text    body    *=    Logged In Successfully
    # Verify the page text contains "Congratulations student. You successfully logged in!"
    Get Text    body    *=    Congratulations student. You successfully logged in!
    # Verify a "Log out" button is visible
    Wait For Elements State    ${LOGGED_IN_LOG_OUT_LINK}    visible
    # Click "Log out"
    Click    ${LOGGED_IN_LOG_OUT_LINK}
    # Verify the browser returns to the login page (URL contains "/practice-test-login/") with empty Usern
    Get Url    *=    /practice-test-login/
    Wait For Elements State    ${TEST_LOGIN_USERNAME}    visible
    Wait For Elements State    ${TEST_LOGIN_PASSWORD}    visible
    Wait For Elements State    ${TEST_LOGIN_SUBMIT}    visible
