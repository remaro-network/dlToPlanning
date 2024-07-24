# DL Axioms to PDDL Planning

- translates OWL TBox axioms to PDDL derived predicates and inputs them into existing PDDL domain
- translates OWL ABox axioms to PDDL to assertions and inputs them into existing PDDL problem
- takes care of introducing new constants and objects, where necessary

## Build
build project by running

  `./gradlew shadowJar`
  
## Usage
- run insertion of OWL axioms into PDDL with
  
  `./OWLToPDDL.sh --owl=<inputOWL> --tBox --inDomain=e<inputPDDLdomain> --outDomain=<outputPDDLdomain> [OPTIONS]`
  
  `./OWLToPDDL.sh --owl=<inputOWL> --aBox --inProblem=<inputPDDLproblem> --outProblem=<outputPDDLproblem> [OPTIONS]`

  `./OWLToPDDL.sh --owl=<inputOWL> --tBox --inDomain=<inputPDDLdomain> --outDomain=<outputPDDLdomain> --aBox --inProblem=<inputPDDLproblem> --outProblem=<outputPDDLproblem> [OPTIONS]`

- only modifying PDDL domain by inserting TBox axioms, only modifying PDDL prblem by inserting ABox axioms or both are possible
  
- run `./OWLToPDDL.sh -h`to see all options
 
## Planning
- I recommend using [SYMK planner](https://github.com/speckdavid/symk), as it works quite well so far and should be good for derived predicates [paper: "Symbolic Planning with Axioms"](https://speckdavid.github.io/assets/pdf/speck-etal-icaps2019.pdf)
