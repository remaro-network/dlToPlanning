(define (problem example-auv)
    (:domain example-auv)

    (:objects   bluerov fMove fdThrusterMove thruster1 rqThruster
                wp1 wp2 wp3
    )
    (:init
        (waypoint wp1)
        (waypoint wp2)
        (waypoint wp3)
        (robot bluerov)
        (thruster thruster1)
        (hasPart bluerov thruster1)
        (functionalDesign fdThrusterMove)
        (function fMove)
        (solves fdThrusterMove fMove)
        (requiresThruster rqThruster)
        (requires fdThrusterMove rqThruster)

        (isAt bluerov wp1)
    )
    
    (:goal (and
        (isAt bluerov wp2))
    )
)

