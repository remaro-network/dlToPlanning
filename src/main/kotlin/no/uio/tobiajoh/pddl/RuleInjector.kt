package no.uio.tobiajoh.pddl

import no.uio.tobiajoh.rules.DerivationRule
import no.uio.tobiajoh.rules.RuleVariable
import java.io.File

// class to add rules to an existing PDDL file
class RuleInjector {

    private val rules : MutableSet<DerivationRule> = mutableSetOf()
    private val constants : MutableSet<RuleVariable> = mutableSetOf()

    fun addRules(newRules : Set<DerivationRule>) {
        newRules.forEach {rules.add(it) }
    }

    fun addConstants(newConstants : Set<RuleVariable>) {
        newConstants.forEach {constants.add(it)}
    }

    fun addToDomain(oldDomain : File, newDomain : File) {
        val sD = SplitDomain(oldDomain)

        sD.addRules(rules)
        sD.addConstants(constants)

        sD.outputToFile(newDomain)
    }


}

