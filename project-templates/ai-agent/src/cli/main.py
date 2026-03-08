import argparse
from src.agents.task_agent import TaskAgent
from src.agents.base import AgentInput

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("text", help="Input text for the agent")
    args = parser.parse_args()

    agent = TaskAgent(
        name="task-agent",
        system_prompt="You are a helpful assistant.",
        tools={},
        memory=None,
        tool_allowlist=[],
    )
    out = agent.run(AgentInput(text=args.text))
    print(out.text)

if __name__ == "__main__":
    main()
