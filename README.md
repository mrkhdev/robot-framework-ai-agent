[![Robot Framework Tests](https://github.com/mrkhdev/robot-framework-ai-agent/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/mrkhdev/robot-framework-ai-agent/actions/workflows/robot-tests.yml)

# Robot Framework AI Agent

A Robot Framework project for building and testing AI agent interactions.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/mrkhdev/robot-framework-ai-agent.git
   cd robot-framework-ai-agent
   ```

2. Create a virtual environment and install dependencies:
   ```bash
   python -m venv venv
   venv\Scripts\activate
   pip install -r requirements.txt
   ```

## Usage

Run all tests using the PowerShell script:
```powershell
.\run_tests.ps1
```

Or run directly with Robot Framework:
```bash
robot --outputdir results tests/
```

## Project Structure

```
robot-framework-ai-agent/
├── libraries/           # Custom Robot Framework keyword libraries
│   └── AIAgentLibrary.py
├── tests/               # Robot Framework test suites
│   └── ai_agent_example.robot
├── run_tests.ps1        # PowerShell script to run tests
├── requirements.txt     # Python dependencies
└── README.md
```

## Examples

The `tests/ai_agent_example.robot` suite demonstrates how to interact with an AI agent using the custom `AIAgentLibrary`. It includes the following test cases:

- **Send Prompt To AI Agent** -- sends a simple prompt and verifies that a non-empty response is returned.
- **Validate AI Response Contains Expected Content** -- sends a prompt and checks that the response contains specific keywords.
- **Switch AI Model** -- changes the active AI model and confirms the new model is recorded in the response history.
- **Check Response History** -- sends multiple prompts and verifies that every prompt/response pair is stored.

### Running the example tests

The test suite uses two variables (`API_URL` and `API_KEY`) that default to the OpenAI API endpoint and a placeholder key. Override them on the command line to point at your own API:

```bash
robot --variable API_KEY:sk-your-real-key --outputdir results tests/ai_agent_example.robot
```

To also override the API URL (e.g. for a local or alternative endpoint):

```bash
robot --variable API_URL:https://your-api.example.com/v1 --variable API_KEY:sk-your-real-key --outputdir results tests/ai_agent_example.robot
```
