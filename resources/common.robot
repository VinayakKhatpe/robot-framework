*** Settings ***
Library    Browser

*** Variables ***
${BROWSER}          chromium
${BASE_URL}         https://smartbear.com/
${TIMEOUT}          15s

*** Keywords ***
Open Browser To SmartBear
    New Browser    ${BROWSER}    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${BASE_URL}
    Wait For Load State    networkidle    timeout=${TIMEOUT}

Close Browser Session
    Close Browser
