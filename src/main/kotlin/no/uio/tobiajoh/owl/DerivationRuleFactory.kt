package no.uio.tobiajoh.owl

import org.semanticweb.owlapi.model.OWLAxiom
import org.semanticweb.owlapi.model.OWLClass
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom
import org.semanticweb.owlapi.model.OWLDataPropertyDomainAxiom
import org.semanticweb.owlapi.model.OWLDisjointClassesAxiom
import org.semanticweb.owlapi.model.OWLFunctionalDataPropertyAxiom
import org.semanticweb.owlapi.model.OWLFunctionalObjectPropertyAxiom
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom
import org.semanticweb.owlapi.model.OWLObjectPropertyDomainAxiom
import org.semanticweb.owlapi.model.OWLObjectPropertyRangeAxiom
import org.semanticweb.owlapi.model.OWLProperty
import org.semanticweb.owlapi.model.OWLSubClassOfAxiom
import org.semanticweb.owlapi.model.OWLSubObjectPropertyOfAxiom
import org.semanticweb.owlapi.model.SWRLRule


class DerivationRuleFactory {

    private val assertionFactory = OwlAssertionFactory()

    // lift assertion from class to inferred class
    fun liftAssertion(className: OWLClass) : DerivationRule {
        // select arbitrary name for variable
        val variable = OwlAssertionVariable("?x")
        val head = assertionFactory.inferredRuleAssertion(className, variable)
        val condition = listOf(assertionFactory.ruleAssertion(className, variable))

        return DerivationRule(
            head,
            condition
        )
    }

    // lift assertion from property to inferred property
    fun liftAssertion(prop: OWLProperty) : DerivationRule {
        // select arbitrary name for variable
        val variable1 = OwlAssertionVariable("?x")
        val variable2 = OwlAssertionVariable("?y")

        val head = assertionFactory.inferredRuleAssertion(prop, variable1, variable2)
        val condition = listOf(assertionFactory.ruleAssertion(prop, variable1, variable2))

        return DerivationRule(
            head,
            condition
        )
    }


    fun derivationRule(axiom: OWLAxiom): DerivationRule? {
        return when (axiom) {
            is SWRLRule -> parseSWRLRule(axiom)
            is OWLSubClassOfAxiom -> parseSubClassOfAxiom(axiom)
            is OWLSubObjectPropertyOfAxiom -> parseSubPropertyOfAxiom(axiom)
            is OWLDisjointClassesAxiom -> parseDisjointClasses(axiom)
            is OWLObjectPropertyDomainAxiom -> parseObjectPropertyDomain(axiom)
            is OWLObjectPropertyRangeAxiom -> parseObjectPropertyRange(axiom)
            is OWLFunctionalObjectPropertyAxiom -> parseFunctionalObjectProperty(axiom)
            is OWLFunctionalDataPropertyAxiom -> parseFunctionalDataProperty(axiom)
            is OWLDataPropertyDomainAxiom -> parseDataPropertyDomain(axiom)
            is OWLObjectPropertyAssertionAxiom -> null // is ABox axiom --> no rule
            is OWLClassAssertionAxiom -> null   // is ABox axiom --> no rule
            is OWLDataPropertyAssertionAxiom -> null   // is ABox axiom --> no rule
            else -> {
                println("WARNING: can not parse TBox axiom $axiom.")
                null
            }
        }
    }


