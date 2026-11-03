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
    

TC-1 Student Logs In With Valid Credentials And Logs Out
    [Tags]    KAN-2    TC-1    smoke    functional
    [Documentation]    KAN-2 TC-1: Valid credentials reach the success page with the success message and the Log out link. Logging out returns to an empty login page.
    Student Logs In With Valid Credentials And Logs Out

TC-2 Login Is Refused For Invalid Empty And Wrong Case Credentials
    [Tags]    KAN-2    TC-2    regression    negative    edge
    [Documentation]    KAN-2 TC-2: Invalid, empty and wrong-case credentials never log the user in. Each attempt stays on the login page with the matching error.
    Login Is Refused For Invalid Empty And Wrong Case Credentials

TC-1 Valid student logs in, sees the success page and logs out
    [Tags]    KAN-2    TC-1    Smoke    Functional
    Valid Student Logs In Sees The Success Page And Logs Out
