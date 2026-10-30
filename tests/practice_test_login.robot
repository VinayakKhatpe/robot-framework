*** Settings ***
Resource    ../resources/practice_test_login.robot
Resource    ../pages/practice_test_login.robot

Suite Setup       Launch Browser And Login To practicetestautomation
Suite Teardown    Close Browser Session

*** Test Cases ***
Verify login page loads positive test
    [Tags]    smoke
    [Documentation]    Verifies login page loads successfully
    verify login page loads
    


