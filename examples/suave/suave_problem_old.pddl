(define (problem example-auv)
    (:domain suave)

    (:objects
      f_generate_search_path - object
      f_follow_pipeline - object
      f_maintain_motion - object
      fd_search_low - object
      fd_search_medium - object
      fd_search_high - object
      fd_maintain_motion - object
      fd_recover_motion - object
      fd_follow - object

      a_search_pipeline - action
      a_inspect_pipeline - action
      pipeline - pipeline
      bluerov - robot
    )

    (:init
      (Function f_generate_search_path)
      (Function f_follow_pipeline)
      (Function f_maintain_motion)
      (FunctionDesign fd_search_low)
      (FunctionDesign fd_search_medium)
      (FunctionDesign fd_search_high)
      (FunctionDesign fd_maintain_motion)
      (FunctionDesign fd_recover_motion)
      (FunctionDesign fd_follow)
      (solvesF fd_search_low f_generate_search_path)
      (solvesF fd_search_medium f_generate_search_path)
      (solvesF fd_search_high f_generate_search_path)
      (solvesF fd_maintain_motion f_maintain_motion)
      (solvesF fd_recover_motion f_maintain_motion)
      (solvesF fd_follow f_follow_pipeline)

      (fd_available fd_search_low)
      (fd_available fd_search_medium)
      (fd_available fd_search_high)
      (fd_available fd_maintain_motion)
      (fd_available fd_recover_motion)
      (fd_available fd_follow)

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
