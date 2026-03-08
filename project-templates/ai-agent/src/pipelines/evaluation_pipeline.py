import json
from typing import Callable, Dict, List, Any

class EvaluationPipeline:
    """
    Minimal eval harness.
    Reads JSONL rows with:
      { id, input, expected_contains: [] }
    """
    def __init__(self, runner: Callable[[str], str]):
        self.runner = runner

    def run_jsonl(self, path: str) -> List[Dict[str, Any]]:
        results = []
        with open(path, "r", encoding="utf-8") as f:
            for line in f:
                row = json.loads(line)
                out = self.runner(row["input"])
                ok = all(x in out for x in row.get("expected_contains", []))
                results.append({"id": row["id"], "ok": ok, "output": out})
        return results
