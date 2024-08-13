package no.uio.tobiajoh.pddl

import no.uio.tobiajoh.OntologyTranslator
import no.uio.tobiajoh.rules.DerivationRule
import no.uio.tobiajoh.rules.OwlAssertion
import no.uio.tobiajoh.rules.OwlAssertionConstant
import org.semanticweb.owlapi.apibinding.OWLManager
import java.io.File

// class to add rules to an existing PDDL file
class PDDLInjector {

    private val rules : MutableSet<DerivationRule> = mutableSetOf()
    private val constants : MutableSet<OwlAssertionConstant> = mutableSetOf()

    private val assertions : MutableSet<OwlAssertion> = mutableSetOf()

    // objects that new objects minus the ones that are already constants
    private val objects get() = assertions.flatMap {
        it.usedConstants }.toSet().minus(constants)

    fun addRules(newRules : Set<DerivationRule>) {
        newRules.forEach {rules.add(it) }
    }

    fun addConstants(newConstants : Set<OwlAssertionConstant>) {
        newConstants.forEach {constants.add(it)}
    }

    fun addAssertions(newAssertions : Set<OwlAssertion>) {
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

    // loads content (rules, constants, assertions) from OWL file
    fun loadOWLFile(owlFile: File,
                    addDataProperties: Boolean) {
        val manager = OWLManager.createOWLOntologyManager()

        val ont = manager.loadOntologyFromOntologyDocument(owlFile)

        val translator = OntologyTranslator()
        val rules = translator.addRules(ont)

        //val usedConstants = rules.flatMap { it.usedConstants }.union(assertions.flatMap { it.usedConstants }).toSet()
        val usedConstants = rules.flatMap { it.usedConstants }.toSet() // individuals from ABox do not need to be declared as constants

        addRules(rules)
        addConstants(usedConstants)

        val assertions = translator.addAssertions(ont, addDataProperties)

        addAssertions(assertions)
    }

}

