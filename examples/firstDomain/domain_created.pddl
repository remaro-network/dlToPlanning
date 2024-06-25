(define (domain example-auv)

    (:requirements
        :strips
        :derived-predicates
        :existential-preconditions
        :disjunctive-preconditions
    )
    
    (:predicates
        (robot ?x)
        (waypoint ?x)
        (available ?x)
        (function ?x)
        (functionalDesign ?x)
        (requiresThruster ?x)
        (robotPart ?x)
        (thruster ?x)
        (isAt ?r ?wp)
        (hasPart ?r ?x)
        (solves ?fd ?f)
        (requires ?fd ?r)

		(inferred-AbstractThing ?x)
		(AbstractThing ?x)
		(inferred-Available ?x)
		(inferred-ConcreteThing ?x)
		(ConcreteThing ?x)
		(inferred-Function ?x)
		(inferred-FunctionalDesign ?x)
		(inferred-Requirement ?x)
		(Requirement ?x)
		(inferred-RequiresThruster ?x)
		(inferred-Robot ?x)
		(inferred-RobotPart ?x)
		(inferred-Satisfied ?x)
		(Satisfied ?x)
		(inferred-Status ?x)
		(Status ?x)
		(inferred-Thruster ?x)
		(inferred-HasPart ?x ?y)
		(inferred-Requires ?x ?y)
		(inferred-Solves ?x ?y)
		(inferred-TopObjectProperty ?x ?y)
		(topObjectProperty ?x ?y)
		(inferredInconsistent)
    )


	(:derived (inferred-AbstractThing ?x) 
		(and
			(AbstractThing ?x)
		)
	)


	(:derived (inferred-Available ?x) 
		(and
			(Available ?x)
		)
	)


	(:derived (inferred-ConcreteThing ?x) 
		(and
			(ConcreteThing ?x)
		)
	)


	(:derived (inferred-Function ?x) 
		(and
			(Function ?x)
		)
	)


	(:derived (inferred-FunctionalDesign ?x) 
		(and
			(FunctionalDesign ?x)
		)
	)


	(:derived (inferred-Requirement ?x) 
		(and
			(Requirement ?x)
		)
	)


	(:derived (inferred-RequiresThruster ?x) 
		(and
			(RequiresThruster ?x)
		)
	)


	(:derived (inferred-Robot ?x) 
		(and
			(Robot ?x)
		)
	)


	(:derived (inferred-RobotPart ?x) 
		(and
			(RobotPart ?x)
		)
	)


	(:derived (inferred-Satisfied ?x) 
		(and
			(Satisfied ?x)
		)
	)


	(:derived (inferred-Status ?x) 
		(and
			(Status ?x)
		)
	)


	(:derived (inferred-Thruster ?x) 
		(and
			(Thruster ?x)
		)
	)


	(:derived (inferred-HasPart ?x ?y) 
		(and
			(hasPart ?x ?y)
		)
	)


	(:derived (inferred-Requires ?x ?y) 
		(and
			(requires ?x ?y)
		)
	)


	(:derived (inferred-Solves ?x ?y) 
		(and
			(solves ?x ?y)
		)
	)


	(:derived (inferred-TopObjectProperty ?x ?y) 
		(and
			(topObjectProperty ?x ?y)
		)
	)


	(:derived (inferred-TopObjectProperty ?x ?y) 
		(and
			(inferred-HasPart ?x ?y)
		)
	)


	(:derived (inferred-TopObjectProperty ?x ?y) 
		(and
			(inferred-Solves ?x ?y)
		)
	)


	(:derived (inferred-TopObjectProperty ?x ?y) 
		(and
			(inferred-Requires ?x ?y)
		)
	)


	(:derived (inferred-AbstractThing ?x) 
		(and
			(inferred-FunctionalDesign ?x)
		)
	)


	(:derived (inferred-ConcreteThing ?x) 
		(and
			(inferred-Robot ?x)
		)
	)


	(:derived (inferred-ConcreteThing ?x) 
		(and
			(inferred-RobotPart ?x)
		)
	)


	(:derived (inferred-Requirement ?x) 
		(and
			(inferred-RequiresThruster ?x)
		)
	)


	(:derived (inferred-Status ?x) 
		(and
			(inferred-Available ?x)
		)
	)


	(:derived (inferred-AbstractThing ?x) 
		(and
			(inferred-Status ?x)
		)
	)


	(:derived (inferred-Status ?x) 
		(and
			(inferred-Satisfied ?x)
		)
	)


	(:derived (inferred-AbstractThing ?x) 
		(and
			(inferred-Requirement ?x)
		)
	)


	(:derived (inferred-RobotPart ?x) 
		(and
			(inferred-Thruster ?x)
		)
	)


	(:derived (inferred-AbstractThing ?x) 
		(and
			(inferred-Function ?x)
		)
	)


	(:derived (inferred-RobotPart ?y) 
		(exists (?x)
 			(and
				(inferred-HasPart ?x ?y)
			)
		)
 	)


	(:derived (inferred-Function ?y) 
		(exists (?x)
 			(and
				(inferred-Solves ?x ?y)
			)
		)
 	)


	(:derived (inferred-Requirement ?y) 
		(exists (?x)
 			(and
				(inferred-Requires ?x ?y)
			)
		)
 	)


	(:derived (inferredInconsistent ) 
		(exists (?x)
 			(and
				(inferred-AbstractThing ?x)
				(inferred-ConcreteThing ?x)
			)
		)
 	)


	(:derived (inferredInconsistent ) 
		(exists (?x)
 			(and
				(inferred-Robot ?x)
				(inferred-RobotPart ?x)
			)
		)
 	)


	(:derived (inferredInconsistent ) 
		(exists (?x)
 			(or 
 				(and
					(inferred-Function ?x)
					(inferred-FunctionalDesign ?x)
				)
				(and
					(inferred-FunctionalDesign ?x)
					(inferred-Requirement ?x)
				)
			) 
 		)
 	)


	(:derived (inferred-FunctionalDesign ?x) 
		(exists (?y)
 			(and
				(inferred-Solves ?x ?y)
			)
		)
 	)


	(:derived (inferred-Satisfied ?rt) 
		(exists (?r ?t)
 			(and
				(inferred-RequiresThruster ?rt)
				(inferred-Robot ?r)
				(inferred-HasPart ?r ?t)
				(inferred-Thruster ?t)
			)
		)
 	)


	(:derived (inferred-Available ?f) 
		(exists (?fd ?r)
 			(and
				(inferred-FunctionalDesign ?fd)
				(inferred-Requirement ?r)
				(inferred-Satisfied ?r)
				(inferred-Requires ?fd ?r)
				(inferred-Function ?f)
				(inferred-Solves ?fd ?f)
			)
		)
 	)


    
    (:action move
        :parameters (?auv ?f ?wp1 ?wp2)
        :precondition (and
            (robot ?auv)
            (function ?f)
            (inferred-Available ?f)
            (waypoint ?wp1)
            (waypoint ?wp2)
            (isAt ?auv ?wp1)
        )
        :effect (and
            (isAt ?auv ?wp2)
            (not (isAt ?auv ?wp1))
        )
    )
)

