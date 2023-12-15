*** Settings ***
Documentation       Documentation for Common Keywords used in CASE-3 tests

Library             String
Library             DateTime

*** Variables ***
${Element_Timeout}      30s

*** Keywords ***

Generate Random String Values
    [Arguments]             ${char_count}
    [Documentation]         Keyword to generate random string.
    ${string}=              Generate Random String    ${char_count}    [LOWER]
    [Return]                ${string}

Generate Random Numeric Values
    [Arguments]             ${char_count}
    [Documentation]         Keyword to generate random numeric.
    ${numeric}=             Generate Random String    ${char_count}   [NUMBERS]
    [Return]                ${numeric}

Select Random Integer Value Between
    [Arguments]             ${range_min}              ${range_max}
    [Documentation]         Keyword to select a random numeric between the range.
    ${numeric}=             Evaluate                  random.sample(range(${range_min}, ${range_max}),1)   random
    ${numeric}=             Convert To String         ${numeric}[0]
    [Return]                ${numeric}

Generate Random Date
    [Arguments]             ${result_format}=%d/%m/%Y                ${future_date}=No
    [Documentation]         Keyword to generate random date.
    ${day}=                 Select Random Integer Value Between      1                      365
    IF                      "${future_date}"=="No"
                            ${date}=                                Get Current Date        result_format=${result_format}   increment=-${day}day
    ELSE
                            ${date}=                                Get Current Date        result_format=${result_format}   increment=+${day}day
    END
    [Return]                ${date}
