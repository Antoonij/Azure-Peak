/obj/effect/proc_holder/spell/invoked/vampiric_drain
	name = "Vampiric Drain"
	desc = "Channels a dark link to steal life from a target over 10 seconds. Higher arcane skill increases the potency."
	overlay_state = "bloodlightning"
	releasedrain = 40
	chargedrain = 1
	chargetime = 30
	range = 2
	cost = 6
	spell_tier = 3
	recharge_time = 30 SECONDS
	warnie = "spellwarning"
	invocations = list("Sakra!")
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	invocation_type = "shout"
	glow_color = GLOW_COLOR_METAL
	glow_intensity = GLOW_INTENSITY_HIGH
	gesture_required = TRUE
	ignore_los = FALSE
	zizo_spell = TRUE

	var/drain_duration = 18 SECONDS
	var/tick_delay = 10
	var/base_damage = 2
	var/ramp_multiplier = 3.5
	var/heal_ratio = 1.5
	var/skill_mod = 2.5
	var/blood_drain_per_tick = 1
	var/beam_icon_state = "blood"

/obj/effect/proc_holder/spell/invoked/vampiric_drain/cast(list/targets, mob/living/user = usr)
	if(!isliving(targets[1]))
		revert_cast()
		return FALSE

	var/mob/living/target = targets[1]

	if(HAS_TRAIT(target, TRAIT_PSYDONITE))
		user.playsound_local(user, 'sound/magic/PSY.ogg', 100, FALSE, -1)
		return FALSE

	if(istype(target, /mob/living/simple_animal/hostile/rogue/skeleton))
		to_chat(user, span_warning("There is no life essence to absorb!"))
		user.playsound_local(user, 'sound/gore/flesh_eat_02.ogg', 50, FALSE)
		revert_cast()
		return FALSE

	if(target == user)
		revert_cast()
		return FALSE

	user.apply_status_effect(/datum/status_effect/debuff/vampiric_slowdown, drain_duration)
	var/datum/beam/vamp_beam = user.Beam(target, time = drain_duration, icon_state = beam_icon_state)
	user.visible_message(span_danger("[user] pierces [target] with a dark link, siphoning their life!"))

	INVOKE_ASYNC(src, .proc/handle_drain_logic, user, target, vamp_beam)

	return TRUE

/obj/effect/proc_holder/spell/invoked/vampiric_drain/proc/handle_drain_logic(mob/living/user, mob/living/target, datum/beam/vamp_beam)
    var/skill_level = user.get_skill_level(associated_skill)
    var/total_ticks = drain_duration / tick_delay

    for(var/tick_count in 1 to total_ticks)
        if(QDELETED(user) || QDELETED(target) || user.stat || target.stat)
            break

        if(user.z != target.z)
            to_chat(user, span_warning("The distance is too great! The link snaps!"))
            break

        if(!(target in view(range + 1, user)))
            to_chat(user, span_warning("You lost sight of the target! The link snaps!"))
            break

        var/current_damage = (base_damage + (tick_count * ramp_multiplier)) + (skill_level * skill_mod)
        var/current_heal = current_damage * heal_ratio

        playsound(target, 'sound/magic/bloodheal.ogg', 40 + (tick_count * 5), TRUE)

        target.apply_damage(current_damage, BRUTE)

        user.adjustBruteLoss(-(current_heal / 2))
        user.adjustFireLoss(-(current_heal / 2))
        user.heal_wounds(1.5 + (skill_level * 0.5))

        if(iscarbon(target) && iscarbon(user))
            var/mob/living/carbon/C_target = target
            var/mob/living/carbon/C_user = user
            if(!(NOBLOOD in C_target.dna?.species?.species_traits))
                C_target.blood_volume -= blood_drain_per_tick
                C_user.blood_volume = min(C_user.blood_volume + blood_drain_per_tick, BLOOD_VOLUME_NORMAL)

        stoplag(tick_delay)

    if(vamp_beam)
        vamp_beam.End()

    if(!QDELETED(user))
        user.remove_status_effect(/datum/status_effect/debuff/vampiric_slowdown)
