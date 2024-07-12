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

	(:constants IN_ERROR_FR_string IN_ERROR_COMPONENT_string FALSE_string false_boolean IN_ERROR_NFR_string water_visibility INTERNAL_ERROR_string RECOVERED_string true_boolean)

    (:predicates
        (pipeline_found ?p - pipeline)
        (pipeline_inspected ?p - pipeline)

        (a_search_pipeline_requires_f ?a - action ?f1 ?f2)
        (a_inspect_pipeline_requires_f ?a - action ?f1 ?f2)

        (robot_started ?r - robot)

        (fd_available ?fd)

		(inferred-Component ?x)
		(Component ?x)
		(inferred-Function ?x)
		(Function ?x)
		(inferred-FunctionDesign ?x)
		(FunctionDesign ?x)
		(inferred-FunctionGrounding ?x)
		(FunctionGrounding ?x)
		(inferred-Objective ?x)
		(Objective ?x)
		(inferred-QAvalue ?x)
		(QAvalue ?x)
		(inferred-QualityAttributeType ?x)
		(QualityAttributeType ?x)
		(inferred-Fd_error_log ?x ?y)
		(fd_error_log ?x ?y)
		(inferred-HasNFR ?x ?y)
		(hasNFR ?x ?y)
		(inferred-HasQAestimation ?x ?y)
		(hasQAestimation ?x ?y)
		(inferred-HasQAvalue ?x ?y)
		(hasQAvalue ?x ?y)
		(inferred-IsQAtype ?x ?y)
		(isQAtype ?x ?y)
		(inferred-RequiredBy ?x ?y)
		(requiredBy ?x ?y)
		(inferred-RequiresO ?x ?y)
		(requiresO ?x ?y)
		(inferred-SolvesF ?x ?y)
		(solvesF ?x ?y)
		(inferred-SolvesO ?x ?y)
		(solvesO ?x ?y)
		(inferred-TypeF ?x ?y)
		(typeF ?x ?y)
		(inferred-TypeFD ?x ?y)
		(typeFD ?x ?y)
		(inferred-Inconsistent)
		(inferred-O_updatable ?x ?y)
		(inferred-O_status ?x ?y)
		(inferred-HasValue ?x ?y)
		(inferred-O_always_improve ?x ?y)
		(inferred-Qa_comparison_operator ?x ?y)
		(inferred-Qa_critical ?x ?y)
		(inferred-C_status ?x ?y)
		(inferred-Fd_efficacy ?x ?y)
		(inferred-Fd_realisability ?x ?y)
		(inferred-Fg_status ?x ?y)
		(inferred-LessThan ?x ?y)
    )


	(:derived (inferred-Component ?x) 
		(and
			(Component ?x)
		)
	)


	(:derived (inferred-Function ?x) 
		(and
			(Function ?x)
		)
	)


	(:derived (inferred-FunctionDesign ?x) 
		(and
			(FunctionDesign ?x)
		)
	)


	(:derived (inferred-FunctionGrounding ?x) 
		(and
			(FunctionGrounding ?x)
		)
	)


	(:derived (inferred-Objective ?x) 
		(and
			(Objective ?x)
		)
	)


	(:derived (inferred-QAvalue ?x) 
		(and
			(QAvalue ?x)
		)
	)


	(:derived (inferred-QualityAttributeType ?x) 
		(and
			(QualityAttributeType ?x)
		)
	)


	(:derived (inferred-Fd_error_log ?x ?y) 
		(and
			(fd_error_log ?x ?y)
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


	(:derived (inferred-IsQAtype ?x ?y) 
		(and
			(isQAtype ?x ?y)
		)
	)


	(:derived (inferred-RequiredBy ?x ?y) 
		(and
			(requiredBy ?x ?y)
		)
	)


	(:derived (inferred-RequiresO ?x ?y) 
		(and
			(requiresO ?x ?y)
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


	(:derived (inferred-Inconsistent ) 
		(exists (?x ?y ?z)
 			(and
				(inferred-IsQAtype ?x ?y)
				(inferred-IsQAtype ?x ?z)
				(= ?y ?z)
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


	(:derived (inferred-QAvalue ?y) 
		(exists (?x)
 			(and
				(inferred-HasQAvalue ?x ?y)
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
				(inferred-HasNFR ?x ?y)
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


	(:derived (inferred-Objective ?y) 
		(exists (?x)
 			(and
				(inferred-SolvesO ?x ?y)
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


	(:derived (inferred-FunctionDesign ?y) 
		(exists (?x)
 			(and
				(inferred-TypeFD ?x ?y)
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
				(inferred-Fd_error_log ?x ?y)
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
				(inferred-O_status ?x ?y)
			)
		)
 	)


	(:derived (inferred-QAvalue ?x) 
		(exists (?y)
 			(and
				(inferred-HasValue ?x ?y)
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


	(:derived (inferred-Component ?x) 
		(exists (?y)
 			(and
				(inferred-C_status ?x ?y)
			)
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
				(inferred-Fd_realisability ?x ?y)
			)
		)
 	)


	(:derived (inferred-FunctionGrounding ?x) 
		(exists (?y)
 			(and
				(inferred-Fg_status ?x ?y)
			)
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
				(inferred-O_always_improve ?x ?y)
				(inferred-O_always_improve ?x ?z)
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
				(inferred-Fd_efficacy ?x ?y)
				(inferred-Fd_efficacy ?x ?z)
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
				(inferred-Fg_status ?x ?y)
				(inferred-Fg_status ?x ?z)
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


	(:derived (inferred-Objective ?x) 
		(exists (?y)
 			(and
				(inferred-TypeF ?x ?y)
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
				(inferred-SolvesF ?x ?y)
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


	(:derived (inferred-QAvalue ?x) 
		(exists (?y)
 			(and
				(inferred-IsQAtype ?x ?y)
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


	(:derived (inferred-FunctionGrounding ?x) 
		(exists (?y)
 			(and
				(inferred-TypeFD ?x ?y)
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
				(inferred-HasQAvalue ?x ?y)
			)
		)
 	)


	(:derived (inferred-Objective ?x) 
		(exists (?y)
 			(and
				(inferred-HasNFR ?x ?y)
			)
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


	(:derived (inferred-O_status ?o ?IN_ERROR_COMPONENT_string) 
		(and
			(= ?IN_ERROR_COMPONENT_string IN_ERROR_COMPONENT_string)
			(exists (?fg)
 				(and
					(inferred-FunctionGrounding ?fg)
					(inferred-SolvesO ?fg ?o)
					(inferred-Fg_status ?fg IN_ERROR_COMPONENT_string)
					(inferred-Objective ?o)
				)
			)
 		)
 	)


	(:derived (inferred-Fd_realisability ?fg ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?c)
 				(and
					(inferred-C_status ?c FALSE_string)
					(inferred-Component ?c)
					(inferred-RequiredBy ?c ?fg)
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


	(:derived (inferred-Fg_status ?fg ?IN_ERROR_COMPONENT_string) 
		(and
			(= ?IN_ERROR_COMPONENT_string IN_ERROR_COMPONENT_string)
			(exists (?c ?fd)
 				(and
					(inferred-FunctionGrounding ?fg)
					(inferred-C_status ?c FALSE_string)
					(inferred-TypeFD ?fg ?fd)
					(inferred-Component ?c)
					(inferred-RequiredBy ?c ?fd)
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


	(:derived (inferred-Fg_status ?fg ?IN_ERROR_NFR_string) 
		(and
			(= ?IN_ERROR_NFR_string IN_ERROR_NFR_string)
			(exists (?mqa ?eqa ?mqav ?fd ?eqav)
 				(and
					(inferred-FunctionGrounding ?fg)
					(inferred-HasQAvalue ?fg ?mqa)
					(inferred-IsQAtype ?eqa water_visibility)
					(inferred-HasValue ?mqa ?mqav)
					(inferred-TypeFD ?fg ?fd)
					(inferred-HasValue ?eqa ?eqav)
					(inferred-HasQAestimation ?fd ?eqa)
					(inferred-IsQAtype ?mqa water_visibility)
					(inferred-FunctionDesign ?fd)
					(inferred-QAvalue ?mqa)
					(inferred-QAvalue ?eqa)
					(inferred-LessThan ?mqav ?eqav)
				)
			)
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



    (:action start_robot
      :parameters (?r - robot)
      :precondition (and
      )
      :effect (and
        (robot_started ?r)
      )
    )

    (:action search_pipeline
      :parameters (?a - action ?p - pipeline ?r - robot ?f1 ?f2 ?fd1 ?fd2)
      :precondition (and
        (a_search_pipeline_requires_f ?a ?f1 ?f2)

        (Function ?f1)
        (Function ?f2)
        (FunctionDesign ?fd1)
        (FunctionDesign ?fd2)
        (solvesF ?fd1 ?f1)
        (solvesF ?fd2 ?f2)
        (fd_available ?fd1)
        (fd_available ?fd2)

        (robot_started ?r)
      )
      :effect (and
        (pipeline_found ?p)
      )
    )

    (:action inspect_pipeline
      :parameters (?a - action ?p - pipeline ?r - robot ?f1 ?f2 ?fd1 ?fd2)
      :precondition (and
        (a_inspect_pipeline_requires_f ?a ?f1 ?f2)

        (Function ?f1)
        (Function ?f2)
        (FunctionDesign ?fd1)
        (FunctionDesign ?fd2)
        (solvesF ?fd1 ?f1)
        (solvesF ?fd2 ?f2)
        (fd_available ?fd1)
        (fd_available ?fd2)

        (robot_started ?r)
        (pipeline_found ?p)
      )
      :effect (and
        (pipeline_inspected ?p)
      )
    )
)
