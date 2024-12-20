package no.uio.tobiajoh.owl

import org.semanticweb.owlapi.apibinding.OWLManager
import org.semanticweb.owlapi.model.OWLClass
import org.semanticweb.owlapi.model.OWLDataFactory

class OwlObjects {

    companion object {
        private val owlDataFactory : OWLDataFactory = OWLManager.createOWLOntologyManager().owlDataFactory;

        val pddlTypeClass : OWLClass = owlDataFactory.getOWLClass("http://www.metacontrol.org/pddl#PddlType")
        val hasPddlTypeRelation  = owlDataFactory.getOWLObjectProperty("http://www.metacontrol.org/pddl#hasPddlType")
        val pddlNameRelation  = owlDataFactory.getOWLDataProperty("http://www.metacontrol.org/pddl#pddlName")
    }
}