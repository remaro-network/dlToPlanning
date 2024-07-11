package no.uio.tobiajoh.pddl

import no.uio.tobiajoh.rules.DerivationRule
import no.uio.tobiajoh.rules.RuleVariable
import java.io.File
import java.util.regex.Pattern

// class to represent split up domain
// parsing is very simple, but sufficient for current examples
class SplitDomain(val domain : File) {

    // the file will be split in these four parts, which will be edited separately
    var beforePredicates : MutableList<String> = mutableListOf()
    var predicates : MutableList<String> = mutableListOf()
    var declaredConstants : MutableList<String> = mutableListOf()
    var derivedRules : MutableList<String> = mutableListOf()
    var rest : MutableList<String> = mutableListOf()

    init {
        // very simple parsing of the PDDL file
        var parseStatus = ParseStatus.BEFORE
        var parsebrackets = 0
        domain.forEachLine { line ->
            if (parseStatus == ParseStatus.BEFORE) {
                if (line.contains(":predicates")) {
                    parseStatus = ParseStatus.PREDICATE
                    parsebrackets = bracketCount(line)
                    predicates += line
                }
                else
                    beforePredicates += line
            }
            else if (parseStatus == ParseStatus.PREDICATE) {
                predicates += line
                parsebrackets += bracketCount(line)
                if (parsebrackets == 0)
                    parseStatus = ParseStatus.AFTER
            }
            else if (parseStatus == ParseStatus.AFTER)
                rest += line
        }
    }

    fun addRules(rules : MutableSet<DerivationRule>) {
        // add rules to derived rules
        derivedRules.add("\n")
        for (r in rules)
            derivedRules.add("${r.toPDDL(1)}\n")

        // compute necessary declarations and add all of them to the domain
        val declarations = requiredPredicateDeclarations(rules)
        val lastLine = predicates.removeLast()
        predicates.add("")
        declarations.forEach {
            predicates.add("\t\t$it")
        }
        predicates.add(lastLine)


    }

    fun addConstants(constants : Set<RuleVariable>) {
        constants.forEach { declaredConstants.add("$it")}
    }


    // returns the predicate declarations that are necessary, because the derivation rules might contain
    // predicates that are not defined in planning domain so far
    fun requiredPredicateDeclarations(rules: MutableSet<DerivationRule>) : List<String> {
        // add new predicates to list of predicates
        // we transform all predicates to lower case, as this is the standard notation
        // predicates already defined in domain
        val existingPredicates = extractPredicates().map { it.lowercase() }
        // predicates used in derivision rules
        val usedPredicates : MutableMap<String, Int> = mutableMapOf()
        rules.forEach {
            usedPredicates += it.usedPredicates()
        }
        val usedPredicatesNames = usedPredicates.keys.map { it.lowercase() }
        //println(usedPredicates)
        // predicates that need to be added
        val neededPredicatesNames = usedPredicatesNames.minus(existingPredicates.toSet()).minus(setOf("="))
        val neededPredicates = usedPredicates.filterKeys { key ->
            val lowerKey = key.lowercase()
            neededPredicatesNames.contains(lowerKey)
        }
        //println(neededPredicatesNames)
        //println(neededPredicates)

        return neededPredicates.map { predicate ->
            "(" + predicate.key + when(predicate.value) {
                1 -> " ?x"
                2 -> " ?x ?y"
                else -> ""
            } + ")"
        }
    }

    fun outputToFile(out : File) {
        /*if (out.exists()) {
            println("ERROR: new domain file already exists. File does not get replaced.")
            return
        }
        else {

         */
            out.writeText(
                beforePredicates.joinToString("\n", "", "\n") +
                declaredConstants.joinToString( " ", "\t(:constants ", ")\n\n")   +
                predicates.joinToString("\n", "", "\n") +
                derivedRules.joinToString("\n", "", "\n") +
                rest.joinToString("\n", "", "\n")
            )
        //}
    }

    // returns a set containing all predicates
    fun extractPredicates() : Set<String> {
        val pred : MutableSet<String> = mutableSetOf()
        for (p in predicates) {
            // add predicate, if it can be identified
            extractPredicate(p)?.let { pred.add(it) }
        }
        return pred.toSet()
    }

    // extracts predicate name from declaration
    private fun extractPredicate(line: String) : String? {

        // pattern that matches the name of a predicate
        // assumption: only one predicate is defined per line!
        val pattern = Pattern.compile("\\s+\\(([A-Za-z]+)\\s+.*\\)\\s*")

        val matcher = pattern.matcher(line)
        if (matcher.find()) {
            val pred = matcher.group(1)
            return pred
        }
        // no predicate found
        return null
    }

    // count number of opening brackets vs. number of closing brackets
    fun bracketCount(s : String) : Int {
        return s.count {it == '('} - s.count { it == ')'}
    }
}

enum class ParseStatus {
    BEFORE, PREDICATE, AFTER
}