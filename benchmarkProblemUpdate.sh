#!/bin/bash

# usage: ./runPlanner.sh DOMAIN PROBLEM

iterations=10

start1=`date +%s.%N`


start0=`date +%s.%N`

for i in $(seq 1 $iterations);
do
    # update problem file (using the exported additions)
    java -jar build/libs/dlToPlanning-1.0-SNAPSHOT-all.jar
done
end0=`date +%s.%N`
runtime0=$( echo "($end0 - $start0) / $iterations" | bc -l )


for i in $(seq 1 $iterations);
do
    # update problem file using orl file (without exporting additions)
    java -jar build/libs/dlToPlanning-1.0-SNAPSHOT-all.jar --owl=examples/suave/suave_with_imports.owl --aBox --inProblem=examples/suave/suave_problem.pddl --outProblem=examples/suave/suave_problem_created.pddl --replace-output --add-num-comparisons

done
end1=`date +%s.%N`
runtime1=$( echo "($end1 - $start1) / $iterations" | bc -l )


start2=`date +%s.%N`

for i in $(seq 1 $iterations);
do
    # update problem file (using the exported additions)
    java -jar build/libs/dlToPlanning-1.0-SNAPSHOT-all.jar --aBox --inProblem=examples/suave/suave_problem.pddl --outProblem=examples/suave/suave_problem_created.pddl --replace-output --add-num-comparisons --import-problem-additions --problem-additions=examples/suave/exportedAdditions.txt
done
end2=`date +%s.%N`
runtime2=$( echo "($end2 - $start2) / $iterations" | bc -l )

echo no work: $runtime0
echo with owl: $runtime1
echo with update: $runtime2

