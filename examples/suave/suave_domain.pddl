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
    owl-number
  )

  (:predicates
    (pipeline_found ?p - pipeline)
    (pipeline_inspected ?p - pipeline)

    (robot_started ?r - robot)

    (system_in_mode ?s ?m)
    (inferred-f_activated ?f)
  )

  (:derived (inferred-f_activated ?f)
    (and
      (Function ?f)
      (exists (?fd)
        (and
          (FunctionDesign ?fd)
          (system_in_mode ?f ?fd)
          (not (= ?fd fd_unground))
        )
      )
    )
  )

  (:action start_robot
    :parameters (?r - robot)
    :precondition (and
    )
    :effect (and
      (robot_started ?r)
    )
  )

  (:action reconfigure
    :parameters (?f ?fd_initial ?fd_goal)
    :precondition (and
      (Function ?f)
      (FunctionDesign ?fd_initial)
      (FunctionDesign ?fd_goal)
      (system_in_mode ?f ?fd_initial)
      (not (= ?fd_initial ?fd_goal))
    )
    :effect (and
      (not (system_in_mode ?f ?fd_initial))
      (system_in_mode ?f ?fd_goal)
    )
  )

  (:action search_pipeline
    :parameters (?p - pipeline ?r - robot)
    :precondition (and
      (exists (?a ?f1 ?f2 ?fd1 ?fd2)
        (and
          (inferred-Action ?a)
          (= ?a a_search_pipeline)
          (not (= ?f1 ?f2))
          (inferred-requiresF ?a ?f1)
          (inferred-requiresF ?a ?f2)
          (Function ?f1)
          (Function ?f2)
          (FunctionDesign ?fd1)
          (FunctionDesign ?fd2)
          (solvesF ?fd1 ?f1)
          (solvesF ?fd2 ?f2)
          (not (inferred-Fd_realisability ?fd1 false_boolean))
          (not (inferred-Fd_realisability ?fd2 false_boolean))
          (system_in_mode ?f1 ?fd1)
          (system_in_mode ?f2 ?fd2)
        )
      )
      (not (inferred-f_activated f_follow_pipeline))
      (robot_started ?r)
    )
    :effect (and
      (pipeline_found ?p)
    )
  )

  (:action inspect_pipeline
    :parameters (?p - pipeline ?r - robot)
    :precondition (and
      (exists (?a ?f1 ?f2 ?fd1 ?fd2)
        (and
          (Action ?a)
          (= ?a a_inspect_pipeline)
          (not (= ?f1 ?f2))
          (inferred-requiresF ?a ?f1)
          (inferred-requiresF ?a ?f2)
          (Function ?f1)
          (Function ?f2)
          (FunctionDesign ?fd1)
          (FunctionDesign ?fd2)
          (solvesF ?fd1 ?f1)
          (solvesF ?fd2 ?f2)
          (not (inferred-Fd_realisability ?fd1 false_boolean))
          (not (inferred-Fd_realisability ?fd2 false_boolean))
          (system_in_mode ?f1 ?fd1)
          (system_in_mode ?f2 ?fd2)
        )
      )
      (not (inferred-f_activated f_generate_search_path))
      (robot_started ?r)
      (pipeline_found ?p)
    )
    :effect (and
      (pipeline_inspected ?p)
    )
  )
)
