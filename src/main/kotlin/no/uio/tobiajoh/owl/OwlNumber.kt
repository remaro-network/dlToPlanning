package no.uio.tobiajoh.owl

// owl constant, representing a number
class OwlNumber(private val number: Double, name: String) : OwlAssertionConstant(name) {

    companion object {
        // the type that is used for numbers in pddl files
        const val PDDLTYPE = "number"
        // relation, that is used for the comparison operator in pddl files
        const val EQUIVALENT = "equalTo"
        const val LESSRELATION = "lessThan"
    }

    // operator to compare two numbers
    // note: only indicates, which number is larger, not by how much
    operator fun compareTo(otherNumber: OwlNumber) : Int {
        val n1 = number
        val n2 = otherNumber.number
        return if (n1 == n2)
            0
        else if (n1 <= n2)
            -1
        else
            1
    }
}