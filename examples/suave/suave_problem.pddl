(define (problem example-auv)
    (:domain suave)

    (:objects
      a_search_pipeline - action
      a_inspect_pipeline - action
      pipeline - pipeline
      bluerov - robot
    )

    (:init
      (fd_available fd_spiral_low)
      (fd_available fd_spiral_medium)
      (fd_available fd_spiral_high)
      (fd_available fd_all_thrusters)
      (fd_available fd_recover_thrusters)
      (fd_available fd_follow_pipeline)

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
