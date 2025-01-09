package no.uio.tobiajoh.owl

import org.semanticweb.owlapi.apibinding.OWLManager
import org.semanticweb.owlapi.model.OWLClass
import org.semanticweb.owlapi.model.OWLObjectProperty
import org.semanticweb.owlapi.model.OWLDataProperty


import org.semanticweb.owlapi.model.OWLDataFactory

class OwlObjects {

    companion object {
        private val owlDataFactory : OWLDataFactory = OWLManager.createOWLOntologyManager().owlDataFactory

        val pddlTypeClass : OWLClass = owlDataFactory.getOWLClass("http://www.metacontrol.org/pddl#PddlType")
        val hasPddlTypeRelation: OWLObjectProperty = owlDataFactory.getOWLObjectProperty("http://www.metacontrol.org/pddl#hasPddlType")
        val pddlNameRelation: OWLDataProperty = owlDataFactory.getOWLDataProperty("http://www.metacontrol.org/pddl#pddlName")
    }
}