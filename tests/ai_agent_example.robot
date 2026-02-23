*** Settings ***
Documentation    Example test suite demonstrating AI agent interaction using the AIAgentLibrary.
...              These tests show how to send prompts, validate responses, switch models,
...              and inspect response history. Override variables via the command line:
...              robot --variable API_URL:https://your-api.example.com/v1 --variable API_KEY:sk-your-key tests/ai_agent_example.robot
Library          ../libraries/AIAgentLibrary.py    api_url=${API_URL}    api_key=${API_KEY}    model=gpt-4
Library          Collections

*** Variables ***
${API_URL}       https://api.openai.com/v1
${API_KEY}       YOUR_API_KEY_HERE

*** Test Cases ***
Send Prompt To AI Agent
    [Documentation]    Send a simple prompt to the AI agent and verify that a non-empty response is returned.
    ${response}=    Ask AI Agent    What is Robot Framework?
    Should Not Be Empty    ${response}
    Log    AI Response: ${response}

Validate AI Response Contains Expected Content
    [Documentation]    Send a prompt and validate that the response contains expected keywords.
    ${response}=    Ask AI Agent    Explain what Robot Framework is used for in software testing.
    ${is_valid}=    Validate AI Response    ${response}    testing    framework
    Should Be True    ${is_valid}    Response should contain the keywords 'testing' and 'framework'.

Switch AI Model
    [Documentation]    Switch the AI model and verify the new model is used for subsequent requests.
    Set AI Model    gpt-3.5-turbo
    ${response}=    Ask AI Agent    Say hello.
    Should Not Be Empty    ${response}
    # Verify the history entry recorded the correct model
    ${history}=    Get AI Response History
    ${last_entry}=    Get From List    ${history}    -1
    ${used_model}=    Get From Dictionary    ${last_entry}    model
    Should Be Equal As Strings    ${used_model}    gpt-3.5-turbo
    [Teardown]    Set AI Model    gpt-4

Check Response History
    [Documentation]    Send multiple prompts and verify that every prompt/response pair is stored in the history.
    ${response1}=    Ask AI Agent    What is Python?
    ${response2}=    Ask AI Agent    What is test automation?
    ${history}=    Get AI Response History
    ${length}=    Get Length    ${history}
    Should Be True    ${length} >= 2    History should contain at least 2 entries.
    # Verify the last two entries match our prompts
    ${second_last}=    Get From List    ${history}    -2
    ${last}=          Get From List    ${history}    -1
    ${prompt1}=    Get From Dictionary    ${second_last}    prompt
    ${prompt2}=    Get From Dictionary    ${last}           prompt
    Should Be Equal As Strings    ${prompt1}    What is Python?
    Should Be Equal As Strings    ${prompt2}    What is test automation?
