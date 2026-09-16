#!/usr/bin/env python3

# Copyright 2025 Gustavo Rezende Silva
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Count PDDL instance complexity metrics from OWLtoPDDL-generated files.

Usage:
    python count_pddl_complexity.py DOMAIN_FILE PROBLEM_FILE [--reconfig-pattern PATTERN] [--json]
"""

import argparse
import json
import sys


def count_derived_predicates(domain_text: str) -> int:
    """Count total (:derived blocks in the domain file."""
    return sum(1 for line in domain_text.splitlines() if '(:derived' in line)


def count_actions(
    domain_text: str,
    reconfig_pattern: str,
) -> tuple[list[str], list[str]]:
    """Extract action names and classify as task or reconfiguration actions.

    Returns:
        (task_action_names, reconfig_action_names)
    """
    task_actions = []
    reconfig_actions = []
    for line in domain_text.splitlines():
        stripped = line.strip()
        if stripped.startswith('(:action'):
            tokens = stripped.split()
            if len(tokens) >= 2:
                name = tokens[1]
                if reconfig_pattern in name:
                    reconfig_actions.append(name)
                else:
                    task_actions.append(name)
    return task_actions, reconfig_actions


def _count_declared_symbols(text: str, block_header: str) -> int:
    """Count symbols declared in a ``(block_header ...)`` block.

    Works for both the problem ``(:objects ...)`` block and the domain
    ``(:constants ...)`` block. Skips type annotations: a ``-`` token and the
    token immediately following it are not counted. Returns 0 if the block is
    absent.
    """
    # Find the block using a depth-tracking parenthesis scan
    lines = text.splitlines()
    in_block = False
    depth = 0
    symbol_tokens = []

    for line in lines:
        if not in_block:
            if block_header in line:
                in_block = True
                # Start from the character after the block header
                idx = line.index(block_header) + len(block_header)
                segment = line[idx:]
                depth = 1
            else:
                continue
        else:
            segment = line

        close_pos = None
        for i, ch in enumerate(segment):
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1
                if depth == 0:
                    in_block = False
                    close_pos = i
                    break

        # Only collect tokens up to (not including) the closing ')'
        content = segment[:close_pos] if close_pos is not None else segment
        symbol_tokens.extend(content.split())

        if not in_block:
            break

    # Remove '-' tokens and the type name immediately following each '-'
    count = 0
    skip_next = False
    for token in symbol_tokens:
        if skip_next:
            skip_next = False
            continue
        if token == '-':
            skip_next = True
            continue
        count += 1
    return count


def count_objects(problem_text: str) -> int:
    """Count objects declared in the problem (:objects ...) block."""
    return _count_declared_symbols(problem_text, '(:objects')


def count_constants(domain_text: str) -> int:
    """Count constants declared in the domain (:constants ...) block.

    OWLtoPDDL emits most ontology individuals (FunctionDesigns, Components,
    QAvalues, ...) as domain constants rather than problem objects, so the
    evaluation "Objects" metric is the sum of these and the problem objects.
    """
    return _count_declared_symbols(domain_text, '(:constants')


def count_init_facts(problem_text: str) -> int:
    """Count ground atoms in the (:init ...) section.

    Counts lines between (:init and (:goal that start with '(' after
    stripping whitespace. This matches the awk one-liner:
        awk '/\\(:init/{p=1;next} /\\(:goal/{p=0} p && /\\(/' problem.pddl
    """
    in_init = False
    count = 0
    for line in problem_text.splitlines():
        if '(:init' in line:
            in_init = True
            continue
        if '(:goal' in line:
            break
        if in_init and line.strip().startswith('('):
            count += 1
    return count


def format_table(
    domain_path: str,
    problem_path: str,
    derived: int,
    task_actions: list[str],
    reconfig_actions: list[str],
    constants: int,
    problem_objects: int,
    init_facts: int,
) -> str:
    objects = constants + problem_objects
    lines = [
        'PDDL instance complexity',
        f'  Domain:   {domain_path}',
        f'  Problem:  {problem_path}',
        '',
        f'  Derived predicates:      {derived}',
        f'  Task actions:            {len(task_actions)}  {task_actions}',
        f'  Reconfiguration actions: {len(reconfig_actions)}  {reconfig_actions}',
        f'  Objects:                 {objects}  ({constants} domain constants + {problem_objects} problem objects)',
        f'  Init facts:              {init_facts}',
    ]
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(
        description='Count PDDL instance complexity from OWLtoPDDL-generated files.')
    parser.add_argument('domain', metavar='DOMAIN_FILE',
                        help='Path to domain_created.pddl')
    parser.add_argument('problem', metavar='PROBLEM_FILE',
                        help='Path to problem_created.pddl')
    parser.add_argument('--reconfig-pattern', default='reconfigure',
                        help='Substring identifying reconfiguration actions (default: "reconfigure")')
    parser.add_argument('--json', action='store_true',
                        help='Emit JSON output instead of human-readable table')
    args = parser.parse_args()

    try:
        domain_text = open(args.domain).read()
    except OSError as e:
        print(f'Error reading domain file: {e}', file=sys.stderr)
        sys.exit(1)

    try:
        problem_text = open(args.problem).read()
    except OSError as e:
        print(f'Error reading problem file: {e}', file=sys.stderr)
        sys.exit(1)

    derived = count_derived_predicates(domain_text)
    task_actions, reconfig_actions = count_actions(domain_text, args.reconfig_pattern)
    constants = count_constants(domain_text)
    problem_objects = count_objects(problem_text)
    init_facts = count_init_facts(problem_text)

    if args.json:
        result = {
            'derived_predicates': derived,
            'task_actions': task_actions,
            'reconfig_actions': reconfig_actions,
            'domain_constants': constants,
            'problem_objects': problem_objects,
            'objects': constants + problem_objects,
            'init_facts': init_facts,
        }
        print(json.dumps(result, indent=2))
    else:
        print(format_table(
            args.domain, args.problem,
            derived, task_actions, reconfig_actions,
            constants, problem_objects, init_facts,
        ))


if __name__ == '__main__':
    main()
