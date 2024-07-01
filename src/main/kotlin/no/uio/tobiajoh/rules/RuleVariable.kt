package no.uio.tobiajoh.rules



open class RuleVariable (private val name: String) {
    override fun toString(): String {
        return name
    }

    override fun equals(other: Any?): Boolean {
        if (other is RuleVariable)
            return this.toString() == other.toString()
        return false
    }

    override fun hashCode(): Int {
        return name.hashCode()
    }

}