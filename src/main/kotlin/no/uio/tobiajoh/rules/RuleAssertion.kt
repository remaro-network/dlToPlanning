package no.uio.tobiajoh.rules

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