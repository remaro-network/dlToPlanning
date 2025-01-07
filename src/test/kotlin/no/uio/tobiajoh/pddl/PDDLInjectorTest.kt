package no.uio.tobiajoh.pddl

import org.junit.jupiter.api.Assertions.*
import java.io.File

class PDDLInjectorTest {

    @org.junit.jupiter.api.Test
    fun loadOWLFile() {
        val owlFile = File("src/test/resources/suave_types/suave_with_imports_types.owl")
        assert(owlFile.exists())
        getPddlInjector(
            owlFile,
            addNumComparison = false,
            ignoreDataProperties = true
        )
    }

    @org.junit.jupiter.api.Test
    fun addToDomain() {
        val owlFile = File("src/test/resources/suave_types/suave_with_imports_types.owl")
        assert(owlFile.exists())
        val rI = getPddlInjector(
            owlFile,
            addNumComparison = true,
            ignoreDataProperties = false
        )
        rI.addToDomain(
            File("src/test/resources/suave_types/suave_domain.pddl"),
            File("src/test/resources/suave_types/output_domain.pddl")
        )
    }

    @org.junit.jupiter.api.Test
    fun addToProblem() {
        val owlFile = File("src/test/resources/suave_types/suave_with_imports_types.owl")
        assert(owlFile.exists())
        val rI = getPddlInjector(
            owlFile,
            addNumComparison = true,
            ignoreDataProperties = false
        )
        rI.addToProblem(
            File("src/test/resources/suave_types/suave_problem.pddl"),
            File("src/test/resources/suave_types/output_problem.pddl")
        )
    }

    @org.junit.jupiter.api.Test
    fun saveAdditionsOfProblemFile() {
        val owlFile = File("src/test/resources/suave_types/suave_with_imports_types.owl")
        assert(owlFile.exists())
        val rI = getPddlInjector(
            owlFile,
            addNumComparison = true,
            ignoreDataProperties = false
        )
        rI.saveAdditionsOfProblemFile(File("src/test/resources/suave_types/output_additions.txt"))
    }

    @org.junit.jupiter.api.Test
    fun loadAdditionsOfProblemFile() {
        val rI = PDDLInjector()
        val additionsFile = File("src/test/resources/suave_types/additions.txt")
        assert(additionsFile.exists())
        rI.loadAdditionsOfProblemFile(additionsFile)
    }

    @org.junit.jupiter.api.Test
    fun testDifferentFrom() {
        val owlFile = File("src/test/resources/testDifferentFrom/suave_with_imports.owl")
        assert(owlFile.exists())
        val rI = getPddlInjector(
            owlFile,
            addNumComparison = true,
            ignoreDataProperties = false
        )
    }


    fun getPddlInjector(owlFile: File,
                        addNumComparison: Boolean,
                        ignoreDataProperties: Boolean) : PDDLInjector {
        val rI = PDDLInjector(addNumComparison)
        rI.loadOWLFile(owlFile, ignoreDataProperties)
        return rI
    }


}