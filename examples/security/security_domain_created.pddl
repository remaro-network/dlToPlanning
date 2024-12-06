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

	(:constants FALSE_string al_compromized al_default al_halt al_soft_alert f_move false_boolean fd_move fd_move_sensitive security_system)

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
		(QAvalue ?x)
		(QualityAttributeType ?x)
		(alert_severity ?x ?y)
		(c_status ?x ?y)
		(fd_efficacy ?x ?y)
		(fd_realisability ?x ?y)
		(hasQAestimation ?x ?y)
		(hasValue ?x ?y)
		(inferred-AlertLevel ?x)
		(inferred-Alert_severity ?x ?y)
		(inferred-C_status ?x ?y)
		(inferred-Component ?x)
		(inferred-Fd_efficacy ?x ?y)
		(inferred-Fd_realisability ?x ?y)
		(inferred-Function ?x)
		(inferred-FunctionDesign ?x)
		(inferred-HasAlertLevel ?x ?y)
		(inferred-HasQAestimation ?x ?y)
		(inferred-HasValue ?x ?y)
		(inferred-Inconsistent)
		(inferred-IsQAtype ?x ?y)
		(inferred-MaxAlertLevel ?x ?y)
		(inferred-QAvalue ?x)
		(inferred-Qa_comparison_operator ?x ?y)
		(inferred-Qa_critical ?x ?y)
		(inferred-QualityAttributeType ?x)
		(inferred-RequiresC ?x ?y)
		(inferred-Sensitive ?x)
		(inferred-SolvesF ?x ?y)
		(inferred-TopObjectProperty ?x ?y)
		(isQAtype ?x ?y)
		(lessThan ?x ?y)
		(maxAlertLevel ?x ?y)
		(qa_comparison_operator ?x ?y)
		(qa_critical ?x ?y)
		(requiresC ?x ?y)
		(solvesF ?x ?y)
		(topObjectProperty ?x ?y)
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


(:derived (inferred-HasAlertLevel ?x ?y) 
	(and
		(hasAlertLevel ?x ?y)
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


(:derived (inferred-MaxAlertLevel ?x ?y) 
	(and
		(maxAlertLevel ?x ?y)
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
