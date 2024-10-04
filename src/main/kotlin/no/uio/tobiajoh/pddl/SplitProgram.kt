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

                trimmedLine.startsWith("(:objects") -> {
                    section = "objects"
                }

                trimmedLine.startsWith("(:init") -> {
                    section = "init"
                }

                trimmedLine.startsWith("(:goal") -> {
                    section = "goal"
                }

                trimmedLine == ")" -> {
                    section = ""
                }

                section == "objects" -> {
                    val parts = trimmedLine.split(" ")
                    var currentType = "object"
                    for (part in parts) {
                        if (part == "-") continue
                        if (part.startsWith("(") || part.endsWith(")")) {
                            currentType = part.removePrefix("(").removeSuffix(")")
                        } else if (parts.contains("-")) {
                            val typeIndex = parts.indexOf("-")
                            val objectParts = parts.subList(0, typeIndex)
                            currentType = parts[typeIndex + 1]
                            objectParts.forEach { obj ->
                                objects[obj] = currentType
                            }
                            break
                        } else {
                            objects[part] = currentType
                        }
                    }
                }

                section == "init" -> {
                    initialCond.add(trimmedLine)
                }

                section == "goal" -> {
                    goal.add(trimmedLine.removePrefix("(and").removePrefix("(").removeSuffix(")"))
                }
            }
        }
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
                out.println("  (:goal (and")
                goal.forEach {
                    out.println("    ($it)")
                }
                out.println("  ))")
            }

            out.println(")")
        }
    }


}