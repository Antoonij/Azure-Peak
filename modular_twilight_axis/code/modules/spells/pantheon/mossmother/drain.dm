/obj/effect/proc_holder/spell/invoked/vampiric_drain/mossmother
	name = "Parasitic Drain"
	desc = "Channels a dark link to steal life from a target over time. Higher holy skill increases the potency."
	associated_skill = /datum/skill/magic/holy
	overlay_icon = 'icons/mob/actions/hagspells.dmi'
	action_icon = 'icons/mob/actions/hagspells.dmi'
	overlay_state = "hand_up"
	beam_icon_state = "curse0"
	ramp_multiplier = 0.05
	base_damage = 0.05
	skill_mod = 0
	heal_ratio = 10
	chargetime = null
	recharge_time = 20 SECONDS
	drain_duration = 10 SECONDS
