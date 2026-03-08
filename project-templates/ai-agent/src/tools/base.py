from dataclasses import dataclass
from typing import Protocol

class Tool(Protocol):
    name: str
    def run(self, input_str: str) -> str: ...

@dataclass
class ToolResult:
    tool: str
    output: str
