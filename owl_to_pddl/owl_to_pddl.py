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

if __name__ == '__main__':
    args = []
    if len(sys.argv) > 1:
        args = sys.argv[1:]

    java_exec_path = os.path.join(
        get_package_share_directory('owl_to_pddl'),
        'build',
        'libs',
        'dlToPlanning-1.0-SNAPSHOT-all.jar'
    )

    jave_exec = ["java", "-jar", java_exec_path] + args

    try:
        result = subprocess.run(jave_exec, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        print("Output:", result.stdout)
        # print("Errors:", result.stderr)
    except subprocess.CalledProcessError as e:
        print("An error occurred:", e)
        print("Return code:", e.returncode)
        print("Output:", e.output)
        print("Errors:", e.stderr)
