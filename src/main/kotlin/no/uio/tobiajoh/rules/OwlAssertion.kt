package no.uio.tobiajoh.rules


// one assertion as part of a derivation rule
class OwlAssertion(
    private val relation: String,
    public val variables: List<OwlAssertionVariable>) {

    private var negated = false // flag that indicates if the assertion is negated or not

    private val constants = variables.filterIsInstance<OwlAssertionConstant>().toSet()
    private val numbers = variables.filterIsInstance<OwlNumber>().toSet()


    // introduce getter whose name is in line with other classes
    val usedConstants : Set<OwlAssertionConstant> get() = constants
    val usedNumbers : Set<OwlNumber> get() = numbers

    // return predicate with arity
    fun usedPredicates() : Map<String, Int> {
        return mapOf(Pair(relation, variables.size))
    }

    override fun toString() : String {
        var s = "$relation("
        for (v in variables) {
            s += "$v "
        }
        return "$s) "
    }

    fun toPDDL() : String {
        return if (negated)
                "(not ($relation ${variables.joinToString(" ")}))"
            else
                "($relation ${variables.joinToString(" ")})"
    }

    // produces PDDL representation, but constants also get turned into corresponding variables
    fun toPDDLAllVariables() : String {
        val vars = variables.joinToString(" ") {v ->
            if (v is OwlAssertionConstant)
                v.variableName()
            else
                v.toString()
        }

        return if (negated)
                "(not ($relation $vars))"
            else
                "($relation $vars)"
    }

    fun negate() {
        negated = !negated
    }
}