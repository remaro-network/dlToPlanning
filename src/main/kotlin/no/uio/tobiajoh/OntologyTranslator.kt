package no.uio.tobiajoh

import no.uio.tobiajoh.rules.DerivationRule
import no.uio.tobiajoh.rules.DerivationRuleFactory
import no.uio.tobiajoh.rules.RuleAssertion
import no.uio.tobiajoh.rules.RuleAssertionFactory
import org.semanticweb.owlapi.model.OWLOntology

class OntologyTranslator {
    private val rules : MutableSet<DerivationRule> = mutableSetOf()
    private val assertions : MutableSet<RuleAssertion> = mutableSetOf()


    fun addRules(ont: OWLOntology) : Set<DerivationRule> {

        val ruleFactory = DerivationRuleFactory()

        // lift all class assertions
        for (c in ont.classesInSignature())
            rules.add(ruleFactory.liftAssertion(c))

        // lift all object property assertions
        for (p in ont.objectPropertiesInSignature)
            rules.add(ruleFactory.liftAssertion(p))

        // lift all data property assertions
        for (p in ont.dataPropertiesInSignature)
            rules.add(ruleFactory.liftAssertion(p))


        // translate TBox-axioms
        for (a in ont.logicalAxioms())
            ruleFactory.derivationRule(a)?.let { rules.add(it) }


        //for (r in rules)
       //     println(r.toPDDL())

        return rules.toSet()
    }

    fun addAssertions(ont: OWLOntology, addDataProperties : Boolean) : Set<RuleAssertion> {

        val assertionFactory = RuleAssertionFactory()

        for (a in ont.logicalAxioms)
            assertionFactory.parseOWLABoxAxiom(a, addDataProperties)?.let { assertions.add(it) }

        return assertions.toSet()
    }
}