Convert owl to pddl:
```Bash
./OWLToPDDL.sh --owl=examples/suave/suave_with_imports.owl --tBox --inDomain=examples/suave/suave_domain.pddl --outDomain=examples/suave/suave_domain_created.pddl --aBox --inProblem=examples/suave/suave_problem.pddl --outProblem=examples/suave/suave_problem_created.pddl --replace-output
```

Run planner:
```Bash
./symk.sif examples/suave/suave_domain_created.pddl examples/suave/suave_problem_created.pddl --search "sym_bd()"
```
