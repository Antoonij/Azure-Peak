/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock
	name = "bloodlock rifle"
	desc = "Оружие скованное тёмными эльфами, глубоко во тьме Подземий. Заряжается жизненной энергией владельца"
	icon = 'modular_twilight_axis/firearms/icons/Zizolock.dmi'
	icon_state = "zizolock"
	var/icon_state_ready = "zizolock_r"
	var/default_icon_state = "zizolock"
	item_state = "zizolock"
	associated_skill = /datum/skill/combat/staves
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/shoot/twilight_runelock, /datum/intent/arc/twilight_runelock, INTENT_GENERIC)
	mag_type = /obj/item/ammo_box/magazine/internal/shot/twilight_bloodlock
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	experimental_onback = TRUE
	bigboy = TRUE
	wlength = WLENGTH_LONG
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	spread = 10
	recoil = 3
	force = 10
	force_wielded = 15
	var/cocked = FALSE
	cartridge_wording = "bullet"
	load_sound = 'modular_twilight_axis/firearms/sound/musketload.ogg'
	fire_sound = 'modular_twilight_axis/firearms/sound/musketfire2.ogg'
	var/list/fire_sound_variations = list(
		'modular_twilight_axis/firearms/sound/musketfire2.ogg' = 99.99,
		'modular_twilight_axis/firearms/sound/musketfire11.ogg' = 0.1, //little secret
	)
	vary_fire_sound = TRUE
	fire_sound_volume = 200
	anvilrepair = null
	smeltresult = /obj/item/ingot/steel
	/// Chance for the weapon to misfire
	var/misfire_chance = 0
	/// Reload time, in SECONDS
	var/reload_time = 10
	damfactor = 1.2
	var/critfactor = 1
	var/npcdamfactor = 4

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 6,"nx" = 7,"ny" = 6,"wx" = -2,"wy" = 3,"ex" = 1,"ey" = 3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -43,"sturn" = 43,"wturn" = 30,"eturn" = -30, "nflip" = 0, "sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -2,"nx" = -5,"ny" = -1,"wx" = -8,"wy" = 2,"ex" = 8,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 1,"nturn" = -45,"sturn" = 45,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.5,"sx" = -1,"sy" = 2,"nx" = 0,"ny" = 2,"wx" = 2,"wy" = 1,"ex" = 0,"ey" = 1,"nturn" = 0,"sturn" = 0,"wturn" = 70,"eturn" = 15,"nflip" = 1,"sflip" = 1,"wflip" = 1,"eflip" = 1,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock/shoot_with_empty_chamber()
	if(cocked)
		playsound(src.loc, 'modular_twilight_axis/firearms/sound/musketcock.ogg', 100, FALSE)
		cocked = FALSE
		icon_state = initial(icon_state)
		update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock/attack_self(mob/living/user)
	if(twohands_required)
		return
	if(altgripped || wielded) //Trying to unwield it
		ungrip(user)
		return
	if(!cocked)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(HAS_TRAIT(H, TRAIT_ARCYNE))
				if(NOBLOOD in H.dna.species.species_traits)
					to_chat(H, span_warning("I can't use it, I have no blood to spare!"))
					return
				to_chat(H, span_info("I ready the bloodlock to be fired..."))
				var/adj_reload_time = reload_time
				if(H.mind)
					var/skill = H.get_skill_level(/datum/skill/combat/twilight_firearms)
					if(skill)
						adj_reload_time = reload_time / skill
				if(move_after(H, adj_reload_time SECONDS, target = H))
					H.blood_volume = max(H.blood_volume-50, 0) // 2 loads already 1 stage debuff
					playsound(H, 'modular_twilight_axis/firearms/sound/musketcock.ogg', 100, FALSE)
					cocked = TRUE
			else
				to_chat(H, "<span class='warning'>Я совершенно не понимаю, как этим пользоваться!</span>")
		else
			to_chat(user, "<span class='warning'>Я совершенно не понимаю, как этим пользоваться!</span>")
	else
		if(alt_grips)
			altgrip(user)
		if(gripped_intents)
			wield(user)
	update_icon()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock/update_icon()
	..()
	if(cocked && icon_state_ready)
		icon_state = icon_state_ready
		item_state = "zizolock_r"
	else
		icon_state = default_icon_state
		item_state = default_icon_state
	if(!ismob(loc))
		return
	var/mob/M = loc
	M.update_inv_hands()

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		if(cocked)
			if((loc == user) && (user.get_inactive_held_item() != src) && (user.get_active_held_item() != src))
				return
			..()
		else
			to_chat(user, span_warning("I need to cock the bloodlock first!"))
	if(istype(A, /obj/item/rogueweapon/hammer))
		var/repair_percent = 0.025 // 2.5% Repairing per hammer smack
		if(locate(/obj/machinery/anvil) in src.loc)
			repair_percent *= 2 // Double the repair amount if we're using an anvil
		var/exp_gained = 0
		var/repair_skill = (user?.mind ? user.get_skill_level(/datum/skill/craft/engineering) : 1)
		if((obj_integrity >= max_integrity) || !isturf(src.loc))
			return

		if(!src.ontable())
			to_chat(user, span_warning("I should put this on a table or an anvil first."))
			return

		if(repair_skill <= 0)
			if(HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR))
				if(locate(/obj/machinery/anvil) in src.loc)
					repair_percent = 0.035
				//Squires can repair on tables, but less efficiently
				else if(src.ontable())
					repair_percent = 0.015
			else if(prob(30))
				repair_percent = 0.01
			else
				repair_percent = 0
		else
			repair_percent *= repair_skill

		playsound(src,'modular_twilight_axis/firearms/sound/arq_repair.ogg', 40, FALSE)
		if(repair_percent)
			repair_percent *= max_integrity
			exp_gained = min(obj_integrity + repair_percent, max_integrity) - obj_integrity
			obj_integrity = min(obj_integrity + repair_percent, max_integrity)
			if(repair_percent == 0.01) // If an inexperienced repair attempt has been successful
				to_chat(user, span_warning("You fumble your way into slightly repairing [src]."))
			else
				user.visible_message(span_info("[user] repairs [src]!"))
			if(obj_broken && obj_integrity == max_integrity)
				src.obj_fix()
			adjust_experience(user, /datum/skill/craft/engineering, exp_gained/2) //We gain as much exp as we fix divided by 2
			return
		else
			user.visible_message(span_warning("[user] fumbles trying to repair [src]!"))
			if(do_after(user, CLICK_CD_MELEE, target = src))
				attack_obj(src, user)
			return

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/u = user
		if(HAS_TRAIT(u, TRAIT_ARCYNE))
			. += span_info("Это оружие оснащено арканным замком — для стрельбы достаточно взвести курок, но зарядить его можно лишь своей кровью и знаниями.")
			if(cocked)
				if(chambered)
					. += span_bold("Взведено и готово к стрельбе.")
				else
					. += span_bold("Оружие взведено, но пуля не установлена.")
			else
				. += span_bold("Не заряжено.")
		else
			. += span_info("Конструкция замка, установленного на этом оружии, вам незнакома.")

/obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock/process_fire/(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(fire_sound_variations && length(fire_sound_variations))
		fire_sound = pickweight(fire_sound_variations)
	var/skill = user.get_skill_level(/datum/skill/combat/twilight_firearms)
	if(skill)
		misfire_chance = max(0, misfire_chance - (skill * 2))
		spread = max(3, spread / skill)
	if(prob(misfire_chance))
		to_chat(user, span_warning("The [name] misfires!"))
		explosion(src, light_impact_range = 2, heavy_impact_range = 1, smoke = FALSE, soundin = 'sound/misc/explode/bomb.ogg')
		qdel(src)
		return
	for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
		var/obj/projectile/bullet/BB = CB.BB
		BB.gunpowder_npc_critfactor *= npcdamfactor
		BB.critfactor *= critfactor
		var/per_scaling = 1 + ((min(user.STAPER, RANGED_STAT_SOFTCAP) - 10) * RANGED_STAT_MULT) + (max(0, user.STAPER - RANGED_STAT_SOFTCAP) * RANGED_STAT_CAPPEDMULT)
		BB.damage *= damfactor * per_scaling
	cocked = FALSE
	update_icon()
	..()

/obj/item/ammo_box/magazine/internal/shot/twilight_bloodlock
	ammo_type = /obj/item/ammo_casing/caseless/rogue/twilight_lead
	caliber = "lead_sphere"
	max_ammo = 1
	start_empty = TRUE

/datum/intent/shoot/twilight_bloodlock
	chargedrain = 0

/datum/intent/shoot/twilight_bloodlock/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 75
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 15)
		//per block
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 0.1
	return chargetime

/datum/intent/arc/twilight_bloodlock
	chargetime = 1
	chargedrain = 0

/datum/intent/arc/twilight_bloodlock/get_chargetime()
	if(mastermob && chargetime)
		var/newtime = chargetime
		//skill block
		newtime = newtime + 70
		newtime = newtime - (mastermob.get_skill_level(/datum/skill/combat/twilight_firearms) * 15)
		//per block
		newtime = newtime + 20
		newtime = newtime - ((mastermob.STAPER)*1.5)
		if(newtime > 0)
			return newtime
		else
			return 1
	return chargetime
