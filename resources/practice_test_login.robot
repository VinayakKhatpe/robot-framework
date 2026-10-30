*** Settings ***
Library    Browser

*** Variables ***
${BROWSER}          chromium
${BASE_URL}         https://practicetestautomation.com/practice-test-login
${TIMEOUT}          15s
${USERNAME}         student
${PASSWORD}         Password123
${login_message}     Logged In Successfully
${login_message_locator}    css=h1.post-title



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
