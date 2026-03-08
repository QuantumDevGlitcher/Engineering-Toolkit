from typing import Optional
from src.agents.base import BaseAgent, AgentInput, AgentOutput
from src.utils.tracing import trace_span

class TaskAgent(BaseAgent):
    """
    Minimal agent that:
    - optionally uses memory for context
    - optionally uses tools (allowlisted)
    - calls a placeholder LLM runner (replace in real projects)
    """

    def _call_llm(self, prompt: str) -> str:
        # Placeholder (replace with OpenAI/Anthropic/local model)
        return f"[llm-placeholder]\n{prompt[:300]}..."

    def run(self, inp: AgentInput) -> AgentOutput:
        with trace_span(f"{self.name}.run"):
            context = ""
            if self.memory:
                mem = self.memory.retrieve(inp.text, k=5)
                if mem:
                    context = "\n".join(mem)

            prompt = (
                f"{self.system_prompt}\n\n"
                f"Context:\n{context}\n\n"
                f"User:\n{inp.text}\n"
            )
            out = self._call_llm(prompt)
            return AgentOutput(text=out)
