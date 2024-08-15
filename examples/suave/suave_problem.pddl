(define (problem example-auv)
    (:domain suave)

    (:objects
      f_generate_search_path - object
      f_follow_pipeline - object
      f_maintain_motion - object
      fd_spiral_low - object
      fd_spiral_medium - object
      fd_spiral_high - object
      fd_all_thrusters - object
      fd_recover_thrusters - object
      fd_follow_pipeline - object

      a_search_pipeline - action
      a_inspect_pipeline - action
      pipeline - pipeline
      bluerov - robot

      2.0_decimal - number 
      3.25_decimal - number 
    )

    (:init
      (fd_available fd_spiral_low)
      (fd_available fd_spiral_medium)
      (fd_available fd_spiral_high)
      (fd_available fd_all_thrusters)
      (fd_available fd_recover_thrusters)
      (fd_available fd_follow_pipeline)

      (a_search_pipeline_requires_f a_search_pipeline f_generate_search_path f_maintain_motion)
      (a_inspect_pipeline_requires_f a_inspect_pipeline f_follow_pipeline f_maintain_motion)
    )

    (:goal (and
        (robot_started bluerov)
        (pipeline_found pipeline)
        (pipeline_inspected pipeline)
      )
    )
)
