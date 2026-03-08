from collections import deque
from typing import List
from .base import Memory

class EpisodicMemory(Memory):
    """
    Short-term memory as a bounded deque.
    Useful for conversation/session context.
    """
    def __init__(self, maxlen: int = 50):
        self._buf = deque(maxlen=maxlen)

    def add(self, text: str) -> None:
        self._buf.append(text)

    def retrieve(self, query: str, k: int = 5) -> List[str]:
        # Return most recent items; query ignored in this simple impl
        return list(self._buf)[-k:]
