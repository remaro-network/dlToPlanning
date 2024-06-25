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

        (inferredrobot ?x)
        (inferredavailable ?x)
        (inferredfunction ?x)
        (inferredfunctionalDesign ?x)
        (inferredrequiresThruster ?x)
        (inferredrobotPart ?x)
        (inferredthruster ?x)
        (inferredhasPart ?r ?x)
        (inferredsolves ?fd ?f)
        (inferredrequires ?fd ?r)
        (inferredTopObjectProperty ?x ?y)
        (TopObjectProperty ?x ?y)
        (inferredAbstractThing ?x)
        (AbstractThing ?x)
        (inferredConcreteThing ?x)
        (ConcreteThing ?x)
        (inferredRequirement ?x)
        (Requirement ?x)
        (inferredSatisfied ?x)
        (Satisfied ?x)
        (inferredStatus ?x)
        (status ?x)
    )

    (:derived (inferredAbstractThing ?x) 
	(and
		(AbstractThing ?x)
	)
)

(:derived (inferredAvailable ?x) 
	(and
		(Available ?x)
	)
)

(:derived (inferredConcreteThing ?x) 
	(and
		(ConcreteThing ?x)
	)
)

(:derived (inferredFunction ?x) 
	(and
		(Function ?x)
	)
)

(:derived (inferredFunctionalDesign ?x) 
	(and
		(FunctionalDesign ?x)
	)
)

(:derived (inferredRequirement ?x) 
	(and
		(Requirement ?x)
	)
)

(:derived (inferredRequiresThruster ?x) 
	(and
		(RequiresThruster ?x)
	)
)

(:derived (inferredRobot ?x) 
	(and
		(Robot ?x)
	)
)

(:derived (inferredRobotPart ?x) 
	(and
		(RobotPart ?x)
	)
)

(:derived (inferredSatisfied ?x) 
	(and
		(Satisfied ?x)
	)
)

(:derived (inferredStatus ?x) 
	(and
		(Status ?x)
	)
)

(:derived (inferredThruster ?x) 
	(and
		(Thruster ?x)
	)
)

(:derived (inferredHasPart ?x ?y) 
	(and
		(hasPart ?x ?y)
	)
)

(:derived (inferredRequires ?x ?y) 
	(and
		(requires ?x ?y)
	)
)

(:derived (inferredSolves ?x ?y) 
	(and
		(solves ?x ?y)
	)
)

(:derived (inferredTopObjectProperty ?x ?y) 
	(and
		(topObjectProperty ?x ?y)
	)
)

(:derived (inferredTopObjectProperty ?x ?y) 
	(and
		(inferredHasPart ?x ?y)
	)
)

(:derived (inferredTopObjectProperty ?x ?y) 
	(and
		(inferredSolves ?x ?y)
	)
)

(:derived (inferredTopObjectProperty ?x ?y) 
	(and
		(inferredRequires ?x ?y)
	)
)

(:derived (inferredAbstractThing ?x) 
	(and
		(inferredFunction ?x)
	)
)

(:derived (inferredStatus ?x) 
	(and
		(inferredSatisfied ?x)
	)
)

(:derived (inferredConcreteThing ?x) 
	(and
		(inferredRobotPart ?x)
	)
)

(:derived (inferredConcreteThing ?x) 
	(and
		(inferredRobot ?x)
	)
)

(:derived (inferredRobotPart ?x) 
	(and
		(inferredThruster ?x)
	)
)

(:derived (inferredAbstractThing ?x) 
	(and
		(inferredStatus ?x)
	)
)

(:derived (inferredAbstractThing ?x) 
	(and
		(inferredRequirement ?x)
	)
)

(:derived (inferredRequirement ?x) 
	(and
		(inferredRequiresThruster ?x)
	)
)

(:derived (inferredStatus ?x) 
	(and
		(inferredAvailable ?x)
	)
)

(:derived (inferredAbstractThing ?x) 
	(and
		(inferredFunctionalDesign ?x)
	)
)

(:derived (inferredRobotPart ?y) 
	(exists (?x)
 		(and
			(inferredHasPart ?x ?y)
		)
	)
 )

(:derived (inferredFunction ?y) 
	(exists (?x)
 		(and
			(inferredSolves ?x ?y)
		)
	)
 )

(:derived (inferredRequirement ?y) 
	(exists (?x)
 		(and
			(inferredRequires ?x ?y)
		)
	)
 )

(:derived (inferredInconsistent ) 
	(exists (?x)
 		(and
			(inferredAbstractThing ?x)
			(inferredConcreteThing ?x)
		)
	)
 )

(:derived (inferredInconsistent ) 
	(exists (?x)
 		(and
			(inferredRobot ?x)
			(inferredRobotPart ?x)
		)
	)
 )

(:derived (inferredInconsistent ) 
	(exists (?x)
 		(or 
 			(and
				(inferredFunction ?x)
				(inferredFunctionalDesign ?x)
			)
			(and
				(inferredFunctionalDesign ?x)
				(inferredRequirement ?x)
			)
		) 
 	)
 )

(:derived (inferredFunctionalDesign ?x) 
	(exists (?y)
 		(and
			(inferredSolves ?x ?y)
		)
	)
 )

(:derived (inferredAvailable ?f) 
	(exists (?fd ?r)
 		(and
			(inferredFunctionalDesign ?fd)
			(inferredRequirement ?r)
			(inferredSatisfied ?r)
			(inferredRequires ?fd ?r)
			(inferredFunction ?f)
			(inferredSolves ?fd ?f)
		)
	)
 )

(:derived (inferredSatisfied ?rt) 
	(exists (?r ?t)
 		(and
			(inferredRequiresThruster ?rt)
			(inferredRobot ?r)
			(inferredHasPart ?r ?t)
			(inferredThruster ?t)
		)
	)
 )
    
    (:action move
        :parameters (?auv ?f ?wp1 ?wp2)
        :precondition (and
            (robot ?auv)
            (function ?f)
            (inferredavailable ?f)
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

