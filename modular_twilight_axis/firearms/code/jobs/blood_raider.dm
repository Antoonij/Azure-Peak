/obj/item/clothing/head/roguetown/helmet/bloodhelmet
	name = "Bloodraider helmet"
	desc = "blabla"
	icon_state = "bloodhelmet"
	item_state = "bloodhelmet"
	body_parts_covered = HEAD | HAIR | EARS | EYES
	armor_class = ARMOR_CLASS_LIGHT
	max_integrity = 300
	smeltresult = /obj/item/ingot/steel
	icon = 'modular_twilight_axis/icons/clothing/bloodraider.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'

/obj/item/clothing/neck/roguetown/chaincoif/chainmantle/bloodraider
	name = "raiders mantle"
	desc = "A thicker and more durable piece of neck protection that also covers the mouth when pulled up."
	icon_state = "bloodchainmantle"
	item_state = "bloodchainmantle"
	armor = ARMOR_MAILLE
	body_parts_covered = NECK|MOUTH
	slot_flags = ITEM_SLOT_NECK
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	icon = 'modular_twilight_axis/icons/clothing/bloodraider.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'

/obj/item/clothing/neck/roguetown/chaincoif/chainmantle/bloodraider/ComponentInitialize()
	AddComponent(/datum/component/adjustable_clothing, (NECK), null, null, 'sound/foley/equip/equip_armor_chain.ogg', null, (UPD_HEAD|UPD_MASK|UPD_NECK))	//Chain coif.
	AddComponent(/datum/component/armour_filtering/negative, TRAIT_FENCERDEXTERITY)
	AddComponent(/datum/component/armour_filtering/negative, TRAIT_HONORBOUND)

/obj/item/clothing/suit/roguetown/armor/plate/cuirass/bloodraider
	slot_flags = ITEM_SLOT_ARMOR
	name = "Raiders cuirass"
	desc = "A steel cuirass. It bares all the hallmarks of sixteenth-century nobility: angularity, polishedness, and - above all else - class."
	body_parts_covered = COVERAGE_ALL_BUT_HANDLEGS
	icon_state = "bloodcuirass"
	item_state = "bloodcuirass"
	armor = ARMOR_PLATE
	nodismemsleeves = TRUE
	blocking_behavior = null
	max_integrity = ARMOR_INT_CHEST_MEDIUM_STEEL
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	armor_class = ARMOR_CLASS_LIGHT
	smelt_bar_num = 1
	icon = 'modular_twilight_axis/icons/clothing/bloodraider.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'

/obj/item/clothing/gloves/roguetown/bloodraider
	name = "Raiders gauntlets"
	desc = "A pair of alloyed gauntlets. Each finger is afforded a trinity of segments; with it, one can use a quill as precisely as an arming sword."
	icon_state = "bloodgauntlets"
	item_state = "bloodgauntlets"
	armor = ARMOR_PLATE
	resistance_flags = FIRE_PROOF
	blocksound = PLATEHIT
	max_integrity = ARMOR_INT_SIDE_STEEL
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	pickup_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	desc = "This brigandine is an example of the painstaking work of a skilled, and very poor, craftsman. The gambenison, lined with metal parts and scraps of chain mail, is impossible to ruin even with such 'artistry'."
	icon = 'modular_twilight_axis/icons/clothing/bloodraider.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'

/obj/item/clothing/wrists/roguetown
	slot_flags = ITEM_SLOT_WRISTS
	sleeved = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'
	icon = 'modular_twilight_axis/icons/clothing/bloodraider.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'
	sleevetype = "shirt"
	resistance_flags = FLAMMABLE
	sewrepair = TRUE
	anvilrepair = null
	experimental_inhand = TRUE
	grid_width = 32
	grid_height = 64
	equip_delay_self = 2.5 SECONDS
	unequip_delay_self = 2.5 SECONDS

/obj/item/clothing/wrists/roguetown/MiddleClick(mob/user, params)
	. = ..()
	overarmor = !overarmor
	to_chat(user, span_info("I [overarmor ? "wear \the [src] over my armor" : "wear \the [src] under my armor"]."))
	if(overarmor)
		alternate_worn_layer = WRISTS_LAYER
	else
		alternate_worn_layer = UNDER_ARMOR_LAYER
	user.update_inv_wrists()
	user.update_inv_gloves()
	user.update_inv_armor()
	user.update_inv_shirt()

