/datum/element/shove_wrestling

/datum/element/shove_wrestling/Attach(datum/target)
	. = ..()

	if(!ishuman(target))
		return ELEMENT_INCOMPATIBLE
    
	RegisterSignal(target, COMSIG_SPECIES_EARLY_SHOVE, PROC_REF(try_shove))

/datum/element/shove_wrestling/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_SPECIES_EARLY_SHOVE)

/datum/element/shove_wrestling/proc/try_shove(mob/living/carbon/human/source, mob/living/carbon/human/target)
    SIGNAL_HANDLER

    if(source.pulling != target || !(target.mobility_flags & MOBILITY_STAND))
        return

    INVOKE_ASYNC(src, PROC_REF(shove), source, target)
    return COMPONENT_OVERRIDE_SHOVE

/datum/element/shove_wrestling/proc/shove(mob/living/carbon/human/source, mob/living/carbon/human/target)
    target.stamina_add(source.get_skill_level(/datum/skill/combat/wrestling))

    target.visible_message(span_warning("[source] tries to shove [target] to the ground!"), \
		span_danger("[source] tries to shove me to the ground!"), span_hear("I hear a sickening sound of pugilism!"), COMBAT_MESSAGE_RANGE)

    if(target.stamina != target.max_stamina)
        return
    
    target.Knockdown(0.5 SECONDS)
