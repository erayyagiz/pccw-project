*** Settings ***
Documentation     Documentation for Keywords used in Login screen
Resource          Keyword_FE_Base.robot
Resource          ../../Object_Repository/Frontend/Obj_Library_Common.robot
Resource          ../../Object_Repository/Frontend/Obj_Library_Login.robot
Resource          ../../Object_Repository/Frontend/Obj_Library_Home.robot
Resource          ../../Object_Repository/Frontend/Obj_Library_Practice.robot

*** Keywords ***
Go to Login Screen
    [Documentation]                              Keyword to go to the login screen in Portal
    Wait Until Element Is Visible                ${Home_Title_txt}                          ${Element_Timeout}
    Wait And Click Element                       ${Portal_Practice_Menu_btn}
    Wait Until Element Is Visible                ${Practice_Title_txt}                      ${Element_Timeout}
    Wait And Click Element                       ${Practice_Test_Login_Page_btn}
    Wait Until Element Is Visible                ${Login_Title_txt}                         ${Element_Timeout}

Login to Portal
    [Arguments]                                  ${username}                                ${password}
    [Documentation]                              Keyword to input username & password and login to enter Home Page.
            ...                                  \n ``username`` - is valid username of user
            ...                                  \n ``password`` - is valid password of user
    Wait Until Element Is Visible                ${Login_Title_txt}                         ${Element_Timeout}
    Wait and Input Text                          ${Login_Username_txt}                      ${username}
    Wait and Input Text                          ${Login_Password_txt}                      ${password}
    Wait And Click Element                       ${Login_Submit_btn}

Check if user is logged in to Portal successfully
    [Documentation]                              Keyword to check if the user is logged in to Portal successfully
    Wait Until Element Is Visible                ${Login_Success_Message_txt}               ${Element_Timeout}
    Wait Until Element Is Visible                ${Login_Success_Message_Details_txt}       ${Element_Timeout}
    Wait Until Page Does Not Contain Element     ${Login_Title_txt}                         ${Element_Timeout}

Check if is not logged in to Portal
    [Arguments]                                 ${expected_error_message}
    [Documentation]                             Keyword to check error message contents when login is not successful
    Wait Until Element Is Visible               ${Login_Error_Message_txt}                  ${Element_Timeout}
    ${actual_error_message}=                    Wait Until Get Text Succeeds                ${Login_Error_Message_txt}
    Should Be Equal As Strings                  ${actual_error_message}                     ${expected_error_message}
