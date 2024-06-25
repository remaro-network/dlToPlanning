package no.uio.tobiajoh

import org.semanticweb.owlapi.apibinding.OWLManager
import com.github.ajalt.clikt.core.CliktCommand
import java.io.File

class Main : CliktCommand() {

    override fun run() {
        val manager = OWLManager.createOWLOntologyManager()

        val ont = manager.loadOntologyFromOntologyDocument(File("examples/example_no_Abox.ttl"))

        val translator = OntologyTranslator()
        translator.translateOWL(ont)

    }
}


fun main(args: Array<String>) = Main().main(args)
