/datum/element/damage_spread
    element_flags = ELEMENT_DETACH_ON_HOST_DESTROY | ELEMENT_BESPOKE
    var/list/allowed_damage_types
    var/damage_threshold_percent

/datum/element/damage_spread/Attach(
    mob/living/carbon/target, 
    allowed_damage_types, 
    damage_threshold_percent,
    )
    if(!istype(target))
        return ELEMENT_INCOMPATIBLE

    src.allowed_damage_types = allowed_damage_types
    src.damage_threshold_percent = damage_threshold_percent

    RegisterSignal(target, COMSIG_MOB_APPLY_DAMGE, PROC_REF(apply_damage))

    return ..()

/datum/element/damage_spread/Detach(mob/living/carbon/target)
    . = ..()
    UnregisterSignal(target, COMSIG_MOB_APPLY_DAMGE)

/datum/element/damage_spread/proc/apply_damage(mob/living/carbon/target, damage_amount, damage_type, obj/item/bodypart/part, spread_damage)
    SIGNAL_HANDLER

    if(!istype(part) || !(damage_type in allowed_damage_types) || *spread_damage)
        return

    var/damage_percent = (part.get_damage() / part.max_damage) * 100

    if(damage_percent < damage_threshold_percent)
        return

    *spread_damage = TRUE
