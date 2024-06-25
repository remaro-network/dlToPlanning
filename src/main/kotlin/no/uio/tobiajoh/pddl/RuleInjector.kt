package no.uio.tobiajoh.pddl

import no.uio.tobiajoh.rules.DerivationRule
import java.io.File

// class to add rules to an existing PDDL file
class RuleInjector {

    private val rules : MutableSet<DerivationRule> = mutableSetOf()

    fun addRules(newRules : Set<DerivationRule>) {
        newRules.forEach {rules.add(it) }
    }

    fun addToDomain(oldDomain : File, newDomain : File) {
        val sD = SplitDomain(oldDomain)

        sD.addRules(rules)

        sD.outputToFile(newDomain)
    }


}

