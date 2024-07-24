package no.uio.tobiajoh

import org.semanticweb.owlapi.apibinding.OWLManager
import com.github.ajalt.clikt.core.CliktCommand
import com.github.ajalt.clikt.parameters.options.flag
import com.github.ajalt.clikt.parameters.options.option
import com.github.ajalt.clikt.parameters.types.file
import no.uio.tobiajoh.pddl.PDDLInjector
import java.io.File

class Main : CliktCommand() {

    private val owlFile by option("--owl", "--ont", "--kb",
        help="Name for OWL file / knowledge base.").file()

    private val insertTBox by option("--tBox", "-t",
        help = "Set flag to put TBox into domain").flag()
    private val inputDomainFile by option("--inD", "--inDomain", help="Name for input PDDL domain file.").file()
    private val outputDomainFile by option("--outD", "--outDomain", help="Name for resulting PDDL domain file.").file()

    private val insertABox by option("--aBox", "-a",
        help = "Set flag to put ABox into problem").flag()
    private val inputProblemFile by option("--inP", "--inProblem", help="Name for input PDDL problem file.").file()
    private val outputProblemFile by option("--outP", "--outProblem", help="Name for resulting PDDL problem file.").file()

    private val overwriteOutput by option("--replace-output", "-r",
        help = "Set flag to replace output PDDL file if it already exists").flag()

    private val ignoreDataProperties by option("--ignore-data-props",
        help = "Set flag to ignore data properties in ABox when translating to PDDL problem.").flag()
    
    private val rI = PDDLInjector()

    override fun run() {
        if (owlFile == null || !owlFile!!.exists()) {
            println("ERROR: Please provide an existing OWL file.")
            return
        }

        if (insertTBox) {
            if (inputDomainFile == null || !inputDomainFile!!.exists()) {
                println("ERROR: Please provide an existing input PDDL problem file.")
                return
            }

            if (outputDomainFile == null) {
                println("ERROR: Please provide an output PDDL problem file.")
                return
            }

            if (outputDomainFile!!.exists() && !overwriteOutput) {
                println(
                    "ERROR: Output file does already exists and can not be replaced." +
                            "Consider changing the name of the output file or setting the \"--replace-output\" flag."
                )
                return
            }
        }

        if (insertABox) {
            if (inputProblemFile == null || !inputProblemFile!!.exists()) {
                println("ERROR: Please provide an existing input PDDL problem file.")
                return
            }

            if (outputProblemFile == null) {
                println("ERROR: Please provide an output PDDL problem file.")
                return
            }

            if (outputProblemFile!!.exists() && !overwriteOutput) {
                println(
                    "ERROR: Output file does already exists and can not be replaced." +
                            "Consider changing the name of the output file or setting the \"--replace-output\" flag."
                )
                return
            }
        }

        if (!insertTBox && ! insertABox) {
            println("WARNING: neither ABox, not TBox are selected to be inserted into PDDL.")
            return
        }

        if (insertTBox)
            putTBoxIntoPDDL(
                owlFile!!,
                inputDomainFile!!,
                outputDomainFile!!
            )


        if (insertABox)
            putABoxIntoPDDL(
                owlFile!!,
                inputProblemFile!!,
                outputProblemFile!!
            )

    }

    private fun putTBoxIntoPDDL(owlFile : File,
                                inputPDDLDomain : File,
                                outputPDDLDomain : File) {
        val manager = OWLManager.createOWLOntologyManager()

        val ont = manager.loadOntologyFromOntologyDocument(owlFile)

        val translator = OntologyTranslator()
        val rules = translator.addRules(ont)

        //val usedConstants = rules.flatMap { it.usedConstants }.union(assertions.flatMap { it.usedConstants }).toSet()
        val usedConstants = rules.flatMap { it.usedConstants }.toSet() // individuals from ABox do not need to be declared as constants


        rI.addRules(rules)
        rI.addConstants(usedConstants)

        rI.addToDomain(
            inputPDDLDomain,
            outputPDDLDomain
        )
    }

    private fun putABoxIntoPDDL(owlFile : File,
                                inputPDDLProblem : File,
                                outputPDDLProblem : File) {

        val manager = OWLManager.createOWLOntologyManager()
        val ont = manager.loadOntologyFromOntologyDocument(owlFile)

        val translator = OntologyTranslator()

        val addDataProperties = !ignoreDataProperties
        val assertions = translator.addAssertions(ont, addDataProperties)

        rI.addAssertions(assertions)

        rI.addToProblem(
            inputPDDLProblem,
            outputPDDLProblem
        )
    }
}


fun main(args: Array<String>) = Main().main(args)
