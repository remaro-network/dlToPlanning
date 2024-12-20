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
    // numbers and object read from file
    private val additionalNumbers : MutableSet<OwlNumber> = mutableSetOf()
    private val additionalObjects : MutableSet<OwlAssertionConstant> = mutableSetOf()



    private val assertionFactory = OwlAssertionFactory()
    private val assertionConstantFactory  = OwlAssertionConstantFactory()



    // objects that new objects minus the ones that are already constants
    private val objects get() = assertions.flatMap {
        it.usedConstants }.toSet().plus(additionalObjects).minus(constants)

    private val numbers get() = assertions.flatMap { it.usedNumbers }.toSet().plus(additionalNumbers)

    private val objectsWithoutNumbers get() = objects.minus(numbers)

    private val pddlTypes get() = constants.flatMap { setOf(it.getPddlType()) }.toSet()

    fun addRules(newRules : Set<DerivationRule>) {
        newRules.forEach {rules.add(it) }
    }

    fun addConstants(newConstants : Set<OwlAssertionConstant>) {
        newConstants.forEach {addConstant(it)}
    }

    private fun addConstant(newConstant : OwlAssertionConstant) {
        constants.add(newConstant)
    }

    fun addAssertions(newAssertions : Set<OwlAssertion>) {
        newAssertions.forEach {addAssertion(it)}
    }

    private fun addAssertion(newAssertion : OwlAssertion) {
        assertions.add(newAssertion)
    }

    fun addNumComparisonAssertions(newAssertions : Set<OwlAssertion>) {
        newAssertions.forEach {numberComparisionAssertions.add(it)}
    }

    fun addToDomain(oldDomain : File, newDomain : File) {
        val sD = SplitDomain(oldDomain)

        // add rules and constants to domain
        sD.addRules(rules)
        sD.addConstants(constants)

        // add types for all constants to domain
        sD.addTypeDeclarations(pddlTypes)

        // introduce numerical comparison, if necessary
        if (addNumComparisons) {
            val var1 = OwlAssertionVariable("?x")
            val var2 = OwlAssertionVariable("?y")
            sD.addPredicate(assertionFactory.ruleAssertion(OwlNumber.EQUIVALENT, var1, var2))
            sD.addPredicate(assertionFactory.ruleAssertion(OwlNumber.LESSRELATION, var1, var2))
            sD.addTypeDeclarations(setOf(OwlNumber.PDDLTYPE))
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

        // remove the already defined constants from the list of objects
        sP.removeConstants(constants)

        sP.outputToFile(newProblem)

    }

    // export assertions that are added to problem file --> makes updating problem file without ontology possible
    fun saveAdditionsOfProblemFile(outputFile : File) {
        outputFile.printWriter().use {out ->
            for (a in assertions.sortedBy { it.toString() })
                out.println("ASSERTION$typeDelimiter$a")
            for (c in objectsWithoutNumbers.sortedBy { it.toString() })
                out.println("OBJECT$typeDelimiter$c")
            for (n in numbers.sortedBy { it.value() })
                out.println("NUMBER$typeDelimiter$n")
            for (c in constants.sortedBy { it.toString() })
                out.println("CONSTANT$typeDelimiter$c")
        }
    }

    // read exported assertions and constant to add to problem file
    // CAVE: assertions are not fully parsed, e.g. numbers in assertions are just treated as strings
    fun loadAdditionsOfProblemFile(inputFile : File) {
        inputFile.forEachLine { line ->
            val splitLine = line.split(typeDelimiter)
            if (splitLine.size == 2) {
                val lineType = splitLine[0]
                val lineValue = splitLine[1]
                when (lineType) {
                    // assertions are saved as they are, i.e. contained numbers are not parsed
                    "ASSERTION" -> addAssertion(assertionFactory.ruleAssertion(lineValue))
                    "OBJECT" -> additionalObjects.add(assertionConstantFactory.getOwlAssertionConstant(lineValue))
                    "NUMBER" -> additionalNumbers.add(assertionConstantFactory.parseNumberFromString(lineValue)!!)
                    "CONSTANT" -> constants.add(assertionConstantFactory.getOwlAssertionConstant(lineValue))
                }
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

        val typedConstants = translator.addPddlTypes(ont)

        //val usedConstants = rules.flatMap { it.usedConstants }.union(assertions.flatMap { it.usedConstants }).toSet()
        // use typed constants, if available, otherwise use default
        val usedConstants = typedConstants.union(
            rules.flatMap { it.usedConstants }.toSet()
        )// individuals from ABox do not need to be declared as constants

        addRules(rules)
        addConstants(usedConstants)


        val assertions = translator.addAssertions(ont, addDataProperties)
        addAssertions(assertions)

        // we want to declare every object as a constant --> faster computation for PlanSys
        addConstants(objectsWithoutNumbers)


    }

}

