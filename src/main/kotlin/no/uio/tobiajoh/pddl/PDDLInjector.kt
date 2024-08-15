package no.uio.tobiajoh.pddl

import no.uio.tobiajoh.OntologyTranslator
import no.uio.tobiajoh.owl.*
import org.semanticweb.owlapi.apibinding.OWLManager
import java.io.File

// class to add rules to an existing PDDL file
class PDDLInjector(val addNumComparisons: Boolean = false) {

    private val rules : MutableSet<DerivationRule> = mutableSetOf()
    private val constants : MutableSet<OwlAssertionConstant> = mutableSetOf()

    private val assertions : MutableSet<OwlAssertion> = mutableSetOf()

    // relation, that is used for the comparison operator
    private val leqRelation = "leq"


    // objects that new objects minus the ones that are already constants
    private val objects get() = assertions.flatMap {
        it.usedConstants }.toSet().minus(constants)

    private val numbers get() = assertions.flatMap { it.usedNumbers }.toSet()

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

        // add rules and constants to domain
        sD.addRules(rules)
        sD.addConstants(constants)

        // introduce numerical comparison, if necessary
        if (addNumComparisons) {
            val var1 = OwlAssertionVariable("?x")
            val var2 = OwlAssertionVariable("?y")
            sD.addPredicate(OwlAssertionFactory().ruleAssertion(leqRelation, var1, var2))
        }

        sD.outputToFile(newDomain)
    }

    private fun addNumberComparisons() {
        val comparisons : MutableSet<OwlAssertion> = mutableSetOf()

        for (n in numbers)
            for (m in numbers)
                if (n <= m)
                    comparisons.add(
                        OwlAssertion(leqRelation, listOf(n,m))
                    )

        addAssertions(comparisons)
    }

    fun addToProblem(oldProblem : File, newProblem : File) {
        val sP = SplitProgram(oldProblem)

        // calculate the comparison relationship between numbers
        if (addNumComparisons)
            addNumberComparisons()

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

