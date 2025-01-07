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
		function
		function-design
		owl-number
	)

	(:constants
		fd_all_thrusters fd_follow_pipeline fd_recover_thrusters fd_spiral_high fd_spiral_low fd_spiral_medium fd_unground - function-design 
		f_follow_pipeline f_generate_search_path f_maintain_motion - function 
		FALSE_string a_inspect_pipeline a_search_pipeline battery_level c_thruster_1 c_thruster_2 c_thruster_3 c_thruster_4 c_thruster_5 c_thruster_6 energy false_boolean obs_water_visibility performance qa_inspect_efficiency_high qa_motion_efficiency_degraded qa_motion_efficiency_normal qa_performance_zero qa_search_efficiency_high qa_search_efficiency_low qa_search_efficiency_medium qa_water_visibility_high qa_water_visibility_low qa_water_visibility_medium safety true_boolean water_visibility - object
	)

  (:predicates
    (pipeline_found ?p - pipeline)
    (pipeline_inspected ?p - pipeline)

    (robot_started ?r - robot)

		(Action ?x)
		(Component ?x)
		(Function ?x)
		(FunctionDesign ?x)
		(QAvalue ?x)
		(QualityAttributeType ?x)
		(c_status ?x ?y)
		(differentFrom ?x ?y)
		(f_active ?x ?y)
		(fd_better_utility ?x ?y)
		(fd_realisability ?x ?y)
		(fd_utility ?x ?y)
		(functionGrounding ?x ?y)
		(hasQAestimation ?x ?y)
		(hasValue ?x ?y)
		(inferred-Action ?x)
		(inferred-C_status ?x ?y)
		(inferred-Component ?x)
		(inferred-DifferentFrom ?x ?y)
		(inferred-F_active ?x ?y)
		(inferred-Fd_better_utility ?x ?y)
		(inferred-Fd_realisability ?x ?y)
		(inferred-Fd_utility ?x ?y)
		(inferred-Function ?x)
		(inferred-FunctionDesign ?x)
		(inferred-FunctionGrounding ?x ?y)
		(inferred-HasQAestimation ?x ?y)
		(inferred-HasValue ?x ?y)
		(inferred-Inconsistent)
		(inferred-IsQAtype ?x ?y)
		(inferred-QAvalue ?x)
		(inferred-Qa_comparison_operator ?x ?y)
		(inferred-Qa_critical ?x ?y)
		(inferred-QualityAttributeType ?x)
		(inferred-RequiresC ?x ?y)
		(inferred-RequiresF ?x ?y)
		(inferred-SameAs ?x ?y)
		(inferred-SolvesF ?x ?y)
		(isQAtype ?x ?y)
		(lessThan ?x ?y)
		(qa_comparison_operator ?x ?y)
		(qa_critical ?x ?y)
		(requiresC ?x ?y)
		(requiresF ?x ?y)
		(sameAs ?x ?y)
		(solvesF ?x ?y)
		(equalTo ?x ?y)
  )


(:derived (inferred-Action ?x) 
	(and
		(Action ?x)
	)
)


(:derived (inferred-Action ?x) 
	(exists (?y)
 		(and
			(inferred-RequiresF ?x ?y)
		)
	)
 )


(:derived (inferred-C_status ?x ?y) 
	(and
		(c_status ?x ?y)
	)
)


(:derived (inferred-Component ?x) 
	(and
		(Component ?x)
	)
)


(:derived (inferred-Component ?x) 
	(exists (?y)
 		(and
			(inferred-C_status ?x ?y)
		)
	)
 )


(:derived (inferred-Component ?y) 
	(exists (?x)
 		(and
			(inferred-RequiresC ?x ?y)
		)
	)
 )


(:derived (inferred-DifferentFrom ?x ?y) 
	(and
		(differentFrom ?x ?y)
	)
)


