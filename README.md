# DL Axioms to PDDL Planning

- translates OWL TBox axioms to PDDL derived predicates and inputs them into existing PDDL domain
- translates OWL ABox axioms to PDDL to assertions and inputs them into existing PDDL problem
- takes care of introducing new constants and objects, where necessary
- can introduce comparision between numbers from ontology in planning domain

## Build
build project by running

  `./gradlew shadowJar`

## Usage
- you can only modifying the PDDL domain by inserting TBox axioms, only modifying the PDDL problem by inserting ABox axioms or both
- run insertion of OWL axioms into PDDL with

  ```
  ./OWLToPDDL.sh --owl=<inputOWL> --tBox --inDomain=<inputPDDLdomain> --outDomain=<outputPDDLdomain> [OPTIONS]
  ```

  ```
  ./OWLToPDDL.sh --owl=<inputOWL> --aBox --inProblem=<inputPDDLproblem> --outProblem=<outputPDDLproblem> [OPTIONS]
  ```

  ```
  ./OWLToPDDL.sh --owl=<inputOWL> --tBox --inDomain=<inputPDDLdomain> --outDomain=<outputPDDLdomain> --aBox --inProblem=<inputPDDLproblem> --outProblem=<outputPDDLproblem> [OPTIONS]
  ```
### Options
- run `./OWLToPDDL.sh -h` to see all options.
- use `--ignore-data-props` to not export data properties to PDDL
- use `--add-num-comparisons` to add comparisons between numerical data occuring in the ontology. For numerical data, the special type `numerical-object` is used to represent it.
- use `--replace-output` to replace the PDDL files if they already exists. Per default, the output is not saved if the output file already exists

## Planning
- I recommend using [SYMK planner](https://github.com/speckdavid/symk), as it works quite well so far and should be good for derived predicates [paper: "Symbolic Planning with Axioms"](https://speckdavid.github.io/assets/pdf/speck-etal-icaps2019.pdf)

## Comments on Program File Update
To speed up updating the problem file, i.e. in settings where only the input PDDL problem file has changed but the domain file and the ontology stay the same, one can export the aBox axioms from the ontology that need to be added to the problem file for later usage. This saves time when the problem file needs to be updated, as the ontology does not need to be loaded anymore.
Use the following to export the additions to a file you like:
```
  java -jar build/libs/dlToPlanning-1.0-SNAPSHOT-all.jar --owl=<inputOWL> --export-problem-additions --problem-additions=<exportedAdditions>
```

Use the following to update the created problem file:
```
java -jar build/libs/dlToPlanning-1.0-SNAPSHOT-all.jar --aBox --inProblem=<inputPDDLproblem> --outProblem=<outputPDDLproblem> --replace-output --import-problem-additions --problem-additions=<exportedAdditions>
```

You can also export, while creating the problem and domain file, e.g. the first time the ontology is consulted and to use updates after that:
```
./OWLToPDDL.sh --owl=<inputOWL> --tBox --inDomain=<inputPDDLdomain> --outDomain=<outputPDDLdomain> --aBox --inProblem=<inputPDDLproblem> --outProblem=<outputPDDLproblem> --export-problem-additions --problem-additions=<exportedAdditions> [OPTIONS]
```

### Effect on Runtime
Using the update has a significant impact on the runtime. E.g. in one of our tests, reading from ontology required 0.73s, reading from exported file required 0.34s (where only loading the classes took already about 0.20s).

### ROS

```bash
ros2 run owl_to_pddl owl_to_pddl.py --owl=<inputOWL> --tBox --inDomain=<inputPDDLdomain> --outDomain=<outputPDDLdomain> [OPTIONS]
```

Example:
```bash
ros2 run owl_to_pddl owl_to_pddl.py --owl=examples/suave/suave_with_imports.owl --tBox --inDomain=examples/suave/suave_domain.pddl --outDomain=examples/suave/suave_domain_created.pddl --aBox --inProblem=examples/suave/suave_problem.pddl --outProblem=examples/suave/suave_problem_created.pddl --replace-output
```
