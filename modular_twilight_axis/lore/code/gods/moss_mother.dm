/datum/faith/mossmother
	preference_accessible = TRUE

/datum/virtue/utility/feytouched
	abstract_type = /datum/virtue/utility/feytouched // excludes from virtue selection

/datum/patron/mossmother
	name = "The Mossmother"
	translated_name = "Матерь Мха"
	domain = "Болота."
	desc = "Существо, обитающее в глубинах болот Гримории, по природе своей занимающее неопределённое место между смертными, духами и богами. Формально она не признана частью ни одного пантеона, отвергнута Церковью Десяти как самозванка и еретическая аномалия, и всё же обладает подлинной – пусть и ущербной – крупицей божественности. Сама же Матерь Мха считает это признание незаслуженно ограниченным: боги, занимающие троны Порядка, отказываются признать её равной. Это не останется безнаказанным."
	worshippers = "Болотные ведьмы."
	confess_lines = list(
		"МАТЕРЬ МХА ВИДИТ ТЕБЯ!",
		"ТЫ ЗАПЛАТИШЬ СПОЛНА, ДОРОГУША!",
		"Ты настолько глубоко залез в задницу Псайдона, что не видишь оттуда истины, что перед глазами. Ты жалок.",
		"ВОЗМЕЗДИЕ ГРЯДЕТ.",
		"Я ЕСТЬ САМА ЗЕМЛЯ. ТЫ ДОЛЖЕН БЛАГОДАРИТЬ МЕНЯ ЗА ДОЗВОЛЕНИЕ СТУПАТЬ ПО НЕЙ.",
	)
	preference_accessible = TRUE
	mob_traits = list(
		TRAIT_BOGWALKER,
	)
	miracles = list(
		/datum/action/cooldown/spell/touch/orison = CLERIC_ORI,
		/*
		/obj/effect/proc_holder/spell/invoked/vampiric_drain/mossmother	= CLERIC_T1,
		/obj/effect/proc_holder/spell/invoked/watertrap = CLERIC_T2,
		/obj/effect/proc_holder/spell/self/wildshape/mossmother = CLERIC_T2,
		*/
	)
	symbol = "🌾"

/datum/patron/mossmother/post_equip(mob/living/pious)
	. = ..()

	if(pious.mind)
		pious.mind.special_items["Wyrd Cross"] = /obj/item/clothing/neck/roguetown/psicross/wyrd

	for(var/mob/living/hag_mob in GLOB.active_hags)
		var/datum/mind/hag_mind = hag_mob.mind

		if(!hag_mind)
			continue

		hag_mind.i_know_person(pious)
		pious.mind.i_know_person(hag_mind)

		if(hag_mind.current)
			to_chat(hag_mind.current, span_boldnotice("A familiar rhythm pulses in the roots... [pious.real_name] is walking the lands this week."))

	to_chat(pious, span_boldnotice("The Mossmother's gaze lingers upon you. You are recognized by her daughters."))
