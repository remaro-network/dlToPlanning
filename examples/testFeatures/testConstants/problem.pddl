(define (problem constant-test)
    (:domain constant-test)

    ; enumerating all constants that occur
    (:objects   box robot 2.5 3 3.0
    )

    (:init
        (box box)
        (robot robot)
        (weight box 2.5 )
        (strength robot 3)
        (<= 2.5 3)
        (<= 3 3.0)
        (<= 3.0 3)
    )
    
    (:goal (and
        (holds robot box)
    )
    )
)

