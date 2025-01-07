(define (problem example-auv)
  (:domain suave)

  (:objects 
    pipeline - pipeline 
    bluerov - robot 
    1.0_decimal 1.5_decimal 3.5_decimal - numerical-object
)

  (:init
    ;(hasvalue obs_water_visibility 2.5_decimal)
    
    (equalTo 1.0_decimal 1.0_decimal)
    (equalTo 1.5_decimal 1.5_decimal)
    (equalTo 3.5_decimal 3.5_decimal)
    (lessThan 1.0_decimal 1.5_decimal)
    (lessThan 1.0_decimal 3.5_decimal)
    (lessThan 1.5_decimal 3.5_decimal)
    
    (Action a_inspect_pipeline)
    (Action a_search_pipeline)
    (Component c_thruster_1)
    (Component c_thruster_2)
    (Component c_thruster_3)
    (Component c_thruster_4)
    (Component c_thruster_5)
    (Component c_thruster_6)
    (Function f_follow_pipeline)
    (Function f_generate_search_path)
    (Function f_maintain_motion)
    (FunctionDesign fd_all_thrusters)
    (FunctionDesign fd_follow_pipeline)
    (FunctionDesign fd_recover_thrusters)
    (FunctionDesign fd_spiral_high)
    (FunctionDesign fd_spiral_low)
    (FunctionDesign fd_spiral_medium)
    (FunctionDesign fd_unground)
    (QAvalue obs_water_visibility)
    (QAvalue qa_inspect_efficiency_high)
    (QAvalue qa_motion_efficiency_degraded)
    (QAvalue qa_motion_efficiency_normal)
    (QAvalue qa_search_efficiency_high)
    (QAvalue qa_search_efficiency_low)
    (QAvalue qa_search_efficiency_medium)
    (QAvalue qa_water_visibility_high)
    (QAvalue qa_water_visibility_low)
    (QAvalue qa_water_visibility_medium)
    (QualityAttributeType battery_level)
    (QualityAttributeType energy)
    (QualityAttributeType performance)
    (QualityAttributeType safety)
    (QualityAttributeType water_visibility)
    (hasQAestimation fd_all_thrusters qa_motion_efficiency_normal)
    (hasQAestimation fd_follow_pipeline qa_inspect_efficiency_high)
    (hasQAestimation fd_recover_thrusters qa_motion_efficiency_degraded)
    (hasQAestimation fd_spiral_high qa_search_efficiency_high)
    (hasQAestimation fd_spiral_high qa_water_visibility_high)
    (hasQAestimation fd_spiral_low qa_search_efficiency_low)
    (hasQAestimation fd_spiral_low qa_water_visibility_low)
    (hasQAestimation fd_spiral_medium qa_search_efficiency_medium)
    (hasQAestimation fd_spiral_medium qa_water_visibility_medium)
    (hasQAestimation fd_unground qa_performance_zero)
    (isQAtype obs_water_visibility water_visibility)
    (isQAtype qa_inspect_efficiency_high performance)
    (isQAtype qa_motion_efficiency_degraded performance)
    (isQAtype qa_motion_efficiency_normal performance)
    (isQAtype qa_performance_zero performance)
    (isQAtype qa_search_efficiency_high performance)
    (isQAtype qa_search_efficiency_low performance)
    (isQAtype qa_search_efficiency_medium performance)
    (isQAtype qa_water_visibility_high water_visibility)
    (isQAtype qa_water_visibility_low water_visibility)
    (isQAtype qa_water_visibility_medium water_visibility)
    (requiresC fd_all_thrusters c_thruster_1)
    (requiresC fd_all_thrusters c_thruster_2)
    (requiresC fd_all_thrusters c_thruster_3)
    (requiresC fd_all_thrusters c_thruster_4)
    (requiresC fd_all_thrusters c_thruster_5)
    (requiresC fd_all_thrusters c_thruster_6)
    (requiresF a_inspect_pipeline f_follow_pipeline)
    (requiresF a_inspect_pipeline f_maintain_motion)
    (requiresF a_search_pipeline f_generate_search_path)
    (requiresF a_search_pipeline f_maintain_motion)
    (solvesF fd_all_thrusters f_maintain_motion)
    (solvesF fd_follow_pipeline f_follow_pipeline)
    (solvesF fd_recover_thrusters f_maintain_motion)
    (solvesF fd_spiral_high f_generate_search_path)
    (solvesF fd_spiral_low f_generate_search_path)
    (solvesF fd_spiral_medium f_generate_search_path)
    (solvesF fd_unground f_follow_pipeline)
    (solvesF fd_unground f_generate_search_path)
    (solvesF fd_unground f_maintain_motion)
  )

  (:goal (and
    (robot_started bluerov)
    (pipeline_found pipeline)
    (pipeline_inspected pipeline)
  ))
)