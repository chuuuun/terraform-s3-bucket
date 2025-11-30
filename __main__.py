import sys
from graphs.agentState import AgentState
from graphs.collaborationGraph import CollaborationGraph
from typing import cast


def get_user_request() -> str:
    """Prompts the user for the initial task request."""
    print("-------------------------------------------------------")
    print("Welcome to the Terraform Multi-Agent System.")
    print("-------------------------------------------------------")
    return input("Enter your Terraform task request (e.g., 'Deploy an S3 bucket with cost optimization'):\n> ")


def main():
    user_request = get_user_request()
    if not user_request:
        print("Task request cannot be empty. Exiting.")
        sys.exit(1)

    collaboration_graph = CollaborationGraph()
    app = collaboration_graph.compile()

    print("\n--- Terraform Agent Graph Initialized and Running ---")

    initial_state: AgentState = cast(AgentState, cast(object, {
        "request": user_request,
        "terraform_code": "",
        "raw_plan": None,
        "plan_summary": None,
        "cost_report": None,
        "project_plan": "",
        "review_feedback": "",
        "current_agent": None,
        "loop_count": 0,
        "finished": False,
    }))


    result = app.invoke(initial_state)

    print("\n--- Final Output ---")
    print(f"Total Cycles: {result['loop_count']}")
    print(f"Task: {result['request']}")
    print(f"Final Code: {result['terraform_code']}")
    print(f"Final Cost Report: {result['cost_report']}")


if __name__ == '__main__':
    main()