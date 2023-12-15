*** Settings ***
Documentation       Documentation for Common Keywords used in CASE-3 tests

Library             SeleniumLibrary
Library             Collections
Library             OperatingSystem
Library             Process
Library             String
Library             ../../Lib/utility.py
Resource            ../Keyword_Common.robot
Resource            ../../Resources/Global_Properties.robot

*** Variables ***
${Element_Timeout}      30s

*** Keywords ***

Open Portal
    [Documentation]         Keyword to launch Portal login page in maximized size browser window.
    ${CHROME_OPTIONS}=      Evaluate
            ...             sys.modules['selenium.webdriver'].ChromeOptions()
            ...             sys, selenium.webdriver
    ${prefs}=               Create Dictionary
            ...             download.default_directory=${DOWNLOAD_DIR}      safebrowsing.enabled=false
    Call Method
            ...             ${CHROME_OPTIONS}
            ...             add_experimental_option
            ...             prefs
            ...             ${prefs}
    ${driver_path}=         Get Driver Path
            ...             ${BROWSER_TYPE}
    Open Browser
            ...             url=${BASE_URL}
            ...             browser=${BROWSER_TYPE}
            ...             options=${CHROME_OPTIONS}
            ...             executable_path=${driver_path}
    Maximize Browser Window

Wait and Input Text
    [Documentation]                     Keyword to input text after waiting till object appears and input text
            ...                         \n ``locator``    locator of the webelement
            ...                         \n ``text``    text value to be inserted in webelement
    [Arguments]                         ${locator}        ${text}           ${press_key}=${EMPTY}
    Wait until Page Contains Element    ${locator}        timeout=${Element_Timeout}
    Scroll Element Into View            ${locator}
    Sleep                               0.3s
    Input Text                          ${locator}        ${text}
    IF                                  "${press_key}" != "${EMPTY}"
                                        Sleep             0.4s
                                        Press Keys        None              ${press_key}
    END

Wait And Click Element
    [Documentation]                     Keyword to wait for element to be visible before clicking the element
            ...                         \n ``locator``    locator of the webelement
            ...                         \n ``press_key``  if wants to click any keyboard button, type it... or will be EMPTY and only will be mouse clicking...
    [Arguments]                         ${locator}        ${press_key}=${EMPTY}
    Wait Until Page Contains Element    ${locator}        ${Element_Timeout}
    Wait Until Keyword Succeeds         20x               0.2s                  Scroll Element Into View    ${locator}
    Wait Until Element Is Visible       ${locator}        ${Element_Timeout}
    Wait Until Element Is Enabled       ${locator}        ${Element_Timeout}
    Wait Until Keyword Succeeds         20x               0.1s                  Click Element               ${locator}            ${press_key}

Click Element if Visible
    [Documentation]                     Keyword to click element if visible otherwise pass the step
    [Arguments]                         ${locator}
    ${flag}=                            Run Keyword And Return Status       Element Should Be Visible        ${locator}
    IF                                  "${flag}" == "True"
                                         Wait And Click Element            ${locator}
    END

Get Text And Set Variable
    [Documentation]                     Keyword to get text and set variable
            ...                         \n ``locator``   - locator of the WebElement
    [Arguments]                         ${locator}
    ${get_text_value}=                  Get Text            ${locator}
    Set Global Variable                 ${TEXT_VALUE}       ${get_text_value}

Wait Until Get Text Succeeds
    [Documentation]                     Keyword to wait until get text succeeds
            ...                         \n ``locator``   - locator of the WebElement
            ...                         \n ``wait_time`` - set maximum wait time
    [Arguments]                         ${locator}                          ${retry}=${element_timeout}    ${retry_interval}=0.5s
    Wait Until Keyword Succeeds         ${retry}                            ${retry_interval}
            ...                         Get Text And Set Variable           ${locator}
    [Return]                            ${TEXT_VALUE}
