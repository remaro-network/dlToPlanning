(define (domain constant-test)

    (:requirements
        :strips
    )
    
    (:predicates
        (robot ?x)
        (box ?x)
        (holds ?x ?b)
        (weight ?r ?w)
        (strength ?r ?s)
        (<= ?x ?y)
        (== ?x ?y)
    )

    (:derived (== ?x ?y)
        (and
            (<= ?x ?y)
            (<= ?y ?x)
        )
    )


    ; we can lift box, if strenth of robot is bigger than weight of box

    (:action lift
        :parameters (?r ?box)
        :precondition 
        (exists (?s ?w) 
            (and
                (robot ?r)
                (strength ?r ?s)
                (box ?box)
                (weight ?box ?w)
                (<= ?w ?s)
            )
        )

        :effect (and
            (holds ?r ?box)
        )
    )
)

