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
    )

    (:predicates
        (pipeline_found ?p - pipeline)
        (pipeline_inspected ?p - pipeline)

        (robot_started ?r - robot)

        (action_requires ?a - action ?f1 ?f2)
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
      :parameters (?a - action ?p - pipeline ?r - robot)
      :precondition (and
        (= ?a a_search_pipeline)
        (exists (?f1 ?f2 ?fd1 ?fd2)
          (and
            (action_requires ?a ?f1 ?f2)
            (Function ?f1)
            (Function ?f2)
            (FunctionDesign ?fd1)
            (FunctionDesign ?fd2)
            (solvesF ?fd1 ?f1)
            (solvesF ?fd2 ?f2)
            (fd_available ?fd1)
            (fd_available ?fd2)
          )
        )
        (robot_started ?r)
      )
      :effect (and
        (pipeline_found ?p)
      )
    )

    (:action inspect_pipeline
      :parameters (?a - action ?p - pipeline ?r - robot)
      :precondition (and
        (= ?a a_inspect_pipeline)
        (exists (?f1 ?f2 ?fd1 ?fd2)
          (and
            (action_requires ?a ?f1 ?f2)
            (Function ?f1)
            (Function ?f2)
            (FunctionDesign ?fd1)
            (FunctionDesign ?fd2)
            (solvesF ?fd1 ?f1)
            (solvesF ?fd2 ?f2)
            (fd_available ?fd1)
            (fd_available ?fd2)
          )
        )

        (robot_started ?r)
        (pipeline_found ?p)
      )
      :effect (and
        (pipeline_inspected ?p)
      )
    )
)