/obj/item/clothing/wrists/roguetown/bracers/bloodraider
	name = "bloodbracers"
	desc = "A pair of steel vambraces, protecting the arms from blows-most-foul."
	body_parts_covered = ARMS
	icon_state = "bloodbracers"
	item_state = "bloodbracers"
	armor = ARMOR_PLATE
	blocksound = PLATEHIT
	resistance_flags = FIRE_PROOF
	max_integrity = ARMOR_INT_SIDE_STEEL
	pickup_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/steel

/obj/item/clothing/wrists/roguetown/bracers/bloodraider/get_mechanics_examine(mob/user)
	. = ..()
	. += span_notice("Allows unarmed parrying. Takes integrity damage when parrying. Expert Pugilists parry far more effectively with these.")
	. += span_notice("Unarmed attacks are swift-balanced: faster attackers are harder to parry and dodge.")

/obj/item/clothing/wrists/roguetown/bracers/bloodraider/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/negative, TRAIT_FENCERDEXTERITY)
	AddComponent(/datum/component/armour_filtering/negative, TRAIT_HONORBOUND)

/obj/item/clothing/under/roguetown/bloodsplintlegs
	name = "Raiders splintlegs"
	desc = "Splint mail and brigandine chausses, designed to protect the legs while still providing almost complete free range of movement."
	icon_state = "bloodsplintlegs"
	item_state = "bloodsplintlegs"
	max_integrity = ARMOR_INT_LEG_BRIGANDINE
	armor = ARMOR_BRIGANDINE
	blocksound = SOFTHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	pickup_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	equip_sound = 'sound/foley/equip/equip_armor_chain.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	resistance_flags = FIRE_PROOF
	armor_class = ARMOR_CLASS_LIGHT
	w_class = WEIGHT_CLASS_NORMAL
	//resistance_flags = FIRE_PROOF // these ones should be burning since is cloth + metal
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/steel
	icon = 'modular_twilight_axis/icons/clothing/bloodraider.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'

/obj/item/clothing/under/roguetown/bloodsplintlegs/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_COAT_STEP, 10)
	AddComponent(/datum/component/armour_filtering/negative, TRAIT_FENCERDEXTERITY)

/obj/item/clothing/shoes/roguetown/boots/bloodboots
	name = "Raiders boots"
	desc = "Custom-fitted sabatons, made from a series of interlinking steel plates. The only weakness it has, beyond its inaffordability \
	amongst those of ignobility, is its inability to properly stand firm across softer surfaces. There's a very good reason as to why \
	you'd rarely see a knight treading the Terrorbog's muddied paths, after all."
	body_parts_covered = FEET
	icon_state = "bloodboots"
	item_state = "bloodboots"
	color = null
	blocksound = PLATEHIT
	resistance_flags = FIRE_PROOF
	max_integrity = ARMOR_INT_SIDE_STEEL
	armor = ARMOR_PLATE
	pickup_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/steel
	sewrepair = FALSE
	icon = 'modular_twilight_axis/icons/clothing/bloodraider.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'

/obj/item/clothing/shoes/roguetown/boots/bloodboots/armor/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/negative, TRAIT_FENCERDEXTERITY)
	AddComponent(/datum/component/armour_filtering/negative, TRAIT_HONORBOUND)

/obj/item/clothing/suit/roguetown/shirt/bloodraider
	name = "Raider gambezon"
	desc = "A strong loosely worn quilted shirt that places little weight on the arms, usually worn underneath a flexible leather vest. It won't cover your legs."
	icon = 'modular_twilight_axis/icons/clothing/bloodraider.dmi'
	mob_overlay_icon = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'
	sleeved = 'modular_twilight_axis/icons/clothing/onmob/bloodraider.dmi'
	body_parts_covered = COVERAGE_ALL_BUT_HANDFEET
	icon_state = "bloodgambenzon"
	color = "#FFFFFF"
	var/shiftable = FALSE
	armor = ARMOR_PADDED
	max_integrity = ARMOR_INT_CHEST_LIGHT_MASTER + 150
	blocksound = SOFTUNDERHIT
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	cold_protection = 10

/obj/item/clothing/suit/roguetown/shirt/bloodraider/ComponentInitialize()
	AddComponent(/datum/component/armour_filtering/positive, TRAIT_FENCERDEXTERITY)
	AddComponent(/datum/component/armour_filtering/negative, TRAIT_HONORBOUND)

