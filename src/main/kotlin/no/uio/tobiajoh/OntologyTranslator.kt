package no.uio.tobiajoh

import no.uio.tobiajoh.rules.DerivationRule
import no.uio.tobiajoh.rules.DerivationRuleFactory
import org.semanticweb.owlapi.model.OWLOntology

class OntologyTranslator {

    fun translateOWL(ont: OWLOntology) : Set<DerivationRule> {
        val rules : MutableSet<DerivationRule> = mutableSetOf()
        for (a in ont.logicalAxioms())
            DerivationRuleFactory().derivationRule(a)?.let { rules.add(it) }

        for (a in ont.classesInSignature())
            println(a)

        for (r in rules)
            println(r.toPDDL())

        return rules.toSet()
    }
}