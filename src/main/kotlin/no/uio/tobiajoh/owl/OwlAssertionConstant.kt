package no.uio.tobiajoh.owl

// owl object (variable in assertion) that are referred to but that is a specific object
// at the same time (i.e., no variable)
open class OwlAssertionConstant(name: String) : OwlAssertionVariable(name)  {
    // type of the constant in PDDL. Default: object
    private var pddlType = "object"

    // the name of the constant as a variable
    fun variableName() : String {
        return "?$name"
    }

    fun setPddlType(pddlType: String) {
        this.pddlType = pddlType
    }

    open fun getPddlType() : String {
        return  pddlType
    }
}