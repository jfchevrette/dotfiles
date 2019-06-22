#!/usr/bin/env python3

import argparse
import json
import os
import sys

def swaymsg(cmd):
    res = os.popen("swaymsg -r {}".format(cmd)).read().strip()
    return json.loads(res)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("workspace_name")
    args = parser.parse_args()

    active_output = None
    active_workspace = None
    target_output = None
    workspace_name = args.workspace_name

    # Find active output, active workspace and target output 
    for w in swaymsg("-t get_workspaces"):
        if w['focused']:
            active_output = w['output']
            active_workspace = w['name']
        if w['name'] == args.workspace_name:
            target_output = w['output']

    # Find what is the currently active workspace on the target output
    for output in swaymsg("-t get_outputs"):
        if output["name"] == target_output:
            target_output_current_workspace = output["current_workspace"]

    if not active_output:
        print("ERROR: Could not find active output.")
        sys.exit(1)

    if not active_workspace:
        print("ERROR: Could not find active workspace.")
        sys.exit(1)

    # If workspace not found on any target, just create it, otherwise do the move dance
    if not target_output:
        swaymsg("'workspace {}'".format(args.workspace_name))
    else:
        msg = "'workspace {}; move workspace to output {}; workspace {}; move workspace to output {}; workspace {}; workspace {}'".format(
            workspace_name, active_output,
            active_workspace, target_output,
            target_output_current_workspace,
            workspace_name
        )
        swaymsg(msg)

if __name__ == "__main__":
    main()
