package no.uio.tobiajoh

import org.semanticweb.owlapi.apibinding.OWLManager
import com.github.ajalt.clikt.core.CliktCommand
import com.github.ajalt.clikt.parameters.arguments.argument
import com.github.ajalt.clikt.parameters.options.flag
import com.github.ajalt.clikt.parameters.options.option
import com.github.ajalt.clikt.parameters.types.file
import no.uio.tobiajoh.pddl.RuleInjector
import java.io.File

class Main : CliktCommand() {

    private val inputFile by option("--in", "-i", help="Name for input PDDL file.").file()
    private val owlFile by option("--owl", "--ont", "--tbox", "--kb", "-k",
        help="Name for OWL file / knowledge base.").file()
    private val outputFile by option("--out", "--result", "-o", help="Name for resulting PDDL file.").file()
    private val overwriteOutput by option("--replace-output", "-r",
        help = "Set flag to replace output PDDL file if it already exists").flag()

    override fun run() {
        if (inputFile == null || !inputFile!!.exists()) {
            println("ERROR: Please provide an existing input PDDL file.")
            return
        }

        if (outputFile == null || !owlFile!!.exists()) {
            println("ERROR: Please provide an existing OWL file.")
            return
        }

        if (outputFile == null) {
            println("ERROR: Please provide an output PDDL file.")
            return
        }

        if (outputFile!!.exists() && !overwriteOutput){
            println("ERROR: Output file does already exists and can not be replaced." +
                    "Consider changing the name of the output file or setting the \"--replace-output\" flag.")
            return
        }

        putTBoxIntoPDDL(
            owlFile!!,
            inputFile!!,
            outputFile!!
        )

    }

    private fun putTBoxIntoPDDL(owlFile : File,
                                inputPDDL : File,
                                outputPDDL : File) {
        val manager = OWLManager.createOWLOntologyManager()

        val ont = manager.loadOntologyFromOntologyDocument(owlFile)

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


fun main(args: Array<String>) = Main().main(args)
