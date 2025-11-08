/mob/living/carbon/human/proc/calculate_sentinel_bonus()
	if(STAINT <= 10)
		return 0

	var/bonus = (STAINT - 10) * 5

	if(HAS_TRAIT(src, TRAIT_HEAVYARMOR) || \
	HAS_TRAIT(src, TRAIT_MEDIUMARMOR) || \
	HAS_TRAIT(src, TRAIT_DODGEEXPERT) || \
	HAS_TRAIT(src, TRAIT_CRITICAL_RESISTANCE))
		return clamp(bonus, 0, 25)

	return clamp(bonus, 0, 50)

/// Gets the "true" value of a stat on a human mob by eliminating all status effect modifiers that affect that stat.
/mob/living/proc/get_true_stat(stat)
	var/fakestat = get_stat(stat)
	if(status_effects.len)
		for(var/S in status_effects)
			var/datum/status_effect/status = S
			if(status.effectedstats.len)
				if(status.effectedstats[stat])
					if(status.effectedstats[stat] > 0)
						fakestat -= status.effectedstats[stat]
	return fakestat
