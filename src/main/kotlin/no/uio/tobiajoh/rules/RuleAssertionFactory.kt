package no.uio.tobiajoh.rules

import org.semanticweb.owlapi.model.OWLClass
import org.semanticweb.owlapi.model.OWLObjectProperty
import org.semanticweb.owlapi.model.SWRLAtom
import org.semanticweb.owlapi.model.SWRLVariable
import uk.ac.manchester.cs.owl.owlapi.OWLClassImpl
import uk.ac.manchester.cs.owl.owlapi.OWLObjectPropertyImpl
import java.util.*


class RuleAssertionFactory {

    fun inconsistentAssertion() : RuleAssertion {
        val relation = "inferredInconsistent"
        val variables: MutableSet<RuleVariable> = mutableSetOf()
        return RuleAssertion(relation, variables)
    }

    // creates rule assertion from swrlAtom
    // operates on lifted names for rules
    fun inferredRuleAssertion(ruleAtom : SWRLAtom) : RuleAssertion {
        val variables: MutableSet<RuleVariable> = mutableSetOf()

        val predicate = ruleAtom.predicate
        // parse head
        val relation = inferredName(
            when (predicate) {
                is OWLClassImpl -> predicate.iri.shortForm
                is OWLObjectPropertyImpl -> predicate.iri.shortForm
                else -> predicate.toString()
            }
        )

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
    fun inferredRuleAssertion(className : OWLClass, variable : RuleVariable) : RuleAssertion {
        val relation = inferredName(className.iri.shortForm)
        return RuleAssertion(relation, mutableSetOf(variable))
    }

    // create an assertion for a class with the given variable
    fun inferredRuleAssertion(predicateName : OWLObjectProperty,
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
    fun ruleAssertion(predicateName : OWLObjectProperty,
                      variable1 : RuleVariable,
                      variable2 : RuleVariable) : RuleAssertion {
        val relation = predicateName.iri.shortForm
        return RuleAssertion(relation, mutableSetOf(variable1, variable2))
    }

    private fun inferredName(name: String) : String {
        val capitalizedName = name.replaceFirstChar {
            if (it.isLowerCase()) it.titlecase(Locale.getDefault())
            else it.toString()
        }

        return "inferred-$capitalizedName"
    }
}