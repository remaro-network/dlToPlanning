package no.uio.tobiajoh.rules

import org.semanticweb.owlapi.model.OWLAxiom
import org.semanticweb.owlapi.model.OWLSubClassOfAxiom
import org.semanticweb.owlapi.model.SWRLRule


class DerivationRuleFactory {
    fun derivationRule(axiom: OWLAxiom): DerivationRule? {
        return when (axiom) {
            is SWRLRule -> parseSWRLRule(axiom)
            is OWLSubClassOfAxiom -> parseSubClassOfAxiom(axiom)
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


    private fun parseSubClassOfAxiom(axiom: OWLSubClassOfAxiom) : DerivationRule? {
        // check if subclass axiom only refers to OWL classes and not complex class descriptions
        if (!axiom.superClass.isOWLClass || ! axiom.subClass.isOWLClass) {
            println("WARNING: complex subclass axioms are not supported yet. axiom: $axiom")
            return null
        }


        val headClass = axiom.superClass.asOWLClass()
        val conditionClass = axiom.subClass.asOWLClass()

        // select arbitrary name for variable
        val variable = RuleVariable("?x")
        val variables: MutableSet<RuleVariable> = mutableSetOf(variable)

        val head = RuleAssertionFactory().ruleAssertion(headClass, variable)
        val condition = listOf(RuleAssertionFactory().ruleAssertion(conditionClass, variable))
        val boundedVariables : Set<RuleVariable> = setOf()

        return DerivationRule(
            variables,
            head,
            condition,
            boundedVariables
        )
    }


}