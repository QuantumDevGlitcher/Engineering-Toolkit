from fastapi import APIRouter
from pydantic import BaseModel

from src.utils.config import load_config
from src.tools.calculator_tool import CalculatorTool
from src.tools.search_tool import SearchTool
from src.agents.task_agent import TaskAgent
from src.agents.base import AgentInput

router = APIRouter()
cfg = load_config()

tools = {
    "calculator": CalculatorTool(),
    "search": SearchTool(),
}

# Minimal agent wiring
agent = TaskAgent(
    name="task-agent",
    system_prompt="You are a helpful assistant.",
    tools=tools,
    memory=None,
    tool_allowlist=cfg.tool_allowlist,
)

class AgentRequest(BaseModel):
    text: str

@router.post("/agent")
def run_agent(payload: AgentRequest):
    out = agent.run(AgentInput(text=payload.text))
    return {"response": out.text}
