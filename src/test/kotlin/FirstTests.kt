import io.kotlintest.specs.StringSpec
import no.uio.tobiajoh.OntologyTranslator
import no.uio.tobiajoh.pddl.RuleInjector
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
            val rules = translator.translateOWL(ont)

            val rI = RuleInjector()
            rI.addRules(rules)
            rI.addToDomain(
                inputPDDL,
                outputPDDL
            )
        }
    }
}