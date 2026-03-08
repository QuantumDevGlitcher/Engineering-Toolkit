from src.agents.task_agent import TaskAgent
from src.agents.base import AgentInput

def test_task_agent_runs():
    a = TaskAgent(name="a", system_prompt="sys", tools={}, memory=None, tool_allowlist=[])
    out = a.run(AgentInput(text="hello"))
    assert "hello" in out.text
