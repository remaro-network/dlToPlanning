package no.uio.tobiajoh.rules


// one assertion as part of a derivation rule
class RuleAssertion(
    private val relation: String,
    public val variables: Set<RuleVariable>) {

    private var negated = false // flag that indicates if the assertion is negated or not

    private val constants = variables.filterIsInstance<RuleConstant>().toSet()

    // introduce getter whose name is in line with other classes
    val usedConstants : Set<RuleConstant> get() = constants

    // return predicate with arity
    fun usedPredicates() : Map<String, Int> {
        return mapOf(Pair(relation, variables.size))
    }

    override fun toString() : String {
        var s = "$relation("
        for (v in variables)
            s += variables.toString()
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
            if (v is RuleConstant)
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