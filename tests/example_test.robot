*** Settings ***
Documentation    Example test suite for Robot Framework AI Agent

*** Test Cases ***
Hello World Test
    [Documentation]    A simple test to verify Robot Framework is working
    Log    Hello from Robot Framework AI Agent!
    Should Be Equal    ${1+1}    ${2}

String Test
    [Documentation]    A simple string comparison test
    ${message}=    Set Variable    Robot Framework AI Agent
    Should Contain    ${message}    AI Agent
