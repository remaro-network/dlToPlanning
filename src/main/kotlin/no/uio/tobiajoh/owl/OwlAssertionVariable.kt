package no.uio.tobiajoh.owl


// an object (variable) that occurs in an assertion in the ontology
open class OwlAssertionVariable (open val name: String) {
    override fun toString(): String {
        return name
    }

    override fun equals(other: Any?): Boolean {
        if (other is OwlAssertionVariable)
            return this.toString() == other.toString()
        return false
    }

    override fun hashCode(): Int {
        return name.hashCode()
    }

}