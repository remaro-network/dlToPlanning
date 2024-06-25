package no.uio.tobiajoh

import org.semanticweb.owlapi.apibinding.OWLManager
import com.github.ajalt.clikt.core.CliktCommand
import no.uio.tobiajoh.pddl.RuleInjector
import java.io.File

class Main : CliktCommand() {

    override fun run() {
        val manager = OWLManager.createOWLOntologyManager()

        val ont = manager.loadOntologyFromOntologyDocument(File("examples/firstDomain/example.ttl"))

        val translator = OntologyTranslator()
        val rules = translator.translateOWL(ont)

        val rI = RuleInjector()
        rI.addRules(rules)
        rI.addToDomain(
            File("examples/firstDomain/domain.pddl"),
            File("examples/firstDomain/domain_created.pddl")
        )

    }
}


fun main(args: Array<String>) = Main().main(args)
