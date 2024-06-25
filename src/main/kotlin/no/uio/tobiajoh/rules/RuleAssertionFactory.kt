package no.uio.tobiajoh.rules

import org.semanticweb.owlapi.model.OWLClass
import org.semanticweb.owlapi.model.SWRLAtom
import org.semanticweb.owlapi.model.SWRLVariable
import uk.ac.manchester.cs.owl.owlapi.OWLClassImpl
import uk.ac.manchester.cs.owl.owlapi.OWLObjectPropertyImpl


class RuleAssertionFactory {
    // creates rule assertion from swrlAtom
    fun ruleAssertion(ruleAtom : SWRLAtom) : RuleAssertion {
        val variables: MutableSet<RuleVariable> = mutableSetOf()

        val predicate = ruleAtom.predicate
        // parse head
        val relation =
            when (predicate) {
                is OWLClassImpl -> predicate.iri.shortForm
                is OWLObjectPropertyImpl -> predicate.iri.shortForm
                else -> predicate.toString()
            }

        // add variables to set
        ruleAtom.allArguments.map {
            val rv = (it as SWRLVariable)
            RuleVariable("?" + rv.iri.shortForm)
        }.forEach {
            variables.add( it )
        }
        return RuleAssertion(relation, variables)
    }

    // create an assertion for a class with the given variable
    fun ruleAssertion(className : OWLClass, variable : RuleVariable) : RuleAssertion {
        val relation = className.iri.shortForm
        return RuleAssertion(relation, mutableSetOf(variable))
    }

}