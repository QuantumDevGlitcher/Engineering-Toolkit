from typing import List

class RAGPipeline:
    def __init__(self, retriever, llm_runner):
        self.retriever = retriever  # fn(query) -> List[str]
        self.llm_runner = llm_runner  # fn(prompt) -> str

    def run(self, query: str) -> str:
        docs: List[str] = self.retriever(query)
        context = "\n".join(docs)
        prompt = f"Context:\n{context}\n\nQuestion:\n{query}"
        return self.llm_runner(prompt)
