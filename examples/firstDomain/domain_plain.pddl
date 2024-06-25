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
    )
    
    (:action move
        :parameters (?auv ?f ?wp1 ?wp2)
        :precondition (and
            (robot ?auv)
            (function ?f)
            (inferredAvailable ?f)
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

