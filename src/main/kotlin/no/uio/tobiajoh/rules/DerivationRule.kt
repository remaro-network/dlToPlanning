package no.uio.tobiajoh.rules

import org.semanticweb.owlapi.model.*
import uk.ac.manchester.cs.owl.owlapi.OWLClassImpl
import uk.ac.manchester.cs.owl.owlapi.OWLObjectPropertyImpl

// represents a derivation rule
class DerivationRule(
    private val variables : Set<RuleVariable>,
    private val head : RuleAssertion,
    private val condition : List<RuleAssertion>,
    private val boundedVariables : Set<RuleVariable>) {


    override fun toString(): String {
        return "$head <- ${condition.joinToString(" ")}"
    }

    fun toPDDL() : String {
        if (boundedVariables.isEmpty())
            return if (condition.size == 1)
                "(:derived ${head.toPDDL()} \n" +
                    "\t${condition.joinToString("\n\t") { it.toPDDL() }}\n" +
                ")"
            else
                "(:derived ${head.toPDDL()} \n" +
                    "\t(and\n" +
                        "\t\t${condition.joinToString("\n\t\t") { it.toPDDL() }}\n" +
                    "\t)\n"+
                ")"
        else return "(:derived ${head.toPDDL()} \n" +
                "\t(exists (${boundedVariables.joinToString(" ")})\n" +
                    "\t\t(and\n" +
                        "\t\t\t${condition.joinToString("\n\t\t\t") { it.toPDDL() }}\n" +
                    "\t\t)\n"+
                "\t)\n"+
            ")"
    }
}
