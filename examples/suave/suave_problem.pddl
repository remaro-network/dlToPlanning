(define (problem example-auv)
    (:domain suave)

    (:objects
      a_search_pipeline - action
      a_inspect_pipeline - action
      pipeline - pipeline
      bluerov - robot

      2.0_decimal - owl-number 
      3.25_decimal - owl-number 
    )

    (:init
      (c_status c_thruster_4 FALSE_string)

      (action_requires a_search_pipeline f_generate_search_path f_maintain_motion)
      (action_requires a_inspect_pipeline f_follow_pipeline f_maintain_motion)
    )

    (:goal (and
        (robot_started bluerov)
        (pipeline_found pipeline)
        (pipeline_inspected pipeline)
      )
    )
)
