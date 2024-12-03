import io.kotlintest.specs.StringSpec
import no.uio.tobiajoh.OntologyTranslator
import no.uio.tobiajoh.pddl.PDDLInjector
import org.semanticweb.owlapi.apibinding.OWLManager
import java.io.File

class FirstTests : StringSpec() {
    init {
        "translating TBox axioms from toy example and input it into file" {
            val exampleOntology = File("src/test/resources/firstDomain/example.ttl")

            val inputPDDL = File("src/test/resources/firstDomain/domain.pddl")
            val outputPDDL = File("src/test/resources/firstDomain/domain_created.pddl")

            val manager = OWLManager.createOWLOntologyManager()
            val ont = manager.loadOntologyFromOntologyDocument(exampleOntology)

            val translator = OntologyTranslator()
            val rules = translator.addRules(ont)

            val rI = PDDLInjector()
            rI.addRules(rules)
            rI.addToDomain(
                inputPDDL,
                outputPDDL
            )
        }
    }

    init {
        "translating ABox of Suave example" {
            val owlFile = File("src/test/resources/suave/suave_with_imports.owl")
            val inputPDDL = File("src/test/resources/suave/suave_problem.pddl")
            val outputPDDL = File("src/test/resources/suave/suave_problem_output.pddl")

            val manager = OWLManager.createOWLOntologyManager()
            val ont = manager.loadOntologyFromOntologyDocument(owlFile)

            val translator = OntologyTranslator()

            val addDataProperties = true
            val assertions = translator.addAssertions(ont, addDataProperties)

            val rI = PDDLInjector()

            rI.addAssertions(assertions)

            rI.addToProblem(
                inputPDDL,
                outputPDDL
            )
        }
    }

    init {
        "translating TBox of Suave example" {
            val owlFile = File("src/test/resources/suave/suave_with_imports.owl")
            val inputPDDL = File("src/test/resources/suave/suave_domain.pddl")
            val outputPDDL = File("src/test/resources/suave/suave_domain_output.pddl")
            val manager = OWLManager.createOWLOntologyManager()

            val ont = manager.loadOntologyFromOntologyDocument(owlFile)

            val translator = OntologyTranslator()
            val rules = translator.addRules(ont)

            //val usedConstants = rules.flatMap { it.usedConstants }.union(assertions.flatMap { it.usedConstants }).toSet()
            val usedConstants = rules.flatMap { it.usedConstants }.toSet() // individuals from ABox do not need to be declared as constants

            val rI = PDDLInjector()


            rI.addRules(rules)
            rI.addConstants(usedConstants)

            rI.addToDomain(
                inputPDDL,
                outputPDDL
            )
        }
    }
}