(:derived (inferred-F_active ?f ?true_boolean) 
	(and
		(= ?true_boolean true_boolean)
		(exists (?fd)
 			(and
				(inferred-Function ?f)
				(inferred-FunctionDesign ?fd)
				(inferred-SolvesF ?fd ?f)
				(inferred-FunctionGrounding ?f ?fd)
				(not (= ?fd fd_unground))
			)
		)
 	)
 )


(:derived (inferred-F_active ?x ?y) 
	(and
		(f_active ?x ?y)
	)
)


(:derived (inferred-Fd_better_utility ?fd_better ?fd) 
	(exists (?f ?x ?x_better)
 		(and
			(inferred-FunctionDesign ?fd)
			(inferred-FunctionDesign ?fd_better)
			(inferred-Function ?f)
			(inferred-SolvesF ?fd ?f)
			(inferred-SolvesF ?fd_better ?f)
			(inferred-Fd_utility ?fd ?x)
			(inferred-Fd_utility ?fd_better ?x_better)
			(lessThan ?x ?x_better)
		)
	)
 )


(:derived (inferred-Fd_better_utility ?x ?y) 
	(and
		(fd_better_utility ?x ?y)
	)
)


(:derived (inferred-Fd_realisability ?fd ?false_boolean) 
	(and
		(= ?false_boolean false_boolean)
		(exists (?c)
 			(and
				(inferred-C_status ?c FALSE_string)
				(inferred-Component ?c)
				(inferred-RequiresC ?fd ?c)
			)
		)
 	)
 )


(:derived (inferred-Fd_realisability ?fd1 ?false_boolean) 
	(and
		(= ?false_boolean false_boolean)
		(exists (?eqa ?eqav ?mqa ?mqav)
 			(and
				(inferred-FunctionDesign ?fd1)
				(inferred-HasQAestimation ?fd1 ?eqa)
				(inferred-IsQAtype ?eqa water_visibility)
				(inferred-HasValue ?eqa ?eqav)
				(inferred-QAvalue ?mqa)
				(= ?mqa obs_water_visibility)
				(inferred-HasValue ?mqa ?mqav)
				(inferred-IsQAtype ?mqa water_visibility)
				(lessThan ?mqav ?eqav)
			)
		)
 	)
 )


(:derived (inferred-Fd_realisability ?x ?y) 
	(and
		(fd_realisability ?x ?y)
	)
)


(:derived (inferred-Fd_utility ?fd ?qav) 
	(exists (?f ?qa)
 		(and
			(inferred-Function f_follow_pipeline)
			(inferred-FunctionDesign ?fd)
			(inferred-SolvesF ?fd ?f)
			(inferred-HasQAestimation ?fd ?qa)
			(inferred-IsQAtype ?qa performance)
			(inferred-HasValue ?qa ?qav)
		)
	)
 )


(:derived (inferred-Fd_utility ?fd ?qav) 
	(exists (?f ?qa)
 		(and
			(inferred-Function f_generate_search_path)
			(inferred-FunctionDesign ?fd)
			(inferred-SolvesF ?fd ?f)
			(inferred-HasQAestimation ?fd ?qa)
			(inferred-IsQAtype ?qa performance)
			(inferred-HasValue ?qa ?qav)
		)
	)
 )


(:derived (inferred-Fd_utility ?fd ?qav) 
	(exists (?f ?qa)
 		(and
			(inferred-Function f_maintain_motion)
			(inferred-FunctionDesign ?fd)
			(inferred-SolvesF ?fd ?f)
			(inferred-HasQAestimation ?fd ?qa)
			(inferred-IsQAtype ?qa performance)
			(inferred-HasValue ?qa ?qav)
		)
	)
 )


(:derived (inferred-Fd_utility ?x ?y) 
	(and
		(fd_utility ?x ?y)
	)
)


(:derived (inferred-Function ?x) 
	(and
		(Function ?x)
	)
)


(:derived (inferred-Function ?x) 
	(exists (?y)
 		(and
			(inferred-F_active ?x ?y)
		)
	)
 )


