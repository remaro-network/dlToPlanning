package no.uio.tobiajoh.owl

import org.semanticweb.owlapi.model.*
import uk.ac.manchester.cs.owl.owlapi.*
import java.util.*


class OwlAssertionFactory {

    val assertionConstantFactory = OwlAssertionConstantFactory()


    fun inconsistentAssertion() : OwlAssertion {
        val relation = inferredName("Inconsistent")
        val variables: MutableList<OwlAssertionVariable> = mutableListOf()
        return OwlAssertion(relation, variables)
    }

    // creates rule assertion from swrlAtom
    // operates on lifted names for rules
    fun inferredRuleAssertion(ruleAtom : SWRLAtom) : OwlAssertion {
        val variables: MutableList<OwlAssertionVariable> = mutableListOf()
        val constants: MutableSet<OwlAssertionConstant> = mutableSetOf()


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
                is SWRLVariable -> OwlAssertionVariable("?" + it.iri.shortForm)
                is SWRLIndividualArgumentImpl -> OwlAssertionConstant((it.individual as OWLNamedIndividual).iri.shortForm)
                is SWRLLiteralArgument -> parseOWLLiteral(it.literal)
                else -> {
                    println("${it.javaClass} $it")
                    OwlAssertionVariable(it.toString())
                }
            }
        }.forEach { variable ->
            variables.add( variable )
        }
        return OwlAssertion(relation, variables)
    }

    // parses one data argument into a constant
    // the string of the constant contains the original content as well as the data tyoe
    private fun parseOWLLiteral(literal: OWLLiteral) : OwlAssertionConstant {
        return assertionConstantFactory.parseOWLLiteral(literal)
    }


    // create an assertion for an inferred class with the given variable
    fun inferredRuleAssertion(className : OWLClass, variable : OwlAssertionVariable) : OwlAssertion {
        val relation = inferredName(className.iri.shortForm)
        return OwlAssertion(relation, mutableListOf(variable))
    }

    // create an assertion for an inferred property with the given variable
    fun inferredRuleAssertion(predicateName : OWLProperty,
                              variable1 : OwlAssertionVariable,
                              variable2 : OwlAssertionVariable) : OwlAssertion {
        val relation = inferredName(predicateName.iri.shortForm)
        return OwlAssertion(relation, mutableListOf(variable1, variable2))
    }

    // create an assertion for a class with the given variable
    fun ruleAssertion(className : OWLClass, variable : OwlAssertionVariable) : OwlAssertion {
        val relation = className.iri.shortForm
        return OwlAssertion(relation, mutableListOf(variable))
    }

    // create an assertion for a class with the given variable
    fun ruleAssertion(predicateName : OWLProperty,
                      variable1 : OwlAssertionVariable,
                      variable2 : OwlAssertionVariable) : OwlAssertion {
        val relation = predicateName.iri.shortForm
        return OwlAssertion(relation, mutableListOf(variable1, variable2))
    }

    // create an assertion for a generic relation with the given variable
    fun ruleAssertion(relation : String,
                      variable1 : OwlAssertionVariable,
                      variable2 : OwlAssertionVariable) : OwlAssertion {
        return OwlAssertion(relation, mutableListOf(variable1, variable2))
    }

    fun parseOWLABoxAxiom(axiom : OWLLogicalAxiom, parseDataProperties: Boolean) : OwlAssertion? {
        return when (axiom) {
            is OWLClassAssertionAxiom -> parseClassAssertionAxiom(axiom)
            is OWLObjectPropertyAssertionAxiom -> parseObjectPropertyAxiom(axiom)
            is OWLDataPropertyAssertionAxiom -> if (parseDataProperties) parseDataPropertyAxiom(axiom) else null
            else -> null
        }

    }

    private fun parseClassAssertionAxiom(axiom : OWLClassAssertionAxiom) : OwlAssertion {
        val owlClass = axiom.classExpression.asOWLClass()
        val individual = axiom.individual.asOWLNamedIndividual().iri.shortForm
        return this.ruleAssertion(owlClass, OwlAssertionConstant(individual))
    }

    private fun parseObjectPropertyAxiom(axiom : OWLObjectPropertyAssertionAxiom) : OwlAssertion {
        val owlProperty = axiom.property.asOWLObjectProperty()
        val owlSubject = axiom.subject.asOWLNamedIndividual().iri.shortForm
        val owlObject = axiom.`object`.asOWLNamedIndividual().iri.shortForm
        return this.ruleAssertion(owlProperty, OwlAssertionConstant(owlSubject), OwlAssertionConstant(owlObject))
    }

    private fun parseDataPropertyAxiom(axiom : OWLDataPropertyAssertionAxiom) : OwlAssertion {
        val owlProperty = axiom.property.asOWLDataProperty().iri.shortForm
        val owlSubject = axiom.subject.asOWLNamedIndividual().iri.shortForm
        val literal = parseOWLLiteral(axiom.`object`)
        return this.ruleAssertion(owlProperty, OwlAssertionConstant(owlSubject), literal)
    }

    private fun inferredName(name: String) : String {
        val capitalizedName = name.replaceFirstChar {
            if (it.isLowerCase()) it.titlecase(Locale.getDefault())
            else it.toString()
        }

        return "inferred-$capitalizedName"
    }
}