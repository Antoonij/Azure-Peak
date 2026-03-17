/datum/element/damage_spread
    element_flags = ELEMENT_DETACH_ON_HOST_DESTROY | ELEMENT_BESPOKE
    var/brute_damage_threshold_percent
    var/burn_damage_threshold_percent
    var/miss_chance

/datum/element/damage_spread/Attach(
    mob/living/carbon/target, 
    brute_damage_threshold_percent, 
    burn_damage_threshold_percent,
    miss_chance,
    )
    if(!istype(target))
        return ELEMENT_INCOMPATIBLE

    src.brute_damage_threshold_percent = brute_damage_threshold_percent
    src.burn_damage_threshold_percent = burn_damage_threshold_percent
    src.miss_chance = miss_chance

    RegisterSignal(target, COMSIG_MOB_APPLY_DAMGE, PROC_REF(apply_damage))

    return ..()

/datum/element/damage_spread/Detach(mob/living/carbon/target)
    . = ..()
    UnregisterSignal(target, COMSIG_MOB_APPLY_DAMGE)

/datum/element/damage_spread/proc/apply_damage(mob/living/carbon/target, damage_amount, damage_type, obj/item/bodypart/part, spread_damage)
    SIGNAL_HANDLER

    if(*spread_damage)
        return
    
    if(!istype(part))
        part = target.get_bodypart(check_zone(part))

    var/should_spread = FALSE

    if(brute_damage_threshold_percent && damage_type == BRUTE)
        var/damage_percent = (part.brute_dam / part.max_damage) * 100

        if(damage_percent < brute_damage_threshold_percent)
            return

        should_spread = TRUE

    if(burn_damage_threshold_percent && damage_type == BURN)
        var/damage_percent = (part.burn_dam / part.max_damage) * 100

        if(damage_percent < burn_damage_threshold_percent)
            return

        should_spread = TRUE

    if(!should_spread)
        return

    if(try_miss(target, part, damage_amount, damage_type))
        return

    *spread_damage = TRUE

/datum/element/damage_spread/proc/try_miss(mob/living/carbon/target, obj/item/bodypart/part, damage_amount, damage_type)
    if(!can_miss(part))
        return FALSE

    var/obj/item/bodypart/chest = target.get_bodypart(BODY_ZONE_CHEST)

    if(!chest)
        return FALSE

    if(damage_type == BRUTE)
        INVOKE_ASYNC(chest, TYPE_PROC_REF(/obj/item/bodypart, receive_damage), damage_amount)
    else
        INVOKE_ASYNC(chest, TYPE_PROC_REF(/obj/item/bodypart, receive_damage), null, damage_amount)

    return TRUE

/datum/element/damage_spread/proc/can_miss(obj/item/bodypart/part)
    return part.body_zone != BODY_ZONE_CHEST && prob(miss_chance)
    
