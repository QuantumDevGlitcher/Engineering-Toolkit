from dataclasses import dataclass
from typing import Dict, Optional, List

from src.tools.base import Tool
from src.memory.base import Memory

@dataclass
class AgentInput:
    text: str

@dataclass
class AgentOutput:
    text: str
    tool_used: Optional[str] = None

class BaseAgent:
    def __init__(
        self,
        name: str,
        system_prompt: str,
        tools: Optional[Dict[str, Tool]] = None,
        memory: Optional[Memory] = None,
        tool_allowlist: Optional[List[str]] = None,
    ):
        self.name = name
        self.system_prompt = system_prompt
        self.tools = tools or {}
        self.memory = memory
        self.tool_allowlist = set(tool_allowlist or [])

    def run(self, inp: AgentInput) -> AgentOutput:
        raise NotImplementedError
