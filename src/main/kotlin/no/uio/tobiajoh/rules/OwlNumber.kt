package no.uio.tobiajoh.rules

import org.semanticweb.owlapi.model.IRI
import org.semanticweb.owlapi.model.OWLLiteral
import uk.ac.manchester.cs.owl.owlapi.OWLDatatypeImpl

// owl constant, representing a number
class OwlNumber(val number: Double, name: String) : OwlAssertionConstant(name) {

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