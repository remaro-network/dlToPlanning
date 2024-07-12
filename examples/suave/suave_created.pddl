(define (domain suave)

    (:requirements
        :strips
        :derived-predicates
        :existential-preconditions
        :disjunctive-preconditions
        :equality
    )

	(:constants INTERNAL_ERROR_string EXTERNAL_ERROR_string IN_ERROR_COMPONENT_string false_boolean IN_ERROR_FR_string FALSE_string true_boolean IN_ERROR_NFR_string RECOVERED_string UPDATABLE_string energy water_visibility safety)

    (:predicates

		(inferred-Binding ?x)
		(Binding ?x)
		(inferred-Component ?x)
		(Component ?x)
		(inferred-ComponentClass ?x)
		(ComponentClass ?x)
		(inferred-ComponentSpecification ?x)
		(ComponentSpecification ?x)
		(inferred-ComponentState ?x)
		(ComponentState ?x)
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
		(inferred-Role ?x)
		(Role ?x)
		(inferred-Binding_component ?x ?y)
		(binding_component ?x ?y)
		(inferred-Binding_role ?x ?y)
		(binding_role ?x ?y)
		(inferred-Fd_error_log ?x ?y)
		(fd_error_log ?x ?y)
		(inferred-HasBindings ?x ?y)
		(hasBindings ?x ?y)
		(inferred-HasNFR ?x ?y)
		(hasNFR ?x ?y)
		(inferred-HasQAestimation ?x ?y)
		(hasQAestimation ?x ?y)
		(inferred-HasQAvalue ?x ?y)
		(hasQAvalue ?x ?y)
		(inferred-IsQAtype ?x ?y)
		(isQAtype ?x ?y)
		(inferred-RequiresO ?x ?y)
		(requiresO ?x ?y)
		(inferred-RoleDef ?x ?y)
		(roleDef ?x ?y)
		(inferred-Roles ?x ?y)
		(roles ?x ?y)
		(inferred-SolvesF ?x ?y)
		(solvesF ?x ?y)
		(inferred-SolvesO ?x ?y)
		(solvesO ?x ?y)
		(inferred-TypeC ?x ?y)
		(typeC ?x ?y)
		(inferred-TypeF ?x ?y)
		(typeF ?x ?y)
		(inferred-TypeFD ?x ?y)
		(typeFD ?x ?y)
		(inferred-RequiredBy ?x ?y)
		(requiredBy ?x ?y)
		(inferred-Inconsistent)
		(inferred-HasValue ?x ?y)
		(inferred-Qa_comparison_operator ?x ?y)
		(inferred-C_status ?x ?y)
		(inferred-O_status ?x ?y)
		(inferred-Fd_realisability ?x ?y)
		(inferred-Fd_efficacy ?x ?y)
		(inferred-B_status ?x ?y)
		(inferred-O_always_improve ?x ?y)
		(inferred-Cc_availability ?x ?y)
		(inferred-Cspec_availability ?x ?y)
		(inferred-Cc_unique ?x ?y)
		(inferred-Qa_critical ?x ?y)
		(inferred-Fg_status ?x ?y)
		(inferred-GreaterThan ?x ?y)
		(inferred-LessThan ?x ?y)
    )


	(:derived (inferred-Binding ?x) 
		(and
			(Binding ?x)
		)
	)


	(:derived (inferred-Component ?x) 
		(and
			(Component ?x)
		)
	)


	(:derived (inferred-ComponentClass ?x) 
		(and
			(ComponentClass ?x)
		)
	)


	(:derived (inferred-ComponentSpecification ?x) 
		(and
			(ComponentSpecification ?x)
		)
	)


	(:derived (inferred-ComponentState ?x) 
		(and
			(ComponentState ?x)
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


	(:derived (inferred-Role ?x) 
		(and
			(Role ?x)
		)
	)


	(:derived (inferred-Binding_component ?x ?y) 
		(and
			(binding_component ?x ?y)
		)
	)


	(:derived (inferred-Binding_role ?x ?y) 
		(and
			(binding_role ?x ?y)
		)
	)


	(:derived (inferred-Fd_error_log ?x ?y) 
		(and
			(fd_error_log ?x ?y)
		)
	)


	(:derived (inferred-HasBindings ?x ?y) 
		(and
			(hasBindings ?x ?y)
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


	(:derived (inferred-RequiresO ?x ?y) 
		(and
			(requiresO ?x ?y)
		)
	)


	(:derived (inferred-RoleDef ?x ?y) 
		(and
			(roleDef ?x ?y)
		)
	)


	(:derived (inferred-Roles ?x ?y) 
		(and
			(roles ?x ?y)
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


	(:derived (inferred-TypeC ?x ?y) 
		(and
			(typeC ?x ?y)
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


	(:derived (inferred-RequiredBy ?x ?y) 
		(and
			(requiredBy ?x ?y)
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
				(inferred-SolvesF ?x ?y)
				(inferred-SolvesF ?x ?z)
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


	(:derived (inferred-Inconsistent ) 
		(exists (?x ?y ?z)
 			(and
				(inferred-Binding_component ?x ?y)
				(inferred-Binding_component ?x ?z)
				(= ?y ?z)
			)
		)
 	)


	(:derived (inferred-Inconsistent ) 
		(exists (?x ?y ?z)
 			(and
				(inferred-RoleDef ?x ?y)
				(inferred-RoleDef ?x ?z)
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
				(inferred-Binding_role ?x ?y)
				(inferred-Binding_role ?x ?z)
				(= ?y ?z)
			)
		)
 	)


	(:derived (inferred-Component ?x) 
		(and
			(inferred-ComponentSpecification ?x)
		)
	)


	(:derived (inferred-Component ?x) 
		(and
			(inferred-ComponentState ?x)
		)
	)


	(:derived (inferred-Objective ?y) 
		(exists (?x)
 			(and
				(inferred-Fd_error_log ?x ?y)
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


	(:derived (inferred-Component ?y) 
		(exists (?x)
 			(and
				(inferred-RoleDef ?x ?y)
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


	(:derived (inferred-QAvalue ?y) 
		(exists (?x)
 			(and
				(inferred-HasQAvalue ?x ?y)
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


	(:derived (inferred-Component ?y) 
		(exists (?x)
 			(and
				(inferred-Binding_component ?x ?y)
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
				(inferred-HasQAestimation ?x ?y)
			)
		)
 	)


	(:derived (inferred-ComponentClass ?y) 
		(exists (?x)
 			(and
				(inferred-TypeC ?x ?y)
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


	(:derived (inferred-Objective ?y) 
		(exists (?x)
 			(and
				(inferred-RequiresO ?x ?y)
			)
		)
 	)


	(:derived (inferred-Role ?y) 
		(exists (?x)
 			(and
				(inferred-Binding_role ?x ?y)
			)
		)
 	)


	(:derived (inferred-Role ?y) 
		(exists (?x)
 			(and
				(inferred-Roles ?x ?y)
			)
		)
 	)


	(:derived (inferred-ComponentSpecification ?y) 
		(exists (?x)
 			(and
				(inferred-RoleDef ?x ?y)
			)
		)
 	)


	(:derived (inferred-Binding ?y) 
		(exists (?x)
 			(and
				(inferred-HasBindings ?x ?y)
			)
		)
 	)


	(:derived (inferred-Inconsistent ) 
		(exists (?x)
 			(or 
 				(and
					(inferred-Binding ?x)
					(inferred-Component ?x)
				)
				(and
					(inferred-Component ?x)
					(inferred-ComponentClass ?x)
				)
				(and
					(inferred-ComponentClass ?x)
					(inferred-Function ?x)
				)
				(and
					(inferred-Function ?x)
					(inferred-FunctionDesign ?x)
				)
				(and
					(inferred-FunctionDesign ?x)
					(inferred-FunctionGrounding ?x)
				)
				(and
					(inferred-FunctionGrounding ?x)
					(inferred-Objective ?x)
				)
				(and
					(inferred-Objective ?x)
					(inferred-QAvalue ?x)
				)
				(and
					(inferred-QAvalue ?x)
					(inferred-QualityAttributeType ?x)
				)
				(and
					(inferred-QualityAttributeType ?x)
					(inferred-Role ?x)
				)
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


	(:derived (inferred-QualityAttributeType ?x) 
		(exists (?y)
 			(and
				(inferred-Qa_comparison_operator ?x ?y)
			)
		)
 	)


	(:derived (inferred-ComponentState ?x) 
		(exists (?y)
 			(and
				(inferred-C_status ?x ?y)
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
				(inferred-Fd_efficacy ?x ?y)
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


	(:derived (inferred-Binding ?x) 
		(exists (?y)
 			(and
				(inferred-B_status ?x ?y)
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


	(:derived (inferred-ComponentClass ?x) 
		(exists (?y)
 			(and
				(inferred-Cc_availability ?x ?y)
			)
		)
 	)


	(:derived (inferred-ComponentSpecification ?x) 
		(exists (?y)
 			(and
				(inferred-Cspec_availability ?x ?y)
			)
		)
 	)


	(:derived (inferred-ComponentClass ?x) 
		(exists (?y)
 			(and
				(inferred-Cc_unique ?x ?y)
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
				(inferred-Cc_availability ?x ?y)
				(inferred-Cc_availability ?x ?z)
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
				(inferred-B_status ?x ?y)
				(inferred-B_status ?x ?z)
				(not (= ?y ?z))
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
				(inferred-HasValue ?x ?y)
				(inferred-HasValue ?x ?z)
				(not (= ?y ?z))
			)
		)
 	)


	(:derived (inferred-Inconsistent ) 
		(exists (?x ?y ?z)
 			(and
				(inferred-Cc_unique ?x ?y)
				(inferred-Cc_unique ?x ?z)
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
				(inferred-Fd_efficacy ?x ?y)
				(inferred-Fd_efficacy ?x ?z)
				(not (= ?y ?z))
			)
		)
 	)


	(:derived (inferred-FunctionGrounding ?x) 
		(exists (?y)
 			(and
				(inferred-HasBindings ?x ?y)
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


	(:derived (inferred-Objective ?x) 
		(exists (?y)
 			(and
				(inferred-TypeF ?x ?y)
			)
		)
 	)


	(:derived (inferred-Binding ?x) 
		(exists (?y)
 			(and
				(inferred-Binding_role ?x ?y)
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


	(:derived (inferred-Objective ?x) 
		(exists (?y)
 			(and
				(inferred-HasNFR ?x ?y)
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


	(:derived (inferred-Role ?x) 
		(exists (?y)
 			(and
				(inferred-RoleDef ?x ?y)
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


	(:derived (inferred-Binding ?x) 
		(exists (?y)
 			(and
				(inferred-Binding_component ?x ?y)
			)
		)
 	)


	(:derived (inferred-Component ?x) 
		(exists (?y)
 			(and
				(inferred-TypeC ?x ?y)
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
				(inferred-Roles ?x ?y)
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


	(:derived (inferred-Fg_status ?fg ?EXTERNAL_ERROR_string) 
		(and
			(= ?EXTERNAL_ERROR_string EXTERNAL_ERROR_string)
			(exists (?o)
 				(and
					(inferred-FunctionGrounding ?fg)
					(inferred-RequiresO ?fg ?o)
					(inferred-Objective ?o)
					(inferred-O_status ?o INTERNAL_ERROR_string)
				)
			)
 		)
 	)


	(:derived (inferred-Fg_status ?fg ?IN_ERROR_COMPONENT_string) 
		(and
			(= ?IN_ERROR_COMPONENT_string IN_ERROR_COMPONENT_string)
			(exists (?o)
 				(and
					(inferred-O_status ?o IN_ERROR_COMPONENT_string)
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
			(exists (?b)
 				(and
					(inferred-Binding ?b)
					(inferred-HasBindings ?fg ?b)
					(inferred-B_status ?b false_boolean)
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


	(:derived (inferred-Cspec_availability ?cs ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?b ?r ?c)
 				(and
					(inferred-Binding_role ?b ?r)
					(inferred-Binding_component ?b ?c)
					(inferred-Binding ?b)
					(inferred-C_status ?c false_boolean)
					(inferred-RoleDef ?r ?cs)
				)
			)
 		)
 	)


	(:derived (inferred-Fd_realisability ?fd ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?cc ?cs ?r)
 				(and
					(inferred-ComponentClass ?cc)
					(inferred-ComponentSpecification ?cs)
					(inferred-Role ?r)
					(inferred-Cc_availability ?cc false_boolean)
					(inferred-RoleDef ?r ?cs)
					(inferred-FunctionDesign ?fd)
					(inferred-TypeC ?cs ?cc)
					(inferred-Roles ?fd ?r)
				)
			)
 		)
 	)


	(:derived (inferred-O_status ?o ?IN_ERROR_FR_string) 
		(and
			(= ?IN_ERROR_FR_string IN_ERROR_FR_string)
			(exists (?fg)
 				(and
					(inferred-Objective ?o)
					(inferred-FunctionGrounding ?fg)
					(inferred-SolvesO ?fg ?o)
					(inferred-Fg_status ?fg IN_ERROR_FR_string)
				)
			)
 		)
 	)


	(:derived (inferred-Fg_status ?fg ?IN_ERROR_FR_string) 
		(and
			(= ?IN_ERROR_FR_string IN_ERROR_FR_string)
			(exists (?o)
 				(and
					(inferred-Objective ?o)
					(inferred-O_status ?o IN_ERROR_FR_string)
					(inferred-FunctionGrounding ?fg)
					(inferred-RequiresO ?fg ?o)
				)
			)
 		)
 	)


	(:derived (inferred-Fg_status ?fg ?IN_ERROR_COMPONENT_string) 
		(and
			(= ?IN_ERROR_COMPONENT_string IN_ERROR_COMPONENT_string)
			(exists (?fd ?c)
 				(and
					(inferred-TypeFD ?fg ?fd)
					(inferred-Component ?c)
					(inferred-RequiredBy ?c ?fd)
					(inferred-FunctionGrounding ?fg)
					(inferred-C_status ?c FALSE_string)
				)
			)
 		)
 	)


	(:derived (inferred-Fg_status ?fg ?INTERNAL_ERROR_string) 
		(and
			(= ?INTERNAL_ERROR_string INTERNAL_ERROR_string)
			(exists (?b)
 				(and
					(inferred-Binding ?b)
					(inferred-HasBindings ?fg ?b)
					(inferred-B_status ?b false_boolean)
				)
			)
 		)
 	)


	(:derived (inferred-Fd_error_log ?fd ?o) 
		(exists (?fg)
 			(and
				(inferred-FunctionGrounding ?fg)
				(inferred-SolvesO ?fg ?o)
				(inferred-TypeFD ?fg ?fd)
				(inferred-Objective ?o)
				(inferred-FunctionDesign ?fd)
				(inferred-O_status ?o IN_ERROR_FR_string)
			)
		)
 	)


	(:derived (inferred-Cc_availability ?cc ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?c)
 				(and
					(inferred-Component ?c)
					(inferred-TypeC ?c ?cc)
					(inferred-Cc_unique ?cc true_boolean)
					(inferred-C_status ?c false_boolean)
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
					(inferred-O_status ?o IN_ERROR_NFR_string)
					(inferred-RequiresO ?fg ?o)
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
					(inferred-SolvesO ?fg ?o)
					(inferred-Objective ?o)
					(inferred-Fg_status ?fg IN_ERROR_NFR_string)
				)
			)
 		)
 	)


	(:derived (inferred-O_status ?o ?UPDATABLE_string) 
		(and
			(= ?UPDATABLE_string UPDATABLE_string)
			(exists (?c)
 				(and
					(inferred-Component ?c)
					(inferred-C_status ?c RECOVERED_string)
					(inferred-Objective ?o)
				)
			)
 		)
 	)


	(:derived (inferred-Cc_availability ?cc ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?c)
 				(and
					(inferred-Component ?c)
					(inferred-TypeC ?c ?cc)
					(inferred-Cc_unique ?cc true_boolean)
					(inferred-C_status ?c FALSE_string)
				)
			)
 		)
 	)


	(:derived (inferred-O_status ?o ?INTERNAL_ERROR_string) 
		(and
			(= ?INTERNAL_ERROR_string INTERNAL_ERROR_string)
			(exists (?fg)
 				(and
					(inferred-Fg_status ?fg INTERNAL_ERROR_string)
					(inferred-FunctionGrounding ?fg)
					(inferred-SolvesO ?fg ?o)
					(inferred-Objective ?o)
				)
			)
 		)
 	)


	(:derived (inferred-Fd_realisability ?fd ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?cs ?r)
 				(and
					(inferred-Cspec_availability ?cs false_boolean)
					(inferred-ComponentSpecification ?cs)
					(inferred-RoleDef ?r ?cs)
					(inferred-Roles ?fd ?r)
				)
			)
 		)
 	)


	(:derived (inferred-Fd_realisability ?fg ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?c)
 				(and
					(inferred-Component ?c)
					(inferred-RequiredBy ?c ?fg)
					(inferred-C_status ?c FALSE_string)
				)
			)
 		)
 	)


	(:derived (inferred-O_status ?o ?IN_ERROR_FR_string) 
		(and
			(= ?IN_ERROR_FR_string IN_ERROR_FR_string)
			(exists (?nfr ?qa ?fg ?nfrv ?qav)
 				(and
					(inferred-Objective ?o)
					(inferred-QAvalue ?nfr)
					(inferred-QAvalue ?qa)
					(inferred-HasNFR ?o ?nfr)
					(inferred-FunctionGrounding ?fg)
					(inferred-SolvesO ?fg ?o)
					(inferred-HasQAvalue ?fg ?qa)
					(inferred-IsQAtype ?qa energy)
					(inferred-IsQAtype ?nfr energy)
					(inferred-HasValue ?nfr ?nfrv)
					(inferred-HasValue ?qa ?qav)
					(inferred-GreaterThan ?qav ?nfrv)
				)
			)
 		)
 	)


	(:derived (inferred-B_status ?b ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?c)
 				(and
					(inferred-Binding_component ?b ?c)
					(inferred-Binding ?b)
					(inferred-C_status ?c false_boolean)
				)
			)
 		)
 	)


	(:derived (inferred-Fg_status ?fg ?IN_ERROR_NFR_string) 
		(and
			(= ?IN_ERROR_NFR_string IN_ERROR_NFR_string)
			(exists (?mqa ?fd ?eqa ?mqav ?eqav)
 				(and
					(inferred-FunctionGrounding ?fg)
					(inferred-QAvalue ?mqa)
					(inferred-HasQAvalue ?fg ?mqa)
					(inferred-IsQAtype ?mqa water_visibility)
					(inferred-FunctionDesign ?fd)
					(inferred-QAvalue ?eqa)
					(inferred-TypeFD ?fg ?fd)
					(inferred-HasQAestimation ?fd ?eqa)
					(inferred-IsQAtype ?eqa water_visibility)
					(inferred-HasValue ?mqa ?mqav)
					(inferred-HasValue ?eqa ?eqav)
					(inferred-LessThan ?mqav ?eqav)
				)
			)
 		)
 	)


	(:derived (inferred-O_status ?o ?IN_ERROR_FR_string) 
		(and
			(= ?IN_ERROR_FR_string IN_ERROR_FR_string)
			(exists (?nfr ?qa ?fg ?nfrv ?qav)
 				(and
					(inferred-Objective ?o)
					(inferred-QAvalue ?nfr)
					(inferred-QAvalue ?qa)
					(inferred-HasNFR ?o ?nfr)
					(inferred-FunctionGrounding ?fg)
					(inferred-SolvesO ?fg ?o)
					(inferred-HasQAvalue ?fg ?qa)
					(inferred-IsQAtype ?qa safety)
					(inferred-IsQAtype ?nfr safety)
					(inferred-HasValue ?nfr ?nfrv)
					(inferred-HasValue ?qa ?qav)
					(inferred-GreaterThan ?qav ?nfrv)
				)
			)
 		)
 	)


	(:derived (inferred-O_status ?o ?EXTERNAL_ERROR_string) 
		(and
			(= ?EXTERNAL_ERROR_string EXTERNAL_ERROR_string)
			(exists (?fg)
 				(and
					(inferred-Fg_status ?fg EXTERNAL_ERROR_string)
					(inferred-FunctionGrounding ?fg)
					(inferred-SolvesO ?fg ?o)
					(inferred-Objective ?o)
				)
			)
 		)
 	)


	(:derived (inferred-Cspec_availability ?cs ?false_boolean) 
		(and
			(= ?false_boolean false_boolean)
			(exists (?b ?r ?c)
 				(and
					(inferred-Binding_role ?b ?r)
					(inferred-RoleDef ?r ?cs)
					(inferred-C_status ?c false_boolean)
					(inferred-Binding ?b)
					(inferred-Binding_component ?b ?c)
				)
			)
 		)
 	)


	(:derived (inferred-Fd_error_log ?fd ?o) 
		(exists (?fg)
 			(and
				(inferred-FunctionGrounding ?fg)
				(inferred-SolvesO ?fg ?o)
				(inferred-TypeFD ?fg ?fd)
				(inferred-Objective ?o)
				(inferred-FunctionDesign ?fd)
				(inferred-O_status ?o INTERNAL_ERROR_string)
			)
		)
 	)


	(:derived (inferred-Fg_status ?fg ?EXTERNAL_ERROR_string) 
		(and
			(= ?EXTERNAL_ERROR_string EXTERNAL_ERROR_string)
			(exists (?o)
 				(and
					(inferred-FunctionGrounding ?fg)
					(inferred-O_status ?o EXTERNAL_ERROR_string)
					(inferred-RequiresO ?fg ?o)
					(inferred-Objective ?o)
				)
			)
 		)
 	)


)
