package no.uio.tobiajoh.pddl

import no.uio.tobiajoh.rules.DerivationRule
import no.uio.tobiajoh.rules.RuleAssertion
import no.uio.tobiajoh.rules.RuleConstant
import no.uio.tobiajoh.rules.RuleVariable
import java.io.File

// class to add rules to an existing PDDL file
class PDDLInjector {

    private val rules : MutableSet<DerivationRule> = mutableSetOf()
    private val constants : MutableSet<RuleConstant> = mutableSetOf()

    private val assertions : MutableSet<RuleAssertion> = mutableSetOf()

    // objects that new objects minus the ones that are already constants
    private val objects get() = assertions.flatMap {
        it.usedConstants }.toSet().minus(constants)

    fun addRules(newRules : Set<DerivationRule>) {
        newRules.forEach {rules.add(it) }
    }

    fun addConstants(newConstants : Set<RuleConstant>) {
        newConstants.forEach {constants.add(it)}
    }

    fun addAssertions(newAssertions : Set<RuleAssertion>) {
        newAssertions.forEach {assertions.add(it)}
    }

    fun addToDomain(oldDomain : File, newDomain : File) {
        val sD = SplitDomain(oldDomain)

        sD.addRules(rules)
        sD.addConstants(constants)

        sD.outputToFile(newDomain)
    }

    fun addToProblem(oldProblem : File, newProblem : File) {
        val sP = SplitProgram(oldProblem)

        sP.addInitialAssertions(assertions)

        sP.addObjects(objects)

        sP.outputToFile(newProblem)

    }


}