/datum/advclass/wretch/twilight_blood_raider
	name = "Blood Raider"
	tutorial = "Having obtained the weapon through honest or not-so-honest means, you carry the consequences of your actions across the surface of Grimoria, showcasing the true might of drow craftsmanship"
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/wretch/twilight_blood_raider
	category_tags = list(CTAG_WRETCH)
	class_select_category = CLASS_CAT_RANGER
	traits_applied = list(TRAIT_FIREARMS_MARKSMAN, TRAIT_DODGEEXPERT, TRAIT_ARCYNE)
	maximum_possible_slots = 1

	cmode_music = 'modular_twilight_axis/firearms/sound/music/combat_corsair.ogg'
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_SPD = 2,
		STATKEY_PER = 2,
		STATKEY_INT = 2
	)
	subclass_mage_aspects = list("mastery" = FALSE, "major" = 0, "minor" = 1, "utilities" = 4)
	subclass_skills = list(
		/datum/skill/combat/twilight_firearms = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/staves = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/magic/arcane = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/tracking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/wretch/twilight_blood_raider/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/crimes = list("I'm nobody", "They fear me")
	var/crimeschoice = input(H, "Who is me", "How much have I done?") as anything in crimes
	if(istype(H.dna.species, /datum/species/elf/dark))
		H.set_blindness(0)
		wrists = /obj/item/clothing/wrists/roguetown/bracers/bloodraider
		belt = /obj/item/storage/belt/rogue/leather/double
		beltl = /obj/item/quiver/twilight_bullet/lead
		beltr = /obj/item/rogueweapon/scabbard/sword
		backl = /obj/item/storage/backpack/rogue/satchel/black
		neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle/bloodraider
		shirt = /obj/item/clothing/suit/roguetown/shirt/bloodraider
		head = /obj/item/clothing/head/roguetown/helmet/bloodhelmet
		armor = /obj/item/clothing/suit/roguetown/armor/plate/cuirass/bloodraider
		pants = /obj/item/clothing/under/roguetown/bloodsplintlegs
		shoes = /obj/item/clothing/shoes/roguetown/boots/bloodboots
		gloves = /obj/item/clothing/gloves/roguetown/bloodraider
		r_hand = /obj/item/rogueweapon/sword/sabre/stalker
		l_hand = /obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/stalker = 1, /obj/item/rope/chain = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/chalk = 1, /obj/item/rogueweapon/spellbook = 1)
		H.grant_language(/datum/language/undead)
		H.mind.AddSpell(new /datum/action/cooldown/spell/recall_weapon)
		H.mind.AddSpell(new /datum/action/cooldown/spell/bind_weapon)
		switch(crimeschoice)
			if("I'm nobody")
				H.change_stat(STATKEY_PER, -1)
				H.change_stat(STATKEY_SPD, -1)
				to_chat(H, span_warning("Моя прошлая жизнь не даёт мне покоя по ночам. Кошмары заставляют меня оглядываться назад чаще..."))
			if("They fear me")
				wretch_select_bounty(H)
				ADD_TRAIT(H, TRAIT_ANTHRAXI, TRAIT_DARKVISION)
				H.change_stat(STATKEY_SPD, 1)
				H.change_stat(STATKEY_PER, 1)
				to_chat(H, span_warning("Они боятся меня. Моя ловкость и зоркость не подводили ни разу на рейдах мерзких Н'вах"))
	else
		H.set_blindness(0)
		H.set_patron(/datum/patron/inhumen/zizo)
		wrists = /obj/item/clothing/wrists/roguetown/bracers/iron
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/quiver/twilight_bullet/lead
		beltr = /obj/item/rogueweapon/scabbard/sword
		backl = /obj/item/storage/backpack/rogue/satchel
		neck = /obj/item/clothing/neck/roguetown/chaincoif/chainmantle
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/black
		head = /obj/item/clothing/head/roguetown/helmet/heavy/volfplate
		armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light/handmade
		pants = /obj/item/clothing/under/roguetown/brigandinelegs
		shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
		gloves = /obj/item/clothing/gloves/roguetown/plate
		r_hand = /obj/item/rogueweapon/sword/sabre
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/twilight_bloodlock
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1, /obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/rope/chain = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/chalk = 1, /obj/item/rogueweapon/spellbook = 1)
		H.mind.AddSpell(new /datum/action/cooldown/spell/recall_weapon)
		H.mind.AddSpell(new /datum/action/cooldown/spell/bind_weapon)
		switch(crimeschoice)
			if("I'm nobody")
				H.change_stat(STATKEY_WIL, -1)
				H.change_stat(STATKEY_SPD, -1)
				H.change_stat(STATKEY_PER, -1)
				to_chat(H, span_warning("Антракси идут по мою душу, я не могу быть уверенным в завтрашнем дне..."))
			if("They fear me")
				wretch_select_bounty(H)
				H.change_stat(STATKEY_WIL, 1)
				H.change_stat(STATKEY_CON, 1)
				to_chat(H, span_warning("Приспособившись к новому оружию, мне стало легче избегать охотников за головой"))
