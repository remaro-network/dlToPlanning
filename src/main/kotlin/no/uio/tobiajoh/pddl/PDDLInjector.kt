package no.uio.tobiajoh.pddl

import io.kotlintest.matchers.match
import no.uio.tobiajoh.OntologyTranslator
import no.uio.tobiajoh.owl.*
import org.semanticweb.owlapi.apibinding.OWLManager
import java.io.File

// class to add rules to an existing PDDL file
class PDDLInjector(val addNumComparisons: Boolean = false) {

    private val rules : MutableSet<DerivationRule> = mutableSetOf()
    private val constants : MutableSet<OwlAssertionConstant> = mutableSetOf()

    private val assertions : MutableSet<OwlAssertion> = mutableSetOf()

    // assertions to compare numerical values
    private val numberComparisionAssertions : MutableSet<OwlAssertion> = mutableSetOf()

    // delimiter used for temporal output
    private val typeDelimiter = "::"

    private val assertionFactory = OwlAssertionFactory()
    private val assertionConstantFactory  = OwlAssertionConstantFactory()



    // objects that new objects minus the ones that are already constants
    private val objects get() = assertions.flatMap {
        it.usedConstants }.toSet().minus(constants)

    private val numbers get() = assertions.flatMap { it.usedNumbers }.toSet()

    private val objectsWithoutNumbers get() = objects.minus(numbers)

    fun addRules(newRules : Set<DerivationRule>) {
        newRules.forEach {rules.add(it) }
    }

    fun addConstants(newConstants : Set<OwlAssertionConstant>) {
        newConstants.forEach {constants.add(it)}
    }

    fun addAssertions(newAssertions : Set<OwlAssertion>) {
        newAssertions.forEach {assertions.add(it)}
    }

    fun addNumComparisonAssertions(newAssertions : Set<OwlAssertion>) {
        newAssertions.forEach {numberComparisionAssertions.add(it)}
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
            sD.addPredicate(assertionFactory.ruleAssertion(OwlNumber.EQUIVALENT, var1, var2))
            sD.addPredicate(assertionFactory.ruleAssertion(OwlNumber.LESSRELATION, var1, var2))
        }

        sD.outputToFile(newDomain)
    }

    private fun NumberComparisons(numbersToCompare : Set<OwlNumber>) : Set<OwlAssertion> {
        val comparisons : MutableSet<OwlAssertion> = mutableSetOf()

        for (n in numbersToCompare)
            for (m in numbersToCompare) {
                if (n == m)
                    comparisons.add(
                        OwlAssertion(OwlNumber.EQUIVALENT, listOf(n, m))
                    )
                else if (n < m)
                    comparisons.add(
                        OwlAssertion(OwlNumber.LESSRELATION, listOf(n, m))
                    )
            }
        return comparisons
    }

    fun addToProblem(oldProblem : File, newProblem : File, ) {
        val sP = SplitProgram(oldProblem)

        // calculate the comparison relationship between numbers if desired
        if (addNumComparisons) {
            // extract numbers from PDDL problem file and parse them
            val existingNumbers = sP.getNumbers().mapNotNull { pddlNumber ->
                assertionConstantFactory.parseNumberFromString(pddlNumber)
            }

            // compare all numbers declared in  owl assertions and in pddl problem
            val numbersToCompare = numbers.plus(existingNumbers)

            // add comparison relation
            val comparisons = NumberComparisons(numbersToCompare)
            addNumComparisonAssertions(comparisons)
            sP.addInitialAssertions(comparisons)
        }

        sP.addInitialAssertions(assertions)

        sP.addObjects(objectsWithoutNumbers)
        sP.addNumbers(numbers)

        sP.outputToFile(newProblem)

    }

    // export assertions that are added to problem file --> makes updating problem file without ontology possible
    fun saveAdditionsOfProblemFile(outputFile : File) {
        outputFile.printWriter().use {out ->
            for (a in assertions)
                out.println("ASSERTION$typeDelimiter$a")
            for (c in constants)
                out.println("CONSTANT$typeDelimiter$c")
        }
    }

    // read exported assertions and constant to add to problem file
    fun loadAdditionsOfProblemFile(inputFile : File) {
        inputFile.forEachLine { line ->
            println(line)

            val splitLine = line.split(typeDelimiter)
            if (splitLine.size == 2)
                when (splitLine[0]) {
                    "ASSERTION" -> println("ass: ${splitLine[1]}")
                    "CONSTANT" -> println("const: ${splitLine[1]}")
                }



        }
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

