package no.uio.tobiajoh

import no.uio.tobiajoh.rules.DerivationRule
import no.uio.tobiajoh.rules.DerivationRuleFactory
import org.semanticweb.owlapi.model.OWLOntology

class OntologyTranslator {
    private val rules : MutableSet<DerivationRule> = mutableSetOf()

    fun translateOWL(ont: OWLOntology) : Set<DerivationRule> {

        // lift all class assertions
        for (c in ont.classesInSignature())
            rules.add(DerivationRuleFactory().liftAssertion(c))

        // lift all class assertions
        for (p in ont.objectPropertiesInSignature)
            rules.add(DerivationRuleFactory().liftAssertion(p))


        // translate TBox-axioms
        for (a in ont.logicalAxioms())
            DerivationRuleFactory().derivationRule(a)?.let { rules.add(it) }

        for (r in rules)
            println(r.toPDDL())

        return rules.toSet()
    }
}