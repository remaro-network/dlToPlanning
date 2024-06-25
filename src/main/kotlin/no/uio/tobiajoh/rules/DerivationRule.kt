package no.uio.tobiajoh.rules

import org.semanticweb.owlapi.model.*
import uk.ac.manchester.cs.owl.owlapi.OWLClassImpl
import uk.ac.manchester.cs.owl.owlapi.OWLObjectPropertyImpl

// represents a derivation rule
class DerivationRule(
    private val head : RuleAssertion,
    singleCondition : List<RuleAssertion>?,
    private val boundedVariables : Set<RuleVariable>) {

    // our condition is a list, as one can add more arguments in the future
    private val condition : MutableList<List<RuleAssertion>> =
        if (singleCondition!=null)
            mutableListOf(singleCondition)
        else
            mutableListOf()

    // constructor without bounded variables
    constructor(head : RuleAssertion,
                condition : List<RuleAssertion>) : this(
                    head,
                    condition,
                    setOf()
                )

    // constructor with only one assertion in condition
    constructor(head : RuleAssertion,
                condition : RuleAssertion) : this(
        head,
        listOf(condition),
        setOf()
    )

    // constructor with only one assertion in condition
    constructor(head : RuleAssertion,
                condition : RuleAssertion,
                boundedVariables : Set<RuleVariable>) : this(
        head,
        listOf(condition),
        boundedVariables
    )

    fun addCondition(newCondition: List<RuleAssertion>) {
        condition.add(newCondition)
    }

    // the predicates used in this rule
    fun usedPredicates() : Map<String, Int> {
        val pred = head.usedPredicates().toMutableMap()
        condition.forEach { disjunct ->
            disjunct.forEach { assertion ->
                pred += assertion.usedPredicates()
            }
        }
        return pred
    }

    override fun toString(): String {
        return "$head <- ${condition.forEach { it.joinToString("&") + " | "}}"
    }

    // output PDDL syntax with initial tab indentation
    fun toPDDL(initialTabCount : Int) : String {
        var tabCount = initialTabCount
        var s = "${tabs(tabCount)}(:derived ${head.toPDDL()} \n"

        // if there is no condition --> empty "or" --> always false --> no rule creatd
        if (condition.size == 0)
            return ""

        // introduce existential operator, if necessary
        if (boundedVariables.isNotEmpty()) {
            tabCount++
            s += "${tabs(tabCount)}(exists (${boundedVariables.joinToString(" ")})\n "
        }

        if (condition.size != 1) {
            tabCount++
            s += "${tabs(tabCount)}(or \n "
        }

        // add descriptions for all conditions
        tabCount++
        for (c in condition)
            s += "${tabs(tabCount)}(and\n" +
                "${tabs(tabCount+1)}${
                    c.joinToString("\n${tabs(tabCount+1)}") { it.toPDDL() }
                }\n" +
                "${tabs(tabCount)})\n"
        tabCount--

        // close brackets
        if (condition.size != 1) {
            s += "${tabs(tabCount)}) \n "
            tabCount--

        }

        // close brackets
        if (boundedVariables.isNotEmpty()) {
            s += "${tabs(tabCount)})\n "
            tabCount--
        }
        s += "${tabs(tabCount)})\n"

       return s
    }

    fun toPDDL(): String {
        return toPDDL(0)
    }

    // returns "n" tabs
    private fun tabs(n : Int) : String {
        return "\t".repeat(n)
    }

}
