from typing import Dict
from src.agents.base import BaseAgent, AgentInput, AgentOutput

class Orchestrator:
    """
    Routes tasks to specific agents by key.
    """
    def __init__(self, agents: Dict[str, BaseAgent]):
        self.agents = agents

    def route(self, task_type: str, text: str) -> AgentOutput:
        if task_type not in self.agents:
            raise ValueError(f"Unknown task_type: {task_type}")
        return self.agents[task_type].run(AgentInput(text=text))
