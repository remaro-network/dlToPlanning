package no.uio.tobiajoh

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
        return "(:derived ${head.toPDDL()} \n" +
                    "\t(exists (${boundedVariables.joinToString(" ")})\n" +
                    "\t\t(and\n" +
                        "\t\t\t${condition.joinToString("\n\t\t\t") { it.toPDDL() }}\n" +
                    "\t\t)\n"+
                    "\t)\n"+
                ")"
    }
}


class RuleAssertion(
    private val relation: String,
    public val variables: Set<RuleVariable>) {

    override fun toString() : String {
        var s = "$relation("
        for (v in variables)
            s += variables.toString()
        return "$s) "
    }

    fun toPDDL() : String {
        return "($relation ${variables.joinToString(" ")})"
    }
}

class RuleAssertionFactory {
    // creates rule assertion from swrlAtom
    fun ruleAssertion(ruleAtom : SWRLAtom) : RuleAssertion {
        val variables: MutableSet<RuleVariable> = mutableSetOf()

        val predicate = ruleAtom.predicate
        // parse head
        val relation =
            when (predicate) {
                is OWLClassImpl -> predicate.iri.shortForm
                is OWLObjectPropertyImpl -> predicate.iri.shortForm
                else -> predicate.toString()
            }

        // add variables to set
        ruleAtom.allArguments.map {
            val rv = (it as SWRLVariable)
            RuleVariable(rv.iri.shortForm)
        }.forEach {
            variables.add( it )
        }
        return RuleAssertion(relation, variables)
    }
}

class RuleVariable (private val name: String) {
    override fun toString(): String {
        return name
    }

    override fun equals(other: Any?): Boolean {
        if (other is RuleVariable)
            return this.toString().equals(other.toString())
        return false
    }

    override fun hashCode(): Int {
        return name.hashCode()
    }

}