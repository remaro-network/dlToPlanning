#!/bin/bash

# Resolve the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run the JAR with an absolute path
java -jar "$SCRIPT_DIR/build/libs/dlToPlanning-1.0-SNAPSHOT-all.jar" "$@"
