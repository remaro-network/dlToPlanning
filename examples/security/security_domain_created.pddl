(define (domain security)
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
        waypoint
        owl-number
    )

	(:constants FALSE_string INTERNAL_ERROR_string IN_ERROR_COMPONENT_string IN_ERROR_FR_string IN_ERROR_NFR_string RECOVERED_string al_compromized al_default al_halt al_soft_alert f_move false_boolean fd_move fd_move_sensitive security_system true_boolean)

    (:predicates
        (waypoint ?wp)
        (connected ?wp1 ?wp2)
        (hasAlertLevel ?sys ?al)
        (sensitive ?sys)
        (isAt ?wp)

		(AlertLevel ?x)
		(Component ?x)
		(Function ?x)
		(FunctionDesign ?x)
		(FunctionGrounding ?x)
		(Objective ?x)
		(QAvalue ?x)
		(QualityAttributeType ?x)
		(alert_severity ?x ?y)
		(c_status ?x ?y)
		(fd_efficacy ?x ?y)
		(fd_error_log ?x ?y)
		(fd_realisability ?x ?y)
		(fg_status ?x ?y)
		(hasNFR ?x ?y)
		(hasQAestimation ?x ?y)
		(hasQAvalue ?x ?y)
		(hasValue ?x ?y)
		(inferred-AlertLevel ?x)
		(inferred-Alert_severity ?x ?y)
		(inferred-C_status ?x ?y)
		(inferred-Component ?x)
		(inferred-Fd_efficacy ?x ?y)
		(inferred-Fd_error_log ?x ?y)
		(inferred-Fd_realisability ?x ?y)
		(inferred-Fg_status ?x ?y)
		(inferred-Function ?x)
		(inferred-FunctionDesign ?x)
		(inferred-FunctionGrounding ?x)
		(inferred-HasAlertLevel ?x ?y)
		(inferred-HasNFR ?x ?y)
		(inferred-HasQAestimation ?x ?y)
		(inferred-HasQAvalue ?x ?y)
		(inferred-HasValue ?x ?y)
		(inferred-Inconsistent)
		(inferred-IsQAtype ?x ?y)
		(inferred-MaxAlertLevel ?x ?y)
		(inferred-O_always_improve ?x ?y)
		(inferred-O_status ?x ?y)
		(inferred-O_updatable ?x ?y)
		(inferred-Objective ?x)
		(inferred-QAvalue ?x)
		(inferred-Qa_comparison_operator ?x ?y)
		(inferred-Qa_critical ?x ?y)
		(inferred-QualityAttributeType ?x)
		(inferred-RequiresC ?x ?y)
		(inferred-RequiresO ?x ?y)
		(inferred-Sensitive ?x)
		(inferred-SolvesF ?x ?y)
		(inferred-SolvesO ?x ?y)
		(inferred-TopObjectProperty ?x ?y)
		(inferred-TypeF ?x ?y)
		(inferred-TypeFD ?x ?y)
		(isQAtype ?x ?y)
		(lessThan ?x ?y)
		(maxAlertLevel ?x ?y)
		(o_always_improve ?x ?y)
		(o_status ?x ?y)
		(o_updatable ?x ?y)
		(qa_comparison_operator ?x ?y)
		(qa_critical ?x ?y)
		(requiresC ?x ?y)
		(requiresO ?x ?y)
		(solvesF ?x ?y)
		(solvesO ?x ?y)
		(topObjectProperty ?x ?y)
		(typeF ?x ?y)
		(typeFD ?x ?y)
		(equalTo ?x ?y)
    )


(:derived (inferred-AlertLevel ?x) 
	(and
		(AlertLevel ?x)
	)
)


(:derived (inferred-AlertLevel ?x) 
	(exists (?y)
 		(and
			(inferred-Alert_severity ?x ?y)
		)
	)
 )


(:derived (inferred-AlertLevel ?y) 
	(exists (?x)
 		(and
			(inferred-HasAlertLevel ?x ?y)
		)
	)
 )


(:derived (inferred-AlertLevel ?y) 
	(exists (?x)
 		(and
			(inferred-MaxAlertLevel ?x ?y)
		)
	)
 )


(:derived (inferred-Alert_severity ?x ?y) 
	(and
		(alert_severity ?x ?y)
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


(:derived (inferred-Fd_realisability ?fd ?false_boolean) 
	(and
		(= ?false_boolean false_boolean)
		(exists (?sal ?fdal ?fdals ?sals)
 			(and
				(inferred-HasAlertLevel security_system ?sal)
				(inferred-MaxAlertLevel ?fd ?fdal)
				(inferred-Alert_severity ?fdal ?fdals)
				(inferred-FunctionDesign ?fd)
				(inferred-Alert_severity ?sal ?sals)
				(lessThan ?fdals ?sals)
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
			(inferred-MaxAlertLevel ?x ?y)
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


(:derived (inferred-HasAlertLevel ?x ?y) 
	(and
		(hasAlertLevel ?x ?y)
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


(:derived (inferred-MaxAlertLevel ?x ?y) 
	(and
		(maxAlertLevel ?x ?y)
	)
)


(:derived (inferred-O_always_improve ?x ?y) 
	(and
		(o_always_improve ?x ?y)
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


(:derived (inferred-RequiresO ?x ?y) 
	(and
		(requiresO ?x ?y)
	)
)


(:derived (inferred-Sensitive ?x) 
	(and
		(Sensitive ?x)
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


(:derived (inferred-TopObjectProperty ?x ?y) 
	(and
		(inferred-HasAlertLevel ?x ?y)
	)
)


(:derived (inferred-TopObjectProperty ?x ?y) 
	(and
		(topObjectProperty ?x ?y)
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




    (:action move
      :parameters (?start - waypoint ?end - waypoint ?fd)
      :precondition (and
        (exists (?f)
          (and
            (= ?f f_move)
            (Function ?f)
            (FunctionDesign ?fd)
            (solvesF ?fd ?f)
            (not (inferred-Fd_realisability ?fd false_boolean))
          )
        )
        (isAt ?start)
        (connected ?start ?end)
        (imply  
          (sensitive ?end)
          (sensitive ?fd)
        )
        
      )
      :effect (and
        (not (isAt ?start))
        (isAt ?end)
      )
    )
)
