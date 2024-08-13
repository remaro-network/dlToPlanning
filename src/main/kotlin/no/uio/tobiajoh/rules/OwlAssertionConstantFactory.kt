package no.uio.tobiajoh.rules

import org.semanticweb.owlapi.model.IRI
import org.semanticweb.owlapi.model.OWLLiteral
import uk.ac.manchester.cs.owl.owlapi.OWLDatatypeImpl

class OwlAssertionConstantFactory {
    val decimal = OWLDatatypeImpl(IRI.create("http://www.w3.org/2001/XMLSchema#decimal"))

    // set of all datatypes that represent numbers (that we can parse)
    val supportedNumberTypes = setOf(decimal)

    fun parseOWLLiteral(literalArgument: OWLLiteral) : OwlAssertionConstant {
        val dataType = literalArgument.datatype
        val typeName = dataType.iri.shortForm
        val literal = literalArgument.literal
        val name = "${literal}_${typeName}"

        // return number if possible
        return  if (supportedNumberTypes.contains(dataType))
            parseNumberLiteral(literalArgument, name)
        else
            OwlAssertionConstant(name)
    }

    private fun parseNumberLiteral(literalArgument: OWLLiteral, name: String) : OwlNumber {
        return when (literalArgument.datatype) {
            decimal -> parseDecimal(literalArgument.literal, name)
            else -> {
                assert(false) {"datatype ${literalArgument.datatype} not supported to parse to number"}
                OwlNumber(0.0, "error")
            }
        }
    }

    private fun parseDecimal(d: String, name: String) : OwlNumber{
        val number = d.toDouble()
        return OwlNumber(number, name)
    }
}