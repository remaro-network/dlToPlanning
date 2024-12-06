(define (problem example-auv)
  (:domain suave)

  (:objects
    pipeline - pipeline
    bluerov - robot
    1.0_decimal 1.5_decimal 3.5_decimal - owl-number
  )

  (:init
    (system_in_mode f_maintain_motion fd_unground)
    (system_in_mode f_follow_pipeline fd_unground)
    (system_in_mode f_generate_search_path fd_unground)

    (hasValue obs_water_visibility 3.5_decimal)
  )

  (:goal (and
      (robot_started bluerov)
      (pipeline_found pipeline)
      (pipeline_inspected pipeline)
    )
  )
)
