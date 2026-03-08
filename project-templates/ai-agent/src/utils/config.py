import os
import yaml
from dataclasses import dataclass
from typing import Any, Dict, List

@dataclass(frozen=True)
class AppConfig:
    name: str
    env: str
    log_level: str
    tool_allowlist: List[str]
    eval_dataset_default: str

def load_yaml(path: str) -> Dict[str, Any]:
    with open(path, "r", encoding="utf-8") as f:
        return yaml.safe_load(f) or {}

def load_config(default_path: str = "config/default.yaml") -> AppConfig:
    cfg = load_yaml(default_path)
    name = cfg.get("app", {}).get("name", "ai-agent")
    env = cfg.get("app", {}).get("env", os.getenv("APP_ENV", "development"))
    log_level = cfg.get("logging", {}).get("level", os.getenv("LOG_LEVEL", "info"))
    allowlist = cfg.get("tools", {}).get("allowlist", ["calculator", "search"])
    dataset = cfg.get("evaluation", {}).get("dataset_default", "eval/datasets/smoke.jsonl")
    return AppConfig(
        name=name,
        env=env,
        log_level=log_level,
        tool_allowlist=list(allowlist),
        eval_dataset_default=str(dataset),
    )
