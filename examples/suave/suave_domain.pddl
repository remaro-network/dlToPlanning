(define (domain suave)
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
        pipeline
        robot
        action
        owl-number
    )

    (:predicates
        (pipeline_found ?p - pipeline)
        (pipeline_inspected ?p - pipeline)

        (a_search_pipeline_requires_f ?a - action ?f1 ?f2)
        (a_inspect_pipeline_requires_f ?a - action ?f1 ?f2)

        (robot_started ?r - robot)

        (fd_available ?fd)
    )

    (:action start_robot
      :parameters (?r - robot)
      :precondition (and
      )
      :effect (and
        (robot_started ?r)
      )
    )

    (:action search_pipeline
      :parameters (?a - action ?p - pipeline ?r - robot ?f1 ?f2 ?fd1 ?fd2)
      :precondition (and
        (a_search_pipeline_requires_f ?a ?f1 ?f2)

        (Function ?f1)
        (Function ?f2)
        (FunctionDesign ?fd1)
        (FunctionDesign ?fd2)
        (solvesF ?fd1 ?f1)
        (solvesF ?fd2 ?f2)
        (fd_available ?fd1)
        (fd_available ?fd2)

        (robot_started ?r)
      )
      :effect (and
        (pipeline_found ?p)
      )
    )

    (:action inspect_pipeline
      :parameters (?a - action ?p - pipeline ?r - robot ?f1 ?f2 ?fd1 ?fd2)
      :precondition (and
        (a_inspect_pipeline_requires_f ?a ?f1 ?f2)

        (Function ?f1)
        (Function ?f2)
        (FunctionDesign ?fd1)
        (FunctionDesign ?fd2)
        (solvesF ?fd1 ?f1)
        (solvesF ?fd2 ?f2)
        (fd_available ?fd1)
        (fd_available ?fd2)

        (robot_started ?r)
        (pipeline_found ?p)
      )
      :effect (and
        (pipeline_inspected ?p)
      )
    )
)
