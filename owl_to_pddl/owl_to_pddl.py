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

import os
import sys
import subprocess

from ament_index_python.packages import get_package_share_directory

import rclpy
from rclpy.node import Node

class OwlToPDDL(Node):

    def __init__(self):
        super().__init__('owl_to_pddl')

        self.declare_parameter('owl_file', rclpy.Parameter.Type.STRING)
        self.declare_parameter('in_domain_file', rclpy.Parameter.Type.STRING)
        self.declare_parameter('in_problem_file', rclpy.Parameter.Type.STRING)
        self.declare_parameter('out_domain_file', rclpy.Parameter.Type.STRING)
        self.declare_parameter('out_problem_file', rclpy.Parameter.Type.STRING)
        self.declare_parameter('add_numbers', True)
        self.declare_parameter('replace_output', True)
        self.declare_parameter('ignore_data_properties', False)

    def transform_owl_to_pddl(self):
        java_exec_path = os.path.join(
            get_package_share_directory('owl_to_pddl'),
            'build',
            'libs',
            'dlToPlanning-1.0-SNAPSHOT-all.jar'
        )

        jave_exec = [
            'java',
            '-jar',
            java_exec_path,
            '--owl=' + self.get_parameter('owl_file').value,
            '--tBox',
            '--inDomain=' + self.get_parameter('in_domain_file').value,
            '--outDomain=' + self.get_parameter('out_domain_file').value,
            '--aBox',
            '--inProblem=' + self.get_parameter('in_problem_file').value,
            '--outProblem=' + self.get_parameter('out_problem_file').value
        ]

        if self.get_parameter('add_numbers').value is True:
            jave_exec += ['--add-num-comparisons']

        if self.get_parameter('replace_output').value is True:
            jave_exec += ['--replace-output']

        if self.get_parameter('ignore_data_properties').value is True:
            jave_exec += ['--ignore-data-props']

        try:
            result = subprocess.run(
                jave_exec,
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE, text=True)
            print("Output:", result.stdout)
        except subprocess.CalledProcessError as e:
            print("An error occurred:", e)
            print("Return code:", e.returncode)
            print("Output:", e.output)
            print("Errors:", e.stderr)

def main():
    print("Starting owl to pddl transformation node")

    rclpy.init(args=sys.argv)

    owl_to_pddl_node = OwlToPDDL()

    executor = rclpy.executors.SingleThreadedExecutor()
    task = executor.create_task(owl_to_pddl_node.transform_owl_to_pddl)

    try:
        executor.spin_until_future_complete(task)
    except (KeyboardInterrupt, rclpy.executors.ExternalShutdownException):
        owl_to_pddl_node.destroy_node()

if __name__ == '__main__':
    main()
