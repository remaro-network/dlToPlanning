package no.uio.tobiajoh.owl

// owl object (variable in assertion) that are referred to but that is a specific object
// at the same time (i.e., no variable)
open class OwlAssertionConstant(name: String) : OwlAssertionVariable(name)  {
    fun variableName() : String {
        return "?$name"
    }
}