    private fun parseSWRLRule(rule: SWRLRule): DerivationRule? {
        val boundedVariables: MutableSet<OwlAssertionVariable> = mutableSetOf()
        val headVariables: MutableSet<OwlAssertionVariable> = mutableSetOf()

        val condition: MutableList<OwlAssertion> = mutableListOf()

        // parse body
        for (element in rule.body){
            val newCondition = assertionFactory.inferredRuleAssertion(element)
            condition.add(newCondition)
            newCondition.variables.forEach{ if (it !is OwlAssertionConstant) boundedVariables.add(it) }
        }

        // parse head
        if (rule.head.size != 1) {
            println("WARNING SWRL rules with more than one head element not supported yet")
            return null
        }
        val head = assertionFactory.inferredRuleAssertion(rule.head.first())

        head.variables.forEach{
            headVariables.add(it)
            boundedVariables.remove( it )
        }


        return DerivationRule(
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
        val variable = OwlAssertionVariable("?x")

        val head = assertionFactory.inferredRuleAssertion(headClass, variable)
        val condition = assertionFactory.inferredRuleAssertion(conditionClass, variable)

        return DerivationRule(
            head,
            condition
        )
    }

    private fun parseSubPropertyOfAxiom(axiom: OWLSubObjectPropertyOfAxiom) : DerivationRule? {
        // check if subclass axiom only refers to OWL object properties
        if (!axiom.superProperty.isOWLObjectProperty || ! axiom.subProperty.isOWLObjectProperty) {
            println("WARNING: complex sub-property axioms are not supported yet. axiom: $axiom")
            return null
        }

        val headProperty = axiom.superProperty.asOWLObjectProperty()
        val conditionProperty = axiom.subProperty.asOWLObjectProperty()

        // select names for variables
        val variable1 = OwlAssertionVariable("?x")
        val variable2 = OwlAssertionVariable("?y")

        val head = assertionFactory.inferredRuleAssertion(headProperty, variable1, variable2)
        val condition = assertionFactory.inferredRuleAssertion(conditionProperty, variable1, variable2)

        return DerivationRule(
            head,
            condition
        )

    }

    private fun parseDisjointClasses(axiom: OWLDisjointClassesAxiom) : DerivationRule {
        // check if axiom only refers to OWL classes and not complex class descriptions

        val variable = OwlAssertionVariable("?x")
        val boundedVariables = setOf(variable)


        // rule with empty condition that will trigger inconsistent predicate
        val rule =  DerivationRule(
            assertionFactory.inconsistentAssertion(),
            null,
            boundedVariables
        )

        // get disjoint classes as pairs
        val incPairs = axiom.asPairwiseAxioms()

        // iterate over all possible pairs and create one condition for them
        for (p in incPairs) {
            val classes = p.classesInSignature
            val condition : MutableList<OwlAssertion> = mutableListOf()
            for (c in classes)
                condition.add(assertionFactory.inferredRuleAssertion(c, variable))
            // add condition to the rule
            rule.addCondition(condition)
        }

        return rule
    }

    private fun parseObjectPropertyRange(axiom: OWLObjectPropertyRangeAxiom) : DerivationRule? {
        if (!axiom.range.isOWLClass) {
            println("WARNING: complex range axioms are not supported yet. axiom: $axiom")
            return null
        }

        val headClass=axiom.range.asOWLClass()
        val conditionProperty=axiom.property.asOWLObjectProperty()

        val variable1 = OwlAssertionVariable("?x")
        val variable2 = OwlAssertionVariable("?y")

        val head = assertionFactory.inferredRuleAssertion(headClass, variable2)
        val condition = assertionFactory.inferredRuleAssertion(conditionProperty, variable1, variable2)
        val boundedVariables = setOf(variable1)

        return DerivationRule(
            head,
            condition,
            boundedVariables
        )
    }

    private fun parseObjectPropertyDomain(axiom: OWLObjectPropertyDomainAxiom) : DerivationRule? {
        if (!axiom.domain.isOWLClass) {
            println("WARNING: complex range axioms are not supported yet. axiom: $axiom")
            return null
        }

        val headClass=axiom.domain.asOWLClass()
        val conditionProperty=axiom.property.asOWLObjectProperty()

        val variable1 = OwlAssertionVariable("?x")
        val variable2 = OwlAssertionVariable("?y")

        val head = assertionFactory.inferredRuleAssertion(headClass, variable1)
        val condition = assertionFactory.inferredRuleAssertion(conditionProperty, variable1, variable2)
        val boundedVariables = setOf(variable2)

        return DerivationRule(
            head,
            condition,
            boundedVariables
        )
    }

    private fun parseFunctionalObjectProperty(axiom: OWLFunctionalObjectPropertyAxiom) : DerivationRule {
        val variableX = OwlAssertionVariable("?x")
        val variableY = OwlAssertionVariable("?y")
        val variableZ = OwlAssertionVariable("?z")
        val boundedVariables = setOf(variableX, variableY, variableZ)

        val conditionProperty=axiom.property.asOWLObjectProperty()

        val head = assertionFactory.inconsistentAssertion()
        val conditionY = assertionFactory.inferredRuleAssertion(conditionProperty, variableX, variableY)
        val conditionZ = assertionFactory.inferredRuleAssertion(conditionProperty, variableX, variableZ)
        val distinct = assertionFactory.ruleAssertion("=", variableY, variableZ)

        // rule: two distinct variables that are in relation with ?x
        return DerivationRule(
            head,
            listOf(conditionY, conditionZ, distinct),
            boundedVariables
        )
    }

    private fun parseFunctionalDataProperty(axiom: OWLFunctionalDataPropertyAxiom) : DerivationRule {
        val variableX = OwlAssertionVariable("?x")
        val variableY = OwlAssertionVariable("?y")
        val variableZ = OwlAssertionVariable("?z")
        val boundedVariables = setOf(variableX, variableY, variableZ)

        val conditionProperty=axiom.property.asOWLDataProperty()

        val head = assertionFactory.inconsistentAssertion()
        val conditionY = assertionFactory.inferredRuleAssertion(conditionProperty, variableX, variableY)
        val conditionZ = assertionFactory.inferredRuleAssertion(conditionProperty, variableX, variableZ)
        val distinct = assertionFactory.ruleAssertion("=", variableY, variableZ)
        distinct.negate()

        // rule: two distinct variables that are in relation with ?x
        return DerivationRule(
            head,
            listOf(conditionY, conditionZ, distinct),
            boundedVariables
        )
    }


    private fun parseDataPropertyDomain(axiom: OWLDataPropertyDomainAxiom) : DerivationRule? {
        if (!axiom.domain.isOWLClass) {
            println("WARNING: complex range axioms are not supported yet. axiom: $axiom")
            return null
        }

        val headClass=axiom.domain.asOWLClass()
        val conditionProperty=axiom.property.asOWLDataProperty()

        val variable1 = OwlAssertionVariable("?x")
        val variable2 = OwlAssertionVariable("?y")

        val head = assertionFactory.inferredRuleAssertion(headClass, variable1)
        val condition = assertionFactory.inferredRuleAssertion(conditionProperty, variable1, variable2)
        val boundedVariables = setOf(variable2)

        return DerivationRule(
            head,
            condition,
            boundedVariables
        )
    }
}