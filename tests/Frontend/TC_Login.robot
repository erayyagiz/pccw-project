*** Settings ***
Documentation           Test Cases related to Login screen in CASE-3
Resource                ../../Keywords/Frontend/Keyword_FE_Login.robot
Force Tags              FRONTEND            LOGIN

Suite Setup             Run Keywords
...                     Register Keyword To Run On Failure       NONE                         AND
...                     Open Portal                                                           AND
...                     Remove Files                             ${DOWNLOAD_DIR}${/}*         AND
...                     Go to Login Screen

Test Setup              Run Keywords
...                     Reload Page                                                           AND
...                     Wait Until Element Is Visible            ${Login_Title_txt}

Test Teardown	        Run Keywords
...                     Run Keyword If Test Failed               Capture Page Screenshot      AND
...                     Remove Files                             ${DOWNLOAD_DIR}${/}*

Suite Teardown	        Run Keywords
...                     Close Browser

*** Variables ***
${DOWNLOAD_DIR}         ${EXEC_DIR}${/}Resources${/}Downloads

*** Test Cases ***

Login to Portal when all entries are empty
    [Tags]                                              Negative
    Login to Portal                                     ${EMPTY}                ${EMPTY}
    Check if is not logged in to Portal                 Your username is invalid!

Login to Portal when Username is empty
    [Tags]                                              Negative
    Login to Portal                                     ${EMPTY}                ${PORTAL_PASSWORD}
    Check if is not logged in to Portal                 Your username is invalid!

Login to Portal when Password is empty
    [Tags]                                              Negative
    Login to Portal                                     ${PORTAL_USERNAME}      ${EMPTY}
    Check if is not logged in to Portal                 Your password is invalid!

Login to Portal when all entries have invalid values
    [Tags]                                              Negative
    ${invalid_username}=                                Generate Random String Values                   5
    ${invalid_password}=                                Generate Random String Values                   5
    Login to Portal                                     ${invalid_username}     ${invalid_username}
    Check if is not logged in to Portal                 Your username is invalid!

Login to Portal when Username has invalid value
    [Tags]                                              Negative
    ${invalid_username}=                                Generate Random String Values                   5
    Login to Portal                                     ${invalid_username}     ${PORTAL_PASSWORD}
    Check if is not logged in to Portal                 Your username is invalid!

Login to Portal when Password has invalid value
    [Tags]                                              Negative
    ${invalid_password}=                                Generate Random String Values                   5
    Login to Portal                                     ${PORTAL_USERNAME}      ${invalid_password}
    Check if is not logged in to Portal                 Your password is invalid!

Login to Portal when all entries have valid values
    [Tags]                                              Positive
    Login to Portal                                     ${PORTAL_USERNAME}      ${PORTAL_PASSWORD}
    Check if user is logged in to Portal successfully
