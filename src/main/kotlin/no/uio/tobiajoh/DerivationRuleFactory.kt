package no.uio.tobiajoh

import org.semanticweb.owlapi.model.OWLAxiom
import org.semanticweb.owlapi.model.SWRLRule


class DerivationRuleFactory {
    fun derivationRule(axiom: OWLAxiom): DerivationRule? {
        return when (axiom) {
            is SWRLRule -> parseSWRLRule(axiom)
            else -> {
                println("WARNING: can not parse axiom $axiom.")
                null
            }
        }
    }


    private fun parseSWRLRule(rule: SWRLRule): DerivationRule? {
        val variables: MutableSet<RuleVariable> = mutableSetOf()
        val headVariables: MutableSet<RuleVariable> = mutableSetOf()

        val condition: MutableList<RuleAssertion> = mutableListOf()
        var headRelation = "true"

        // parse body
        for (element in rule.body){
            val newCondition = RuleAssertionFactory().ruleAssertion(element)
            condition.add(newCondition)
            newCondition.variables.forEach{ variables.add(it) }
        }

        // parse head
        if (rule.head.size != 1) {
            println("WARNING SWRL rules with more than one head element not supported yet")
            return null
        }
        val head = RuleAssertionFactory().ruleAssertion(rule.head.first())

        val boundedVariables: MutableSet<RuleVariable> = variables.toMutableSet()

        head.variables.forEach{
            headVariables.add(it)
            variables.add( it )
            boundedVariables.remove( it )
        }



        return DerivationRule(
            variables,
            head,
            condition,
            boundedVariables
        )
    }



}