#!/usr/bin/env python3

import subprocess
import re

EXCLUDE = {
    "nodes": [
        r"/_.+",
        r"/launch_ros_.+",
        r"/turtlebot4_diagnostics",
        r"/transform_listener_impl_.+",
        r"/analyzers",
        # r"/lifecycle_manager_navigation",
    ],
    "topics": [r"/diagnostics.*", r"/parameter_events", r"/rosout", r"/tf", r"/bond"],
    "services": [
        r"/.+/describe_parameters",
        r"/.+/get_parameter_types",
        r"/.+/get_parameters",
        r"/.+/list_parameters",
        r"/.+/set_parameters",
        r"/.+/set_parameters_atomically",
    ],
    "actions": [],
}


def run_command(command: list[str]) -> str:
    """Run a command and return its output."""
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"Error running command: {' '.join(command)}\nstderr:\n{result.stderr}")
    return result.stdout


def list_nodes() -> list[str]:
    """Run 'ros2 node list' to get all online nodes."""
    command = ["ros2", "node", "list"]
    output = run_command(command)
    if not output:
        raise RuntimeError("No ROS2 nodes found.")
    nodes = output.splitlines()
    return [node for node in nodes if not any(re.fullmatch(pattern, node) for pattern in EXCLUDE["nodes"])]


def get_node_info(node: str) -> str:
    """Run 'ros2 node info <node>' to get detailed info of the node."""
    command = ["ros2", "node", "info", node]
    output = run_command(command)
    if not output:
        raise RuntimeError(f"Error getting info for node: {node}")
    return output


def parse_node_info(node_info_output: str) -> dict[str, list]:
    node_info: dict[str, list] = {}

    current_section = None
    for line in node_info_output.strip().splitlines():
        line = line.strip()

        if not line:
            continue

        if line.endswith(":"):
            current_section = line[:-1]
            node_info[current_section] = []
        elif current_section:
            match current_section:
                case "Subscribers" | "Publishers":
                    patterns = EXCLUDE["topics"]
                case "Service Servers" | "Service Clients":
                    patterns = EXCLUDE["services"]
                case "Action Servers" | "Action Clients":
                    patterns = EXCLUDE["actions"]
                case _:
                    raise ValueError(f"Unknown section: {current_section}")
            medium = line.split(": ")[0]
            if not any(re.fullmatch(pattern, medium) for pattern in patterns):
                node_info[current_section].append(medium)
        else:
            print(f"Parsing node '{line}'...")

    return node_info


def generate_dot_file(node_relations: dict[str, dict[str, list]], output_file: str):
    """
    Generate a .dot file to visualize node relationships.
    `medium`: topic, service, action
    """

    media_relations: dict[str, dict[str, list]] = {}

    for node, relations in node_relations.items():
        for relation, media in relations.items():
            for medium in media:
                if medium not in media_relations:
                    media_relations[medium] = {}
                if relation not in media_relations[medium]:
                    media_relations[medium][relation] = []
                if node not in media_relations[medium][relation]:
                    media_relations[medium][relation].append(node)

    with open(output_file, "w") as f:
        f.write("digraph {\n")
        f.write("    rankdir = LR;\n")

        for node in node_relations.keys():
            f.write(f'    "{node}" [color = black;penwidth = 2;];\n')

        for medium, relations in media_relations.items():
            for relation, nodes in relations.items():
                reverse = False
                match relation:
                    case "Publishers":
                        color = "blue"
                    case "Subscribers":
                        color = "blue"
                        reverse = True
                    case "Service Servers":
                        color = "green"
                    case "Service Clients":
                        color = "green"
                        reverse = True
                    case "Action Servers":
                        color = "red"
                    case "Action Clients":
                        color = "red"
                        reverse = True
                    case _:
                        raise ValueError(f"Unknown relation: {relation}")

                f.write(f'    "{medium}" [shape = rectangle;color = {color};];\n')
                for n in nodes:
                    if reverse:
                        f.write(f'    "{medium}" -> "{n}" [color = {color};];\n')
                    else:
                        f.write(f'    "{n}" -> "{medium}" [color = {color};];\n')
        f.write("}\n")


def main():
    nodes = list_nodes()
    print(f"# Nodes: {len(nodes)}")

    node_relations = {}

    for node in nodes:
        info = get_node_info(node)
        parsed_info = parse_node_info(info)
        if any(parsed_info.values()):
            node_relations[node] = parsed_info

    generate_dot_file(node_relations, "ros2_graph.dot")


if __name__ == "__main__":
    main()
