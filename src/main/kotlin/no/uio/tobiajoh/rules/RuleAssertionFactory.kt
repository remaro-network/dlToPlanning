package no.uio.tobiajoh.rules

import org.eclipse.jgit.lib.Constants
import org.semanticweb.owlapi.model.DataRangeType
import org.semanticweb.owlapi.model.IRI
import org.semanticweb.owlapi.model.OWLClass
import org.semanticweb.owlapi.model.OWLDataProperty
import org.semanticweb.owlapi.model.OWLNamedIndividual
import org.semanticweb.owlapi.model.OWLObjectProperty
import org.semanticweb.owlapi.model.SWRLAtom
import org.semanticweb.owlapi.model.SWRLLiteralArgument
import org.semanticweb.owlapi.model.SWRLVariable
import uk.ac.manchester.cs.owl.owlapi.OWLClassImpl
import uk.ac.manchester.cs.owl.owlapi.OWLDataPropertyImpl
import uk.ac.manchester.cs.owl.owlapi.OWLObjectPropertyImpl
import uk.ac.manchester.cs.owl.owlapi.SWRLIndividualArgumentImpl
import java.util.*


class RuleAssertionFactory {

    fun inconsistentAssertion() : RuleAssertion {
        val relation = inferredName("Inconsistent")
        val variables: MutableSet<RuleVariable> = mutableSetOf()
        val constants: Set<RuleConstant> = setOf()
        return RuleAssertion(relation, variables, constants)
    }

    // creates rule assertion from swrlAtom
    // operates on lifted names for rules
    fun inferredRuleAssertion(ruleAtom : SWRLAtom) : RuleAssertion {
        val variables: MutableSet<RuleVariable> = mutableSetOf()
        val constants: MutableSet<RuleConstant> = mutableSetOf()


        val predicate = ruleAtom.predicate
        // parse head
        val relation = inferredName(
            when (predicate) {
                is OWLClassImpl -> predicate.iri.shortForm
                is OWLObjectPropertyImpl -> predicate.iri.shortForm
                is OWLDataPropertyImpl -> predicate.iri.shortForm
                is IRI -> predicate.shortForm
                else -> predicate.toString()
            }
        )
        // add variables to set
        ruleAtom.allArguments.map {
            when (it ) {
                is SWRLVariable -> RuleVariable("?" + it.iri.shortForm)
                is SWRLIndividualArgumentImpl -> RuleConstant((it.individual as OWLNamedIndividual).iri.shortForm)
                is SWRLLiteralArgument -> parseSWRLLiteral(it)
                else -> {
                    println("${it.javaClass} $it")
                    RuleVariable(it.toString())
                }
            }
        }.forEach { variable ->
            variables.add( variable )
            if (variable is RuleConstant)
                constants.add(variable)
        }
        return RuleAssertion(relation, variables, constants)
    }

    // parses one data argument into a constant
    // the string of the constant contains the original content as well as the data tyoe
    private fun parseSWRLLiteral(literalArgument: SWRLLiteralArgument) : RuleConstant {
        val literal = literalArgument.literal
        val dataType = literalArgument.literal.datatype
        val typeName = dataType.iri.shortForm
        return RuleConstant("${literal.literal}_${typeName}")
    }




    // create an assertion for an inferred class with the given variable
    fun inferredRuleAssertion(className : OWLClass, variable : RuleVariable) : RuleAssertion {
        val relation = inferredName(className.iri.shortForm)
        return RuleAssertion(relation, mutableSetOf(variable), setOf())
    }

    // create an assertion for an inferred property with the given variable
    fun inferredRuleAssertion(predicateName : OWLObjectProperty,
                              variable1 : RuleVariable,
                              variable2 : RuleVariable) : RuleAssertion {
        val relation = inferredName(predicateName.iri.shortForm)
        return RuleAssertion(relation, mutableSetOf(variable1, variable2), setOf())
    }

    // create an assertion for an inferred property with the given variable
    fun inferredRuleAssertion(predicateName : OWLDataProperty,
                              variable1 : RuleVariable,
                              variable2 : RuleVariable) : RuleAssertion {
        val relation = inferredName(predicateName.iri.shortForm)
        return RuleAssertion(relation, mutableSetOf(variable1, variable2), setOf())
    }

    // create an assertion for a class with the given variable
    fun ruleAssertion(className : OWLClass, variable : RuleVariable) : RuleAssertion {
        val relation = className.iri.shortForm
        return RuleAssertion(relation, mutableSetOf(variable), setOf())
    }

    // create an assertion for a class with the given variable
    fun ruleAssertion(predicateName : OWLObjectProperty,
                      variable1 : RuleVariable,
                      variable2 : RuleVariable) : RuleAssertion {
        val relation = predicateName.iri.shortForm
        return RuleAssertion(relation, mutableSetOf(variable1, variable2), setOf())
    }

    // create an assertion for a generic relation with the given variable
    fun ruleAssertion(relation : String,
                      variable1 : RuleVariable,
                      variable2 : RuleVariable) : RuleAssertion {
        return RuleAssertion(relation, mutableSetOf(variable1, variable2), setOf())
    }

    private fun inferredName(name: String) : String {
        val capitalizedName = name.replaceFirstChar {
            if (it.isLowerCase()) it.titlecase(Locale.getDefault())
            else it.toString()
        }

        return "inferred-$capitalizedName"
    }
}