package no.uio.tobiajoh.rules

import org.semanticweb.owlapi.model.*
import uk.ac.manchester.cs.owl.owlapi.OWLClassImpl
import uk.ac.manchester.cs.owl.owlapi.OWLDataPropertyImpl
import uk.ac.manchester.cs.owl.owlapi.OWLObjectPropertyImpl
import uk.ac.manchester.cs.owl.owlapi.SWRLIndividualArgumentImpl
import java.util.*


class RuleAssertionFactory {

    fun inconsistentAssertion() : RuleAssertion {
        val relation = inferredName("Inconsistent")
        val variables: MutableSet<RuleVariable> = mutableSetOf()
        return RuleAssertion(relation, variables)
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
                is SWRLLiteralArgument -> parseOWLLiteral(it.literal)
                else -> {
                    println("${it.javaClass} $it")
                    RuleVariable(it.toString())
                }
            }
        }.forEach { variable ->
            variables.add( variable )
        }
        return RuleAssertion(relation, variables)
    }

    // parses one data argument into a constant
    // the string of the constant contains the original content as well as the data tyoe
    private fun parseOWLLiteral(literalArgument: OWLLiteral) : RuleConstant {
        val dataType = literalArgument.datatype
        val typeName = dataType.iri.shortForm
        val literal = literalArgument.literal
        return RuleConstant("${literal}_${typeName}")
    }


    // create an assertion for an inferred class with the given variable
    fun inferredRuleAssertion(className : OWLClass, variable : RuleVariable) : RuleAssertion {
        val relation = inferredName(className.iri.shortForm)
        return RuleAssertion(relation, mutableSetOf(variable))
    }

    // create an assertion for an inferred property with the given variable
    fun inferredRuleAssertion(predicateName : OWLProperty,
                              variable1 : RuleVariable,
                              variable2 : RuleVariable) : RuleAssertion {
        val relation = inferredName(predicateName.iri.shortForm)
        return RuleAssertion(relation, mutableSetOf(variable1, variable2))
    }

    // create an assertion for a class with the given variable
    fun ruleAssertion(className : OWLClass, variable : RuleVariable) : RuleAssertion {
        val relation = className.iri.shortForm
        return RuleAssertion(relation, mutableSetOf(variable))
    }

    // create an assertion for a class with the given variable
    fun ruleAssertion(predicateName : OWLProperty,
                      variable1 : RuleVariable,
                      variable2 : RuleVariable) : RuleAssertion {
        val relation = predicateName.iri.shortForm
        return RuleAssertion(relation, mutableSetOf(variable1, variable2))
    }

    // create an assertion for a generic relation with the given variable
    fun ruleAssertion(relation : String,
                      variable1 : RuleVariable,
                      variable2 : RuleVariable) : RuleAssertion {
        return RuleAssertion(relation, mutableSetOf(variable1, variable2))
    }

    fun parseOWLABoxAxiom(axiom : OWLLogicalAxiom, parseDataProperties: Boolean) : RuleAssertion? {
        return when (axiom) {
            is OWLClassAssertionAxiom -> parseClassAssertionAxiom(axiom)
            is OWLObjectPropertyAssertionAxiom -> parseObjectPropertyAxiom(axiom)
            is OWLDataPropertyAssertionAxiom -> if (parseDataProperties) parseDataPropertyAxiom(axiom) else null
            else -> null
        }

    }

    private fun parseClassAssertionAxiom(axiom : OWLClassAssertionAxiom) : RuleAssertion {
        val owlClass = axiom.classExpression.asOWLClass()
        val individual = axiom.individual.asOWLNamedIndividual().iri.shortForm
        return this.ruleAssertion(owlClass, RuleConstant(individual))
    }

    private fun parseObjectPropertyAxiom(axiom : OWLObjectPropertyAssertionAxiom) : RuleAssertion {
        val owlProperty = axiom.property.asOWLObjectProperty()
        val owlSubject = axiom.subject.asOWLNamedIndividual().iri.shortForm
        val owlObject = axiom.`object`.asOWLNamedIndividual().iri.shortForm
        return this.ruleAssertion(owlProperty, RuleConstant(owlSubject), RuleConstant(owlObject))
    }

    private fun parseDataPropertyAxiom(axiom : OWLDataPropertyAssertionAxiom) : RuleAssertion {
        val owlProperty = axiom.property.asOWLDataProperty().iri.shortForm
        val owlSubject = axiom.subject.asOWLNamedIndividual().iri.shortForm
        val literal = parseOWLLiteral(axiom.`object`)
        return this.ruleAssertion(owlProperty, RuleConstant(owlSubject), literal)
    }

    private fun inferredName(name: String) : String {
        val capitalizedName = name.replaceFirstChar {
            if (it.isLowerCase()) it.titlecase(Locale.getDefault())
            else it.toString()
        }

        return "inferred-$capitalizedName"
    }
}