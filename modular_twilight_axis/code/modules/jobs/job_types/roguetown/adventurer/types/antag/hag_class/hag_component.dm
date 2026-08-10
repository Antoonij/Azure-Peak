/datum/component/hag_curio_tracker/antag_check(mob/living/carbon/C)
	if(!C.mind)
		return FALSE

	if(C.mind.has_antag_datum(/datum/antagonist/vampire))
		return FALSE

	if(C.mind.has_antag_datum(/datum/antagonist/werewolf))
		return FALSE

	if(C.mind.has_antag_datum(/datum/antagonist/gnoll))
		return FALSE

	if(C.mind.has_antag_datum(/datum/antagonist/hag))
		return FALSE

	if(C.mind.has_antag_datum(/datum/antagonist/skeleton))
		return FALSE

	if(HAS_TRAIT(C, TRAIT_FEYTOUCHED) || istype(C.patron, /datum/patron/mossmother))
		return FALSE

	return TRUE
