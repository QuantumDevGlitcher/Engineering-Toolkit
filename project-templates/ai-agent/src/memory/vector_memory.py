from typing import List, Tuple
from .base import Memory

class VectorMemory(Memory):
    """
    Minimal in-memory vector-like store.
    Replace with real embeddings + vector DB (FAISS, pgvector, Pinecone, etc.).
    """
    def __init__(self):
        self._items: List[Tuple[str, str]] = []  # (key, text)

    def add(self, text: str) -> None:
        # Placeholder key; in real life this is embedding/vector ID
        key = str(len(self._items))
        self._items.append((key, text))

    def retrieve(self, query: str, k: int = 5) -> List[str]:
        # Placeholder retrieval: naive substring match
        matches = [t for _, t in self._items if query.lower() in t.lower()]
        return matches[:k]
