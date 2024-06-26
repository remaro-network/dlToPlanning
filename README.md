# DL Axioms to PDDL Planning

- translates OWL TBox axioms to PDDL derived predicates

## Build
build project by running
  `./gradlew shadowJar`
## Usage
- run translation from OWL axioms to PDDL with
  `./OWLToPDDL.sh --in=<inputPDDL> --owl=<inputOWL> --out=<outputPDDL> [OPTIONS]`
  e.g. `./OWLToPDDL.sh --in=examples/firstDomain/domain.pddl --owl=examples/firstDomain/example.ttl --out=examples/firstDomain/domain_created.pddl --replace-output`
  - run `./OWLToPDDL.sh -h`to see all options
 
## Planning
- I recommend using [SYMK planner](https://github.com/speckdavid/symk), as it works quite well so far and should be good for derived predicates [paper: "Symbolic Planning with Axioms"](https://speckdavid.github.io/assets/pdf/speck-etal-icaps2019.pdf)
