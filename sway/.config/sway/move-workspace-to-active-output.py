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
    parser.add_argument("--create-if-absent", help='Create workspace if absent', default=False, action='store_true')
    parser.add_argument("workspace_name")
    args = parser.parse_args()

    active_output = None
    active_workspace = None
    target_output = None
    for w in swaymsg("-t get_workspaces"):
        if w['focused']:
            active_output = w['output']
            active_workspace = w['name']
        if w['name'] == args.workspace_name:
            target_output = w['output']

    if not active_output:
        print("ERROR: Could not find active output.")
        sys.exit(1)

    if not active_workspace:
        print("ERROR: Could not find active workspace.")
        sys.exit(1)

    if not target_output:
        if args.create_if_absent:
            swaymsg("'workspace {}'".format(args.workspace_name))
        else:
            print("ERROR: Could not find workspace {}.".format(args.workspace_name))
            sys.exit(1)

    #print("Move workspace {} to output {}".format(active_workspace, target_output))
    #print("Move workspace {} to output {}".format(args.workspace_name, active_output))

    swaymsg("'workspace {}; move workspace to output {}; workspace {}; move workspace to output {}; workspace {}'".format(
        active_workspace, target_output,
        args.workspace_name, active_output,
        args.workspace_name
    ))

if __name__ == "__main__":
    main()
