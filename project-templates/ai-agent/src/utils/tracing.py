import time
from contextlib import contextmanager

@contextmanager
def trace_span(name: str):
    start = time.time()
    try:
        yield
    finally:
        dur_ms = int((time.time() - start) * 1000)
        print(f"[trace] {name} took {dur_ms}ms")
