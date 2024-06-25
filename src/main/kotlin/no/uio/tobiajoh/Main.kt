package no.uio.tobiajoh

import org.semanticweb.owlapi.apibinding.OWLManager
import java.io.File


fun main() {
    val manager = OWLManager.createOWLOntologyManager()

    val ont = manager.loadOntologyFromOntologyDocument(File("examples/example_no_Abox.ttl"))

    val translator = OntologyTranslator()
    translator.translateOWL(ont)

    println("Hello World!")
}