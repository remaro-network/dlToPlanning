(define (domain security)
    (:requirements
      :strips
      :typing
      :adl
      :negative-preconditions
      :derived-predicates
      :existential-preconditions
      :disjunctive-preconditions
    )

    (:types
        waypoint
        owl-number
    )

    (:predicates
        (waypoint ?wp)
        (connected ?wp1 ?wp2)
        (hasAlertLevel ?sys ?al)
        (sensitive ?sys)
        (isAt ?wp)
    )


    (:action move
      :parameters (?start - waypoint ?end - waypoint ?fd)
      :precondition (and
        (exists (?f)
          (and
            (= ?f f_move)
            (Function ?f)
            (FunctionDesign ?fd)
            (solvesF ?fd ?f)
            (not (inferred-Fd_realisability ?fd false_boolean))
          )
        )
        (isAt ?start)
        (connected ?start ?end)
        (imply  
          (sensitive ?end)
          (sensitive ?fd)
        )
        
      )
      :effect (and
        (not (isAt ?start))
        (isAt ?end)
      )
    )
)
