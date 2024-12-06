(define (problem tiago)
  (:domain security)

  (:objects
    wp1 wp2 wp3 wp4 wp5 - waypoint
    0.0_decimal 1.0_decimal 3.0_decimal 4.0_decimal - owl-number
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
    (isat wp1)

    ; difference in behavior
    (hasalertlevel security_system al_soft_alert)
    ;(hasalertlevel security_system al_default)


    

    (equalTo 0.0_decimal 0.0_decimal)
    (equalTo 1.0_decimal 1.0_decimal)
    (equalTo 3.0_decimal 3.0_decimal)
    (equalTo 4.0_decimal 4.0_decimal)
    (lessThan 0.0_decimal 1.0_decimal)
    (lessThan 0.0_decimal 3.0_decimal)
    (lessThan 0.0_decimal 4.0_decimal)
    (lessThan 1.0_decimal 3.0_decimal)
    (lessThan 1.0_decimal 4.0_decimal)
    (lessThan 3.0_decimal 4.0_decimal)

    (AlertLevel al_compromized)
    (AlertLevel al_default)
    (AlertLevel al_halt)
    (AlertLevel al_soft_alert)
    (Function f_move)
    (FunctionDesign fd_move)
    (FunctionDesign fd_move_sensitive)
    (Sensitive fd_move_sensitive)
    (alert_severity al_compromized 3.0_decimal)
    (alert_severity al_default 0.0_decimal)
    (alert_severity al_halt 4.0_decimal)
    (alert_severity al_soft_alert 1.0_decimal)
    (maxAlertLevel fd_move al_compromized)
    (maxAlertLevel fd_move_sensitive al_default)
    (solvesF fd_move f_move)
    (solvesF fd_move_sensitive f_move)
  )

  (:goal (and
    (isat wp3)
  ))
)
