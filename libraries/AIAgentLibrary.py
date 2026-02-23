"""
AI Agent Library for Robot Framework.

Provides keywords for interacting with AI APIs, validating responses,
and managing AI model configuration.
"""

import requests
from robot.api.deco import keyword, library


@library(scope="GLOBAL")
class AIAgentLibrary:
    """A Robot Framework library for AI agent interactions.

    The library provides keywords for sending prompts to AI APIs,
    validating responses, configuring models, and retrieving response history.

    = Configuration =

    The library accepts the following constructor arguments:

    | =Argument=   | =Description=                        | =Default=                           |
    | api_url      | Base URL of the AI API endpoint      | https://api.openai.com/v1           |
    | api_key      | API key for authentication           | (empty)                             |
    | model        | Default AI model to use              | gpt-4                               |

    = Example =

    | Library | ../libraries/AIAgentLibrary.py | api_url=https://api.openai.com/v1 | api_key=sk-xxx | model=gpt-4 |
    """

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self, api_url="https://api.openai.com/v1", api_key="", model="gpt-4"):
        """Initialise the AI Agent Library.

        Args:
            api_url: Base URL of the AI API endpoint.
            api_key: API key for authentication.
            model: Default AI model to use.
        """
        self._api_url = api_url.rstrip("/")
        self._api_key = api_key
        self._model = model
        self._response_history = []

    @keyword("Ask AI Agent")
    def ask_ai_agent(self, prompt):
        """Send a prompt to the configured AI API and return the response text.

        The prompt is sent as a user message to the chat completions endpoint.
        The response is stored in the response history.

        Args:
            prompt: The text prompt to send to the AI model.

        Returns:
            The text content of the AI response.

        Raises:
            RuntimeError: If the API request fails or returns an error.

        Example:
        | ${response}= | Ask AI Agent | What is Robot Framework? |
        """
        url = f"{self._api_url}/chat/completions"
        headers = {
            "Authorization": f"Bearer {self._api_key}",
            "Content-Type": "application/json",
        }
        payload = {
            "model": self._model,
            "messages": [
                {"role": "user", "content": prompt},
            ],
        }

        try:
            response = requests.post(url, json=payload, headers=headers, timeout=60)
            response.raise_for_status()
        except requests.RequestException as exc:
            raise RuntimeError(f"AI API request failed: {exc}") from exc

        data = response.json()

        try:
            content = data["choices"][0]["message"]["content"]
        except (KeyError, IndexError) as exc:
            raise RuntimeError(
                f"Unexpected API response structure: {data}"
            ) from exc

        self._response_history.append(
            {"prompt": prompt, "response": content, "model": self._model}
        )
        return content

    @keyword("Validate AI Response")
    def validate_ai_response(self, response, *expected_keywords):
        """Check whether an AI response contains all of the expected keywords.

        The comparison is case-insensitive.

        Args:
            response: The AI response text to validate.
            *expected_keywords: One or more strings that must appear in the response.

        Returns:
            True if every expected keyword is found, False otherwise.

        Example:
        | ${valid}= | Validate AI Response | ${response} | Robot | Framework |
        | Should Be True | ${valid} |
        """
        if not expected_keywords:
            raise ValueError("At least one expected keyword must be provided.")
        response_lower = response.lower()
        return all(kw.lower() in response_lower for kw in expected_keywords)

    @keyword("Set AI Model")
    def set_ai_model(self, model):
        """Set the AI model to use for subsequent requests.

        Args:
            model: The model identifier (e.g. ``gpt-4``, ``claude``).

        Example:
        | Set AI Model | gpt-4 |
        | Set AI Model | claude |
        """
        self._model = model

    @keyword("Get AI Response History")
    def get_ai_response_history(self):
        """Return the list of all AI prompt/response pairs from this session.

        Each entry is a dictionary with the keys ``prompt``, ``response``,
        and ``model``.

        Returns:
            A list of dictionaries representing the response history.

        Example:
        | ${history}= | Get AI Response History |
        | Log | ${history} |
        """
        return list(self._response_history)
