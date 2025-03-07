package no.uio.tobiajoh.pddl

import no.uio.tobiajoh.owl.OwlAssertion
import no.uio.tobiajoh.owl.OwlAssertionConstant
import no.uio.tobiajoh.owl.OwlNumber
import java.io.File


// class to represent split up program
// parsing is very simple and based on an approach by ChatGPT, so be careful when using it
class SplitProgram(val problem : File) {

    var problemName = ""
    var domain = ""
    val objects = mutableMapOf<String, String>()
    val initialCond = mutableListOf<String>()
    val goal = mutableListOf<String>()

    var section = ""

    init {

        problem.forEachLine{ line ->
            val trimmedLine = line.trim().lowercase()

            when {
                trimmedLine.startsWith("(define") -> {
                    problemName = trimmedLine.substringAfter("problem").trim().removeSuffix(")")
                }

                trimmedLine.startsWith("(:domain") -> {
                    domain = trimmedLine.substringAfter("(:domain").trim().removeSuffix(")")
                }
            }
        }


        extractInitObjectsAndGoal()
    }

    fun extractInitObjectsAndGoal() {
        val content = problem.readText()

        // Extract the init section
        val initStartIndex = content.indexOf("(:init") + 6 // Skip "(:init"
        val initSection = extractSection(content, initStartIndex)

        // extract objects
        val initObjectsIndex = content.indexOf("(:objects") + 9 // Skip "(:objects"
        val objectsSection = extractSection(content, initObjectsIndex)

        for (objectsWithType in objectsSection.split("\n")) {
            val parts = objectsWithType.trim().split(" ")
            if (parts.contains("-")) {
                val typeIndex = parts.indexOf("-")
                val objectType = parts[typeIndex + 1]

                val objectParts = parts.subList(0, typeIndex)
                objectParts.forEach { obj ->
                    objects[obj] = objectType
                }
            }
            else {
                parts.forEach { obj ->
                    objects[obj] = "object"
                }
            }
        }


        // Extract the goal section
        val goalStartIndex = content.indexOf("(:goal") + 6 // Skip "(:goal"
        val goalSection = extractSection(content, goalStartIndex)

        initialCond.add(initSection)
        goal.add(goalSection)
    }

    // Function to extract content between the matching parentheses
    fun extractSection(content: String, startIndex: Int): String {
        var depth = 1
        val result = StringBuilder()

        for (i in startIndex until content.length) {
            val char = content[i]
            when (char) {
                '(' -> {
                    if (depth > 0) result.append(char)
                    depth++
                }
                ')' -> {
                    depth--
                    if (depth > 0) result.append(char)
                    if (depth == 0) return result.toString().trim()
                }
                else -> {
                    if (depth > 0) result.append(char)
                }
            }
        }
        return ""  // This will never be reached if the section is properly formed
    }

    fun addInitialAssertions(assertions: Set<OwlAssertion>) {
        initialCond.add("") // add empty line to make it easier to find generated assertions
        val sortedAssertions = assertions.map { it.toPDDL() }.sorted()
        sortedAssertions.forEach { initialCond.add(it) }
    }

    fun addObjects(newObjects: Set<OwlAssertionConstant>) {
        // add objects that are not already contained
        val sortedObjects = newObjects.map { it.toString() }.sorted()
        sortedObjects.forEach { o ->
            if (!objects.containsKey(o))
                objects[o] = "object"
        }
    }

    fun addNumbers(newNumbers: Set<OwlNumber>) {
        val sortedNumbers = newNumbers.map { it.toString() }.sorted()
        sortedNumbers.forEach { n ->
            if (!objects.containsKey(n))
                objects[n] = OwlNumber.PDDLTYPE
        }
    }

    // remove the objects from the object list that are already declared as constants (somewhere else)
    fun removeConstants(constants: Set<OwlAssertionConstant>) {
        constants.forEach { c ->
            val cPddl = c.toString()    // name of constant in Pddl
            if (objects.containsKey(cPddl))
                objects.remove(cPddl)
        }
    }
    // return all objects that have the type of owl numbers
    fun getNumbers() : Set<String> {
        return objects.filterValues { it==OwlNumber.PDDLTYPE }.keys
    }

    fun outputToFile(outFile: File) {
        outFile.printWriter().use { out ->
            out.println("(define (problem ${problemName})")
            out.println("  (:domain ${domain})\n")

            // filter empty object
            objects.remove("")

            if (objects.isNotEmpty()) {
                out.print("  (:objects \n")
                objects.entries.groupBy { it.value }.forEach { (type, objs) ->
                    out.print("    ")
                    objs.forEach { (obj, _) ->
                        out.print("$obj ")
                    }
                    out.print("- $type \n")
                }
                out.println(")\n")
            }

            if (initialCond.isNotEmpty()) {
                out.println("  (:init")
                initialCond.forEach {
                    out.println("    $it")
                }
                out.println("  )\n")
            }

            if (goal.isNotEmpty()) {
                out.println("  (:goal ")
                goal.forEach {
                    out.println("    $it")
                }
                out.println("  )")
            }

            out.println(")")
        }
    }


}