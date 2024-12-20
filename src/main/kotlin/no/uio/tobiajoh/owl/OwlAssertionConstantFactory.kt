package no.uio.tobiajoh.owl

import org.semanticweb.owlapi.apibinding.OWLManager
import org.semanticweb.owlapi.model.IRI
import org.semanticweb.owlapi.model.OWLIndividual
import org.semanticweb.owlapi.model.OWLLiteral
import org.semanticweb.owlapi.model.OWLNamedIndividual
import uk.ac.manchester.cs.owl.owlapi.OWLDatatypeImpl

class OwlAssertionConstantFactory {
    val decimal = OWLDatatypeImpl(IRI.create("http://www.w3.org/2001/XMLSchema#decimal"))
    val df = OWLManager.createOWLOntologyManager().owlDataFactory;

    // set of all datatypes that represent numbers (that we can parse)
    val supportedNumberTypes = setOf(decimal)

    fun getOwlAssertionConstant(name : String) : OwlAssertionConstant {
        return OwlAssertionConstant(name)
    }

    fun parseOWLIndividualWithType(ind: OWLNamedIndividual, pddlType: String) : OwlAssertionConstant{
        val a = OwlAssertionConstant(ind.iri.shortForm)
        a.setPddlType(pddlType)
        return a
    }

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
            decimal -> parseDecimal(literalArgument, name)
            else -> {
                assert(false) {"datatype ${literalArgument.datatype} not supported to parse to number"}
                OwlNumber(0.0, "error")
            }
        }
    }

    fun parseNumberFromString(pddlNumber : String) : OwlNumber? {
        val splitPddlNumber = pddlNumber.split("_")

        if (splitPddlNumber.size != 2) {
            println("WARNING: can not parse pddl number $pddlNumber")
            return null
        }

        val number = splitPddlNumber[0]
        val type = splitPddlNumber[1]

        val n : Double? = when (type) {
            "decimal" -> number.toDouble()
            else -> {
                println("WARNING: can not parse pddl number $pddlNumber (unsupported type)")
                null
            }
        }

        return if (n != null)
            OwlNumber(n, "${n}_${type}")
        else
            null
    }

    private fun parseDecimal(literal: OWLLiteral, name: String) : OwlNumber{
        val number = literal.parseDouble()
        return OwlNumber(number, name)
    }
}