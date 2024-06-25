package no.uio.tobiajoh.rules

// one assertion as part of a derivation rule
class RuleAssertion(
    private val relation: String,
    public val variables: Set<RuleVariable>) {

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
        return "($relation ${variables.joinToString(" ")})"
    }
}