from src.agents.base import BaseAgent, AgentInput, AgentOutput
from src.pipelines.rag_pipeline import RAGPipeline

class RetrievalAgent(BaseAgent):
    def __init__(self, name: str, system_prompt: str, rag: RAGPipeline, **kwargs):
        super().__init__(name=name, system_prompt=system_prompt, **kwargs)
        self.rag = rag

    def run(self, inp: AgentInput) -> AgentOutput:
        answer = self.rag.run(inp.text)
        return AgentOutput(text=answer)
