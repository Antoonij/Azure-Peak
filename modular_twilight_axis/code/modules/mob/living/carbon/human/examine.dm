/mob/living/carbon/human/get_heretic_symbol(mob/living/examiner)
	. = ..()

	if(patron?.symbol && istype(patron, examiner.patron?.type))
		. += patron.symbol
