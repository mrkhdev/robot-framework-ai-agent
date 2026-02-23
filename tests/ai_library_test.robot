*** Settings ***
Documentation    Test suite for the AIAgentLibrary custom keywords
Library          ../libraries/AIAgentLibrary.py    api_url=https://api.example.com/v1    api_key=test-key    model=gpt-4

*** Test Cases ***
Validate AI Response With Matching Keywords
    [Documentation]    Validate that a response containing expected keywords returns True
    ${response}=    Set Variable    Robot Framework is a powerful test automation tool
    ${result}=    Validate AI Response    ${response}    Robot    Framework    automation
    Should Be True    ${result}

Validate AI Response With Missing Keyword
    [Documentation]    Validate that a response missing an expected keyword returns False
    ${response}=    Set Variable    Robot Framework is great
    ${result}=    Validate AI Response    ${response}    Python
    Should Not Be True    ${result}

Validate AI Response Is Case Insensitive
    [Documentation]    Validate that keyword matching is case-insensitive
    ${response}=    Set Variable    ROBOT FRAMEWORK is GREAT
    ${result}=    Validate AI Response    ${response}    robot    framework    great
    Should Be True    ${result}

Set AI Model And Verify
    [Documentation]    Set the AI model and confirm no error is raised
    Set AI Model    claude
    Set AI Model    gpt-4

Get AI Response History Initially Empty
    [Documentation]    History should be empty when no AI calls have been made
    ${history}=    Get AI Response History
    ${length}=    Get Length    ${history}
    Should Be Equal As Integers    ${length}    0
