package no.uio.tobiajoh.owl

// represents a derivation rule
class DerivationRule(
    private val head : OwlAssertion,
    singleCondition : List<OwlAssertion>?,
    private val boundedVariables : Set<OwlAssertionVariable>) {

    // our condition is a list, as one can add more arguments in the future
    private val condition : MutableList<List<OwlAssertion>> =
        if (singleCondition!=null)
            mutableListOf(singleCondition)
        else
            mutableListOf()

    // constructor without bounded variables
    constructor(head : OwlAssertion,
                condition : List<OwlAssertion>) : this(
                    head,
                    condition,
                    setOf(),
                )

    // constructor with only one assertion in condition
    constructor(head : OwlAssertion,
                condition : OwlAssertion) : this(
        head,
        listOf(condition),
        setOf(),
    )

    // constructor with only one assertion in condition
    constructor(head : OwlAssertion,
                condition : OwlAssertion,
                boundedVariables : Set<OwlAssertionVariable>) : this(
        head,
        listOf(condition),
        boundedVariables,
    )


    // collects all constants used in the contained assertions
    val usedConstants : Set<OwlAssertionConstant>
        get() = condition.flatMap{ clause ->
            clause.flatMap { it.usedConstants }
        }.toSet().union(usedHeadConstants)

    val usedHeadConstants : Set<OwlAssertionConstant>
        get() = head.usedConstants


    fun addCondition(newCondition: List<OwlAssertion>) {
        condition.add(newCondition)
    }

    // the predicates used in this rule
    fun usedPredicates() : Map<String, Int> {
        val pred = mutableMapOf(head.usedPredicate())
        condition.forEach { disjunct ->
            disjunct.forEach { assertion ->
                pred += assertion.usedPredicate()
            }
        }
        return pred
    }


    override fun toString(): String {
        return "$head <- ${condition.forEach { it.joinToString("&") + " | "}}"
    }

    // output PDDL syntax with initial tab indentation
    fun toPDDL(initialTabCount : Int) : String {
        // if there is no condition --> empty "or" --> always false --> no rule created
        if (condition.size == 0)
            return ""

        var tabCount = initialTabCount

        // use in head version, where constants are turned into variables
        var s = "${tabs(tabCount)}(:derived ${head.toPDDLAllVariables()} \n"


        // input equality for head constants
        if (usedHeadConstants.isNotEmpty()){
            tabCount++
            s += "${tabs(tabCount)}(and\n" +
                    usedHeadConstants.joinToString(separator = "\n", postfix = "\n") { const ->
                "${tabs(tabCount+1)}(= ${const.variableName()} $const)"
            }
        }


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

        if (usedHeadConstants.isNotEmpty()){
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
