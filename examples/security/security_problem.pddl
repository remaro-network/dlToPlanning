(define (problem tiago)
    (:domain security)

    (:objects
      wp1 - waypoint
      wp2 - waypoint
      wp3 - waypoint
      wp4 - waypoint
      wp5 - waypoint
    )

    (:init
      ; a ring of waypoints
      (connected wp1 wp2)
      (connected wp2 wp3)
      (connected wp3 wp4)
      (connected wp4 wp5)
      (connected wp5 wp1)

      (connected wp2 wp1)
      (connected wp3 wp2)
      (connected wp4 wp3)
      (connected wp5 wp4)
      (connected wp1 wp5)


      ; being at this waypoint is sensitive
      (sensitive wp2)
      (isAt wp1)

      ; difference in behavior
      (hasAlertLevel security_system al_soft_alert)
      ;(hasAlertLevel security_system al_default)


    )

    (:goal (and
        (isAt wp3)
      )
    )
)
