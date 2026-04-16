/datum/advclass/arbalist
	name = "Arbalist"
	tutorial = "They'd pulled you from the line. To be a Confessor was your fate. Now? You're one of the Inquisitor's sharpest, of eye and steady hand alike. \
	Armed with your beloved sauterelle, you'll drive back the dark. One stake at a time."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/arbalist
	category_tags = list(CTAG_ORTHODOXIST)
	subclass_languages = list(/datum/language/otavan)
	traits_applied = list(
		TRAIT_PERFECT_TRACKER,
	)
	subclass_stats = list(
		STATKEY_PER = 3,
		STATKEY_STR = 2,
		STATKEY_WIL = 2,
		STATKEY_CON = 1,
	)
	subclass_skills = list(
		/datum/skill/combat/crossbows = SKILL_LEVEL_MASTER,
		/datum/skill/misc/tracking = SKILL_LEVEL_MASTER,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE, // TA EDIT
		/datum/skill/craft/tanning = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/labor/butchering = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_NOVICE,
        /datum/skill/misc/sneaking = SKILL_LEVEL_EXPERT,
        /datum/skill/misc/lockpicking = SKILL_LEVEL_EXPERT,
	)
	subclass_stashed_items = list(
		"Tome of Psydon" = /obj/item/book/rogue/bibble/psy
	)

/datum/outfit/job/roguetown/arbalist
	job_bitflag = BITFLAG_HOLY_WARRIOR

/datum/outfit/job/roguetown/arbalist/pre_equip(mob/living/carbon/human/H, visualsOnly)
    ..()
    if(H.mind)
        H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/psydonic_lux_bolt)

    head = /obj/item/clothing/head/roguetown/headband/bloodied
    armor = /obj/item/clothing/suit/roguetown/armor/plate/cuirass/fencer/psydon
    shirt = /obj/item/clothing/suit/roguetown/armor/manual/sewable/confessor
    cloak = /obj/item/storage/backpack/rogue/satchel/beltpack
    wrists = /obj/item/clothing/neck/roguetown/psicross/silver
    gloves = /obj/item/clothing/gloves/roguetown/otavan/psygloves
    neck = /obj/item/clothing/neck/roguetown/gorget
    backr = /obj/item/storage/backpack/rogue/satchel/otavan
    belt = /obj/item/storage/belt/rogue/leather/knifebelt/stakebelt
    beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
    beltl = /obj/item/rogueweapon/huntingknife/idagger/silver/stake/psy
    pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
    shoes = /obj/item/clothing/shoes/roguetown/boots/psydonboots
    mask = /obj/item/clothing/mask/rogue/facemask/steel/confessor
    id = /obj/item/clothing/ring/signet/psy
    backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow/arbalest
    backpack_contents = list(
        /obj/item/roguekey/inquisitionmanor = 1,
        /obj/item/rope/inqarticles/inquirycord = 1,
        /obj/item/lockpickring/mundane = 1,
        /obj/item/grapplinghook = 1,
        /obj/item/paper/inqslip/arrival/ortho = 1,
        /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger = 1,
        /obj/item/rogueweapon/scabbard/sheath = 1
        )

    var/datum/devotion/C = new /datum/devotion(H, H.patron)
    C.grant_miracles(H, cleric_tier = CLERIC_T2, passive_gain = CLERIC_REGEN_WEAK, devotion_limit = CLERIC_REQ_1)
