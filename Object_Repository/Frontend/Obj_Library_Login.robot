*** Settings ***
Documentation   User Object Library for CASE-3 Login Page


*** Variables ***
#Variable Name                                  #Locator

${Login_Title_txt}                              //section[@id='login']/h2[text()='Test login']

${Login_Username_txt}                           username
${Login_Password_txt}                           password
${Login_Submit_btn}                             submit

${Login_Success_Message_txt}                    //h1[text()='Logged In Successfully']
${Login_Success_Message_Details_txt}            //strong[text()='Congratulations student. You successfully logged in!']

${Login_Error_Message_txt}                      error