(:derived (inferred-Function ?x) 
	(exists (?y)
 		(and
			(inferred-FunctionGrounding ?x ?y)
		)
	)
 )


(:derived (inferred-Function ?y) 
	(exists (?x)
 		(and
			(inferred-RequiresF ?x ?y)
		)
	)
 )


(:derived (inferred-Function ?y) 
	(exists (?x)
 		(and
			(inferred-SolvesF ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?x) 
	(and
		(FunctionDesign ?x)
	)
)


(:derived (inferred-FunctionDesign ?x) 
	(exists (?y)
 		(and
			(inferred-Fd_better_utility ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?x) 
	(exists (?y)
 		(and
			(inferred-Fd_realisability ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?x) 
	(exists (?y)
 		(and
			(inferred-Fd_utility ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?x) 
	(exists (?y)
 		(and
			(inferred-HasQAestimation ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?x) 
	(exists (?y)
 		(and
			(inferred-RequiresC ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?x) 
	(exists (?y)
 		(and
			(inferred-SolvesF ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?y) 
	(exists (?x)
 		(and
			(inferred-Fd_better_utility ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?y) 
	(exists (?x)
 		(and
			(inferred-FunctionGrounding ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionGrounding ?x ?y) 
	(and
		(functionGrounding ?x ?y)
	)
)


(:derived (inferred-HasQAestimation ?x ?y) 
	(and
		(hasQAestimation ?x ?y)
	)
)


(:derived (inferred-HasValue ?x ?y) 
	(and
		(hasValue ?x ?y)
	)
)


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-C_status ?x ?y)
			(inferred-C_status ?x ?z)
			(not (= ?y ?z))
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-F_active ?x ?y)
			(inferred-F_active ?x ?z)
			(not (= ?y ?z))
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-Fd_realisability ?x ?y)
			(inferred-Fd_realisability ?x ?z)
			(not (= ?y ?z))
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-Fd_utility ?x ?y)
			(inferred-Fd_utility ?x ?z)
			(not (= ?y ?z))
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-HasValue ?x ?y)
			(inferred-HasValue ?x ?z)
			(not (= ?y ?z))
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-IsQAtype ?x ?y)
			(inferred-IsQAtype ?x ?z)
			(= ?y ?z)
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-Qa_comparison_operator ?x ?y)
			(inferred-Qa_comparison_operator ?x ?z)
			(not (= ?y ?z))
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-SolvesF ?x ?y)
			(inferred-SolvesF ?x ?z)
			(= ?y ?z)
		)
	)
 )


(:derived (inferred-IsQAtype ?x ?y) 
	(and
		(isQAtype ?x ?y)
	)
)


(:derived (inferred-QAvalue ?x) 
	(and
		(QAvalue ?x)
	)
)


(:derived (inferred-QAvalue ?x) 
	(exists (?y)
 		(and
			(inferred-HasValue ?x ?y)
		)
	)
 )


(:derived (inferred-QAvalue ?x) 
	(exists (?y)
 		(and
			(inferred-IsQAtype ?x ?y)
		)
	)
 )


(:derived (inferred-QAvalue ?y) 
	(exists (?x)
 		(and
			(inferred-HasQAestimation ?x ?y)
		)
	)
 )


(:derived (inferred-Qa_comparison_operator ?x ?y) 
	(and
		(qa_comparison_operator ?x ?y)
	)
)


(:derived (inferred-Qa_critical ?x ?y) 
	(and
		(qa_critical ?x ?y)
	)
)


(:derived (inferred-QualityAttributeType ?x) 
	(and
		(QualityAttributeType ?x)
	)
)


(:derived (inferred-QualityAttributeType ?x) 
	(exists (?y)
 		(and
			(inferred-Qa_comparison_operator ?x ?y)
		)
	)
 )


(:derived (inferred-QualityAttributeType ?x) 
	(exists (?y)
 		(and
			(inferred-Qa_critical ?x ?y)
		)
	)
 )


(:derived (inferred-QualityAttributeType ?y) 
	(exists (?x)
 		(and
			(inferred-IsQAtype ?x ?y)
		)
	)
 )


(:derived (inferred-RequiresC ?x ?y) 
	(and
		(requiresC ?x ?y)
	)
)


(:derived (inferred-RequiresF ?x ?y) 
	(and
		(requiresF ?x ?y)
	)
)


(:derived (inferred-SameAs ?x ?y) 
	(and
		(sameAs ?x ?y)
	)
)


(:derived (inferred-SolvesF ?x ?y) 
	(and
		(solvesF ?x ?y)
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
    :parameters (?f - function ?fd_initial ?fd_goal - function-design)
    :precondition (and
      (not (= ?fd_initial ?fd_goal))

      (Function ?f)
      (FunctionDesign ?fd_initial)
      (functionGrounding ?f ?fd_initial)

      (solvesF ?fd_goal ?f)
      (FunctionDesign ?fd_goal)
      (not (inferred-Fd_realisability ?fd_goal false_boolean))

      (or (= ?fd_goal fd_unground)
        (not
          (exists (?fd)
            (and
              (solvesF ?fd ?f)
              (not (inferred-Fd_realisability ?fd false_boolean))
              (inferred-Fd_better_utility  ?fd ?fd_goal)
            )
          )
        )
      )
    )
    :effect (and
      (not (functionGrounding ?f ?fd_initial))
      (functionGrounding ?f ?fd_goal)
    )
  )

  (:action reconfigure
    :parameters (?f - function ?fd_goal - function-design)
    :precondition (and
      (Function ?f)
      (solvesF ?fd_goal ?f)
      (FunctionDesign ?fd_goal)
      (not (inferred-Fd_realisability ?fd_goal false_boolean))
      (not
        (exists (?fd)
          (and
            (solvesF ?fd ?f)
            (FunctionDesign ?fd)
            (functionGrounding ?f ?fd)
          )
        )
      )
      (or (= ?fd_goal fd_unground)
        (not
          (exists (?fd)
            (and
              (solvesF ?fd ?f)
              (not (inferred-Fd_realisability ?fd false_boolean))
              (inferred-Fd_better_utility  ?fd ?fd_goal)
            )
          )
        )
      )
    )
    :effect (and
      (functionGrounding ?f ?fd_goal)
    )
  )

  (:action search_pipeline
    :parameters (?p - pipeline ?r - robot)
    :precondition (and
      (exists (?a - object ?f1 ?f2 - function ?fd1 ?fd2 - function-design)
        (and
          (inferred-Action ?a)
          (= ?a a_search_pipeline)
          (not (= ?f1 ?f2))
          (inferred-requiresF ?a ?f1)
          (inferred-requiresF ?a ?f2)
          (inferred-F_active ?f1 true_boolean)
          (inferred-F_active ?f2 true_boolean)
        )
      )
      (not (inferred-F_active f_follow_pipeline true_boolean))
      (robot_started ?r)
    )
    :effect (and
      (pipeline_found ?p)
    )
  )

  (:action inspect_pipeline
    :parameters (?p - pipeline ?r - robot)
    :precondition (and
      (exists (?a - object ?f1 ?f2 - function ?fd1 ?fd2 - function-design)
        (and
          (Action ?a)
          (= ?a a_inspect_pipeline)
          (not (= ?f1 ?f2))
          (inferred-requiresF ?a ?f1)
          (inferred-requiresF ?a ?f2)
          (inferred-F_active ?f1 true_boolean)
          (inferred-F_active ?f2 true_boolean)
        )
      )
      (not (inferred-F_active f_generate_search_path true_boolean))
      (robot_started ?r)
      (pipeline_found ?p)
    )
    :effect (and
      (pipeline_inspected ?p)
    )
  )
)
