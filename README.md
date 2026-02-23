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
├── tests/               # Robot Framework test suites
├── run_tests.ps1        # PowerShell script to run tests
├── requirements.txt     # Python dependencies
└── README.md
```
