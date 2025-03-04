package no.uio.tobiajoh

import no.uio.tobiajoh.owl.*
import org.semanticweb.owlapi.model.*


class OntologyTranslator {
    private val rules : MutableSet<DerivationRule> = mutableSetOf()
    private val assertions : MutableSet<OwlAssertion> = mutableSetOf()



    fun addRules(ont: OWLOntology) : Set<DerivationRule> {

        val ruleFactory = DerivationRuleFactory()

        // lift all class assertions
        for (c in ont.classesInSignature())
            if (c != OwlObjects.pddlTypeClass)
                rules.add(ruleFactory.liftAssertion(c))

        // lift all object property assertions
        for (p in ont.objectPropertiesInSignature)
            if (p != OwlObjects.hasPddlTypeRelation)
                rules.add(ruleFactory.liftAssertion(p))

        // lift all data property assertions
        for (p in ont.dataPropertiesInSignature)
            if (p != OwlObjects.pddlNameRelation)
                rules.add(ruleFactory.liftAssertion(p))


        // translate TBox-axioms
        for (a in ont.logicalAxioms())
            ruleFactory.derivationRule(a)?.let { rules.add(it) }


        //for (r in rules)
       //     println(r.toPDDL())

        return rules.toSet()
    }

    fun addAssertions(ont: OWLOntology, addDataProperties : Boolean) : Set<OwlAssertion> {

        val assertionFactory = OwlAssertionFactory()

        for (a in ont.logicalAxioms)
            assertionFactory.parseOWLABoxAxiom(a, addDataProperties)?.let { assertions.add(it) }

        return assertions.toSet()
    }

    fun addPddlTypes(ont: OWLOntology): Set<OwlAssertionConstant> {
        // set to collect all typed constants
        val constants : MutableSet<OwlAssertionConstant> = mutableSetOf()

        // the individuals representing a type
        val pddlTypeIndividuals : MutableSet<OWLIndividual> = mutableSetOf()

        // collect all individuals that represent a pddl type and its pddl name
        // collect all individuals that are assigned a pddl type

        val typeToName : MutableMap<OWLIndividual, String> = mutableMapOf()
        val indToType : MutableMap<OWLIndividual, OWLIndividual> = mutableMapOf()


        for (a in ont.axioms) {
            when (a) {
                is OWLDataPropertyAssertionAxiom ->
                    if (a.property == OwlObjects.pddlNameRelation){
                        // definition of name of type
                        val pddlType = a.subject
                        val pddlTypeName = a.`object`.literal
                        typeToName[pddlType] = pddlTypeName
                        pddlTypeIndividuals.add(pddlType)
                    }
                is OWLObjectPropertyAssertionAxiom ->
                    if (a.property == OwlObjects.hasPddlTypeRelation) {
                        // definition of pddl type of individual
                        val individual = a.subject
                        val pddlType = a.`object`
                        indToType[individual] = pddlType
                        pddlTypeIndividuals.add(pddlType)
                    }
                is OWLClassAssertionAxiom ->
                    if (a.classExpression == OwlObjects.pddlTypeClass) {
                        pddlTypeIndividuals.add(a.individual)
                    }
            }
        }

        for (ind in indToType.keys) {
            assert(pddlTypeIndividuals.contains(indToType[ind]))   // check, that type was inferred
            val c = OwlAssertionConstantFactory().parseOWLIndividualWithType(
                ind.asOWLNamedIndividual(),
                typeToName.getOrDefault(indToType[ind], "object") // if no definition found --> default pddl type
            )
            constants.add( c )
        }

        return constants
    }
}