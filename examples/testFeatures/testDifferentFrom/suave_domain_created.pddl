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

	(:constants <_string FALSE_string INTERNAL_ERROR_string IN_ERROR_COMPONENT_string IN_ERROR_FR_string IN_ERROR_NFR_string RECOVERED_string a_inspect_pipeline a_search_pipeline battery_level c_thruster_1 c_thruster_2 c_thruster_3 c_thruster_4 c_thruster_5 c_thruster_6 energy f_follow_pipeline f_generate_search_path f_maintain_motion false_boolean fd_all_thrusters fd_follow_pipeline fd_recover_thrusters fd_spiral_high fd_spiral_low fd_spiral_medium fd_unground obs_water_visibility performance qa_inspect_efficiency_high qa_motion_efficiency_degraded qa_motion_efficiency_normal qa_search_efficiency_high qa_search_efficiency_low qa_search_efficiency_medium qa_water_visibility_high qa_water_visibility_low qa_water_visibility_medium safety true_boolean water_visibility)

  (:predicates
    (pipeline_found ?p - pipeline)
    (pipeline_inspected ?p - pipeline)

    (robot_started ?r - robot)

    (system_in_mode ?s ?m)
    (inferred-f_activated ?f)

		(Action ?x)
		(Component ?x)
		(Function ?x)
		(FunctionDesign ?x)
		(FunctionGrounding ?x)
		(Objective ?x)
		(QAvalue ?x)
		(QualityAttributeType ?x)
		(c_status ?x ?y)
		(differentFrom ?x ?y)
		(f_active ?x ?y)
		(fd_efficacy ?x ?y)
		(fd_error_log ?x ?y)
		(fd_realisability ?x ?y)
		(fg_status ?x ?y)
		(hasNFR ?x ?y)
		(hasQAestimation ?x ?y)
		(hasQAvalue ?x ?y)
		(hasValue ?x ?y)
		(inferred-Action ?x)
		(inferred-C_status ?x ?y)
		(inferred-Component ?x)
		(inferred-DifferentFrom ?x ?y)
		(inferred-F_active ?x ?y)
		(inferred-Fd_efficacy ?x ?y)
		(inferred-Fd_error_log ?x ?y)
		(inferred-Fd_realisability ?x ?y)
		(inferred-Fg_status ?x ?y)
		(inferred-Function ?x)
		(inferred-FunctionDesign ?x)
		(inferred-FunctionGrounding ?x)
		(inferred-HasNFR ?x ?y)
		(inferred-HasQAestimation ?x ?y)
		(inferred-HasQAvalue ?x ?y)
		(inferred-HasValue ?x ?y)
		(inferred-Inconsistent)
		(inferred-IsQAtype ?x ?y)
		(inferred-O_always_improve ?x ?y)
		(inferred-O_status ?x ?y)
		(inferred-O_updatable ?x ?y)
		(inferred-Objective ?x)
		(inferred-QAvalue ?x)
		(inferred-Qa_comparison_operator ?x ?y)
		(inferred-Qa_critical ?x ?y)
		(inferred-QualityAttributeType ?x)
		(inferred-RequiresC ?x ?y)
		(inferred-RequiresF ?x ?y)
		(inferred-RequiresO ?x ?y)
		(inferred-SameAs ?x ?y)
		(inferred-SolvesF ?x ?y)
		(inferred-SolvesO ?x ?y)
		(inferred-TypeF ?x ?y)
		(inferred-TypeFD ?x ?y)
		(isQAtype ?x ?y)
		(lessThan ?x ?y)
		(o_always_improve ?x ?y)
		(o_status ?x ?y)
		(o_updatable ?x ?y)
		(qa_comparison_operator ?x ?y)
		(qa_critical ?x ?y)
		(requiresC ?x ?y)
		(requiresF ?x ?y)
		(requiresO ?x ?y)
		(sameAs ?x ?y)
		(solvesF ?x ?y)
		(solvesO ?x ?y)
		(typeF ?x ?y)
		(typeFD ?x ?y)
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


(:derived (inferred-Fd_efficacy ?x ?y) 
	(and
		(fd_efficacy ?x ?y)
	)
)


(:derived (inferred-Fd_error_log ?fd ?o) 
	(exists (?fg)
 		(and
			(inferred-FunctionDesign ?fd)
			(inferred-O_status ?o IN_ERROR_FR_string)
			(inferred-FunctionGrounding ?fg)
			(inferred-TypeFD ?fg ?fd)
			(inferred-SolvesO ?fg ?o)
			(inferred-Objective ?o)
		)
	)
 )


(:derived (inferred-Fd_error_log ?fd ?o) 
	(exists (?fg)
 		(and
			(inferred-TypeFD ?fg ?fd)
			(inferred-FunctionGrounding ?fg)
			(inferred-SolvesO ?fg ?o)
			(inferred-Objective ?o)
			(inferred-FunctionDesign ?fd)
			(inferred-O_status ?o INTERNAL_ERROR_string)
		)
	)
 )


(:derived (inferred-Fd_error_log ?x ?y) 
	(and
		(fd_error_log ?x ?y)
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


(:derived (inferred-Fg_status ?fg ?IN_ERROR_COMPONENT_string) 
	(and
		(= ?IN_ERROR_COMPONENT_string IN_ERROR_COMPONENT_string)
		(exists (?c ?fd)
 			(and
				(inferred-FunctionGrounding ?fg)
				(inferred-C_status ?c FALSE_string)
				(inferred-TypeFD ?fg ?fd)
				(inferred-Component ?c)
				(inferred-RequiresC ?fd ?c)
			)
		)
 	)
 )


(:derived (inferred-Fg_status ?fg ?IN_ERROR_COMPONENT_string) 
	(and
		(= ?IN_ERROR_COMPONENT_string IN_ERROR_COMPONENT_string)
		(exists (?o)
 			(and
				(inferred-FunctionGrounding ?fg)
				(inferred-RequiresO ?fg ?o)
				(inferred-O_status ?o IN_ERROR_COMPONENT_string)
				(inferred-Objective ?o)
			)
		)
 	)
 )


(:derived (inferred-Fg_status ?fg ?IN_ERROR_FR_string) 
	(and
		(= ?IN_ERROR_FR_string IN_ERROR_FR_string)
		(exists (?o)
 			(and
				(inferred-O_status ?o IN_ERROR_FR_string)
				(inferred-FunctionGrounding ?fg)
				(inferred-RequiresO ?fg ?o)
				(inferred-Objective ?o)
			)
		)
 	)
 )


(:derived (inferred-Fg_status ?fg ?IN_ERROR_NFR_string) 
	(and
		(= ?IN_ERROR_NFR_string IN_ERROR_NFR_string)
		(exists (?o)
 			(and
				(inferred-FunctionGrounding ?fg)
				(inferred-RequiresO ?fg ?o)
				(inferred-O_status ?o IN_ERROR_NFR_string)
				(inferred-Objective ?o)
			)
		)
 	)
 )


(:derived (inferred-Fg_status ?x ?y) 
	(and
		(fg_status ?x ?y)
	)
)


(:derived (inferred-Function ?x) 
	(and
		(Function ?x)
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


(:derived (inferred-Function ?y) 
	(exists (?x)
 		(and
			(inferred-TypeF ?x ?y)
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
			(inferred-Fd_efficacy ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionDesign ?x) 
	(exists (?y)
 		(and
			(inferred-Fd_error_log ?x ?y)
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
			(inferred-TypeFD ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionGrounding ?x) 
	(and
		(FunctionGrounding ?x)
	)
)


(:derived (inferred-FunctionGrounding ?x) 
	(exists (?y)
 		(and
			(inferred-Fg_status ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionGrounding ?x) 
	(exists (?y)
 		(and
			(inferred-HasQAvalue ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionGrounding ?x) 
	(exists (?y)
 		(and
			(inferred-RequiresO ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionGrounding ?x) 
	(exists (?y)
 		(and
			(inferred-SolvesO ?x ?y)
		)
	)
 )


(:derived (inferred-FunctionGrounding ?x) 
	(exists (?y)
 		(and
			(inferred-TypeFD ?x ?y)
		)
	)
 )


(:derived (inferred-HasNFR ?x ?y) 
	(and
		(hasNFR ?x ?y)
	)
)


(:derived (inferred-HasQAestimation ?x ?y) 
	(and
		(hasQAestimation ?x ?y)
	)
)


(:derived (inferred-HasQAvalue ?x ?y) 
	(and
		(hasQAvalue ?x ?y)
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
			(inferred-Fd_efficacy ?x ?y)
			(inferred-Fd_efficacy ?x ?z)
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
			(inferred-Fg_status ?x ?y)
			(inferred-Fg_status ?x ?z)
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
			(inferred-O_always_improve ?x ?y)
			(inferred-O_always_improve ?x ?z)
			(not (= ?y ?z))
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-O_status ?x ?y)
			(inferred-O_status ?x ?z)
			(not (= ?y ?z))
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-O_updatable ?x ?y)
			(inferred-O_updatable ?x ?z)
			(not (= ?y ?z))
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


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-SolvesO ?x ?y)
			(inferred-SolvesO ?x ?z)
			(= ?y ?z)
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-TypeF ?x ?y)
			(inferred-TypeF ?x ?z)
			(= ?y ?z)
		)
	)
 )


(:derived (inferred-Inconsistent ) 
	(exists (?x ?y ?z)
 		(and
			(inferred-TypeFD ?x ?y)
			(inferred-TypeFD ?x ?z)
			(= ?y ?z)
		)
	)
 )


(:derived (inferred-IsQAtype ?x ?y) 
	(and
		(isQAtype ?x ?y)
	)
)


(:derived (inferred-O_always_improve ?x ?y) 
	(and
		(o_always_improve ?x ?y)
	)
)


(:derived (inferred-O_status ?o ?IN_ERROR_FR_string) 
	(and
		(= ?IN_ERROR_FR_string IN_ERROR_FR_string)
		(exists (?fg)
 			(and
				(inferred-Fg_status ?fg IN_ERROR_FR_string)
				(inferred-FunctionGrounding ?fg)
				(inferred-SolvesO ?fg ?o)
				(inferred-Objective ?o)
			)
		)
 	)
 )


(:derived (inferred-O_status ?o ?IN_ERROR_NFR_string) 
	(and
		(= ?IN_ERROR_NFR_string IN_ERROR_NFR_string)
		(exists (?fg)
 			(and
				(inferred-FunctionGrounding ?fg)
				(inferred-Fg_status ?fg IN_ERROR_NFR_string)
				(inferred-SolvesO ?fg ?o)
				(inferred-Objective ?o)
			)
		)
 	)
 )


(:derived (inferred-O_status ?x ?y) 
	(and
		(o_status ?x ?y)
	)
)


(:derived (inferred-O_updatable ?o ?true_boolean) 
	(and
		(= ?true_boolean true_boolean)
		(exists (?c)
 			(and
				(inferred-C_status ?c RECOVERED_string)
				(inferred-Component ?c)
				(inferred-Objective ?o)
			)
		)
 	)
 )


(:derived (inferred-O_updatable ?x ?y) 
	(and
		(o_updatable ?x ?y)
	)
)


(:derived (inferred-Objective ?x) 
	(and
		(Objective ?x)
	)
)


(:derived (inferred-Objective ?x) 
	(exists (?y)
 		(and
			(inferred-HasNFR ?x ?y)
		)
	)
 )


(:derived (inferred-Objective ?x) 
	(exists (?y)
 		(and
			(inferred-O_always_improve ?x ?y)
		)
	)
 )


(:derived (inferred-Objective ?x) 
	(exists (?y)
 		(and
			(inferred-O_status ?x ?y)
		)
	)
 )


(:derived (inferred-Objective ?x) 
	(exists (?y)
 		(and
			(inferred-O_updatable ?x ?y)
		)
	)
 )


(:derived (inferred-Objective ?x) 
	(exists (?y)
 		(and
			(inferred-TypeF ?x ?y)
		)
	)
 )


(:derived (inferred-Objective ?y) 
	(exists (?x)
 		(and
			(inferred-Fd_error_log ?x ?y)
		)
	)
 )


(:derived (inferred-Objective ?y) 
	(exists (?x)
 		(and
			(inferred-RequiresO ?x ?y)
		)
	)
 )


(:derived (inferred-Objective ?y) 
	(exists (?x)
 		(and
			(inferred-SolvesO ?x ?y)
		)
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
			(inferred-HasNFR ?x ?y)
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


(:derived (inferred-QAvalue ?y) 
	(exists (?x)
 		(and
			(inferred-HasQAvalue ?x ?y)
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


(:derived (inferred-RequiresO ?x ?y) 
	(and
		(requiresO ?x ?y)
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


(:derived (inferred-SolvesO ?x ?y) 
	(and
		(solvesO ?x ?y)
	)
)


(:derived (inferred-TypeF ?x ?y) 
	(and
		(typeF ?x ?y)
	)
)


(:derived (inferred-TypeFD ?x ?y) 
	(and
		(typeFD ?x ?y)
	)
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
