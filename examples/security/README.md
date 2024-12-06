Convert owl to pddl:
```Bash
./OWLToPDDL.sh --owl=examples/security/security_with_imports.owl --tBox --inDomain=examples/security/security_domain.pddl --outDomain=examples/security/security_domain_created.pddl --aBox --inProblem=examples/security/security_problem.pddl --outProblem=examples/security/security_problem_created.pddl --replace-output --add-num-comparisons
```

Run planner:
```Bash
./symk.sif examples/security/security_domain_created.pddl examples/security/security_problem_created.pddl --search "sym_bd()"
```
