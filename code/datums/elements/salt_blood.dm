/datum/element/salt_blood

/datum/element/salt_blood/Attach(datum/target)
	. = ..()

	if(!ishuman(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_LIVING_EARLY_BLEED, PROC_REF(on_bleed))

/datum/element/salt_blood/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, COMSIG_LIVING_EARLY_BLEED)

/datum/element/salt_blood/proc/on_bleed(mob/living/carbon/human/source, amt)
    SIGNAL_HANDLER

    var/level = source.get_skill_level(/datum/skill/magic/holy)
    var/reduction_percent = level * 0.05
    var/multiplier = 1 - reduction_percent

    *amt *= multiplier
