/*
 * Backpack
 */

/obj/item/storage/backpack
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	icon_state = "backpack"
	w_class = 4
	flags_equip_slot = SLOT_BACK	//ERROOOOO
	max_w_class = 3
	storage_slots = null
	max_storage_space = 21
	var/worn_accessible = FALSE //whether you can access its content while worn on the back

/obj/item/storage/backpack/attack_hand(mob/user)
	if(!worn_accessible && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.back == src)
/*			if(user.drop_inv_item_on_ground(src))
				pickup(user)
				add_fingerprint(user)
				if(!user.put_in_active_hand(src))
					dropped(user)
*/
			to_chat(H, SPAN_NOTICE("You can't look in [src] while it's on your back."))
			return
	..()

/obj/item/storage/backpack/attackby(obj/item/W, mob/user)
/*	if(!worn_accessible && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.back == src)
			to_chat(H, SPAN_NOTICE("You can't access [src] while it's on your back."))
			return TRUE
*/
	if (use_sound)
		playsound(src.loc, src.use_sound, 15, 1, 6)
	..()

/obj/item/storage/backpack/mob_can_equip(M as mob, slot)
	if (!..())
		return 0

	if (!uniform_restricted)
		return 1

	if (!ishuman(M))
		return 0

	var/mob/living/carbon/human/H = M
	var/list/equipment = list(H.wear_suit, H.w_uniform, H.shoes, H.belt, H.gloves, H.glasses, H.head, H.wear_ear, H.wear_id, H.r_store, H.l_store, H.s_store)

	for (var/type in uniform_restricted)
		if (!(locate(type) in equipment))
			to_chat(H, "<span class='warning'>You must be wearing [initial(type:name)] to equip [name]!")
			return 0
	return 1

/obj/item/storage/backpack/equipped(mob/user, slot)
	if(slot == WEAR_BACK)
		mouse_opacity = 2 //so it's easier to click when properly equipped.
		if(use_sound)
			playsound(loc, use_sound, 15, 1, 6)
		if(!worn_accessible && user.s_active == src) //currently looking into the backpack
			close(user)
	..()

/obj/item/storage/backpack/dropped(mob/user)
	mouse_opacity = initial(mouse_opacity)
	..()


/obj/item/storage/backpack/open(mob/user)
	if(!worn_accessible && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.back == src)
			to_chat(H, SPAN_NOTICE("You can't access [src] while it's on your back."))
			return
	..()

/*
 * Backpack Types
 */

/obj/item/storage/backpack/holding
	name = "bag of holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	origin_tech = "bluespace=4"
	icon_state = "holdingpack"
	max_w_class = 4
	max_storage_space = 28

	attackby(obj/item/W as obj, mob/user as mob)
		if(crit_fail)
			to_chat(user, "<span class='danger'>The Bluespace generator isn't working.</span>")
			return
		if(istype(W, /obj/item/storage/backpack/holding) && !W.crit_fail)
			to_chat(user, "<span class='danger'>The Bluespace interfaces of the two devices conflict and malfunction.</span>")
			qdel(W)
			return
		..()

	proc/failcheck(mob/user as mob)
		if (prob(src.reliability)) return 1 //No failure
		if (prob(src.reliability))
			to_chat(user, "<span class='danger'>The Bluespace portal resists your attempt to add another item.</span>") //light failure
		else
			to_chat(user, "<span class='danger'>The Bluespace generator malfunctions!</span>")
			for (var/obj/O in src.contents) //it broke, delete what was in it
				qdel(O)
			crit_fail = 1
			icon_state = "brokenpack"


//==========================//JOKE PACKS\\================================\\

/obj/item/storage/backpack/santabag
	name = "Santa's Gift Bag"
	desc = "Space Santa uses this to deliver toys to all the nice children in space in Christmas! Wow, it's pretty big!"
	icon_state = "giftbag0"
	item_state = "giftbag"
	w_class = 4.0
	storage_slots = null
	max_w_class = 3
	max_storage_space = 400 // can store a ton of shit!


/obj/item/storage/backpack/cultpack
	name = "trophy rack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity."
	icon_state = "cultpack"

/obj/item/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "This, this thing. It fills you with the dread of a bygone age. A land of grey coveralls and mentally unstable crewmen. Of traitors and hooligans. Thank god you're in the marines now."
	icon_state = "clownpack"

//==========================//COLONY/CIVILIAN PACKS\\================================\\

/obj/item/storage/backpack/medic
	name = "medical backpack"
	desc = "It's a backpack especially designed for use in a sterile environment."
	icon_state = "medicalpack"

/obj/item/storage/backpack/security //Universal between USCM MPs & Colony, should be split at some point.
	name = "security backpack"
	desc = "It's a very robust backpack."
	icon_state = "securitypack"

/obj/item/storage/backpack/industrial
	name = "industrial backpack"
	desc = "It's a tough backpack lookin' backpack used by engineers and the like."
	icon_state = "engiepack"

/obj/item/storage/backpack/toxins
	name = "laboratory backpack"
	desc = "It's a light backpack modeled for use in laboratories and other scientific institutions."
	icon_state = "toxpack"

/obj/item/storage/backpack/hydroponics
	name = "herbalist's backpack"
	desc = "It's a green backpack with many pockets to store plants and tools in."
	icon_state = "hydpack"

/obj/item/storage/backpack/genetics
	name = "geneticist backpack"
	desc = "It's a backpack fitted with slots for diskettes and other workplace tools."
	icon_state = "genpack"

/obj/item/storage/backpack/virology
	name = "sterile backpack"
	desc = "It's a sterile backpack able to withstand different pathogens from entering its fabric."
	icon_state = "viropack"

/obj/item/storage/backpack/chemistry
	name = "chemistry backpack"
	desc = "It's an orange backpack which was designed to hold beakers, pill bottles and bottles."
	icon_state = "chempack"

/*
 * Satchel Types
 */

/obj/item/storage/backpack/satchel
	name = "leather satchel"
	desc = "A very fancy satchel made of fine leather. Looks pretty pricey."
	icon_state = "satchel"
	worn_accessible = TRUE
	storage_slots = null
	max_storage_space = 15

/obj/item/storage/backpack/satchel/withwallet
	New()
		..()
		new /obj/item/storage/wallet/random( src )

/obj/item/storage/backpack/satchel/norm
	name = "satchel"
	desc = "A trendy looking satchel."
	icon_state = "satchel-norm"

/obj/item/storage/backpack/satchel/eng
	name = "industrial satchel"
	desc = "A tough satchel with extra pockets."
	icon_state = "satchel-eng"

/obj/item/storage/backpack/satchel/med
	name = "medical satchel"
	desc = "A sterile satchel used in medical departments."
	icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/vir
	name = "virologist satchel"
	desc = "A sterile satchel with virologist colours."
	icon_state = "satchel-vir"

/obj/item/storage/backpack/satchel/chem
	name = "chemist satchel"
	desc = "A sterile satchel with chemist colours."
	icon_state = "satchel-chem"

/obj/item/storage/backpack/satchel/gen
	name = "geneticist satchel"
	desc = "A sterile satchel with geneticist colours."
	icon_state = "satchel-gen"

/obj/item/storage/backpack/satchel/tox
	name = "scientist satchel"
	desc = "Useful for holding research materials."
	icon_state = "satchel-tox"

/obj/item/storage/backpack/satchel/sec //Universal between USCM MPs & Colony, should be split at some point.
	name = "security satchel"
	desc = "A robust satchel composed of two drop pouches, and a large internal pocket. Made of a stiff fabric. It isn't very comfy to wear."
	icon_state = "satchel-sec"

/obj/item/storage/backpack/satchel/hyd
	name = "hydroponics satchel"
	desc = "A green satchel for plant related work."
	icon_state = "satchel_hyd"

//==========================// MARINE BACKPACKS\\================================\\
//=======================================================================\\

/obj/item/storage/backpack/marine
	name = "\improper lightweight IMP backpack"
	desc = "The standard-issue pack of the USCM forces. Designed to lug gear into the battlefield."
	icon_state = "marinepack"
	var/has_gamemode_skin = TRUE

	New()
		if(has_gamemode_skin)
			select_gamemode_skin(type)
		..()

/obj/item/storage/backpack/marine/medic
	name = "\improper USCM medic backpack"
	desc = "A standard-issue backpack worn by USCM medics."
	icon_state = "marinepack_medic"

/obj/item/storage/backpack/marine/tech
	name = "\improper USCM technician backpack"
	desc = "A standard-issue backpack worn by USCM technicians."
	icon_state = "marinepack_techi"

/obj/item/storage/backpack/marine/satchel
	name = "\improper USCM satchel"
	desc = "A heavy-duty satchel carried by some USCM soldiers and support personnel."
	icon_state = "marinesatch"
	worn_accessible = TRUE
	storage_slots = null
	max_storage_space = 15


/obj/item/storage/backpack/marine/satchel/medic
	name = "\improper USCM medic satchel"
	desc = "A heavy-duty satchel used by USCM medics. It sacrifices capacity for usability. A small patch is sown to the top flap."
	icon_state = "marinesatch_medic"

/obj/item/storage/backpack/marine/satchel/tech
	name = "\improper USCM technician chestrig"
	desc = "A heavy-duty chestrig used by some USCM technicians."
	icon_state = "marinesatch_techi"

/obj/item/storage/backpack/marine/satchel/intel
	name = "\improper USCM intelligence officer pack"
	desc = "A heavy-duty backpack that slings around easily, and can quickly be accessed with only one hand. Issued only to USCM Intelligence Officers."
	icon_state = "marinesatch_io"
	max_storage_space = 20

/obj/item/storage/backpack/marine/smock
	name = "\improper M3 sniper's smock"
	desc = "A specially designed smock with pockets for all your sniper needs."
	icon_state = "smock"
	worn_accessible = TRUE

/obj/item/storage/backpack/marine/rocketpack
	name = "\improper M22 rocket bags"
	desc = "Specially designed bags made to hold rockets."
	icon_state = "rocketpack"
	worn_accessible = TRUE

#define SCOUT_CLOAK_COOLDOWN 100
#define SCOUT_CLOAK_TIMER 50
// Scout Cloak
/obj/item/storage/backpack/marine/satchel/scout_cloak
	name = "\improper M68 Thermal Cloak"
	desc = "The lightweight thermal dampeners and optical camouflage provided by this cloak are weaker than those found in standard USCM ghillie suits. In exchange, the cloak can be worn over combat armor and offers the wearer high manueverability and adaptability to many environments."
	icon_state = "scout_cloak"
	uniform_restricted = list(/obj/item/clothing/suit/storage/marine/M3S, /obj/item/clothing/head/helmet/marine/scout) //Need to wear Scout armor and helmet to equip this.
	has_gamemode_skin = FALSE //same sprite for all gamemode.
	var/camo_active = 0
	var/camo_active_timer = 0
	var/camo_cooldown_timer = 0
	var/camo_ready = 1
	actions_types = list(/datum/action/item_action)


/obj/item/storage/backpack/marine/satchel/scout_cloak/attack_self(mob/user)
	camouflage()

/obj/item/storage/backpack/marine/satchel/scout_cloak/verb/camouflage()
	set name = "Toggle M68 Thermal Camouflage"
	set desc = "Activate your cloak's camouflage."
	set category = "Scout"

	if (!usr || usr.is_mob_incapacitated(TRUE))
		return

	var/mob/living/carbon/human/M = usr
	if (!istype(M))
		return

	if(M.species.name == "Zombie")
		return

	if (M.back != src)
		to_chat(M, "<span class='warning'>You must be wearing the cloak to activate it!")
		return

	if (camo_active)
		camo_off(usr)
		return

	if (!camo_ready)
		to_chat(M, "<span class='warning'>Your thermal dampeners are still recharging!")
		return

	camo_ready = 0
	camo_active = 1
	to_chat(M, SPAN_NOTICE("You activate your cloak's camouflage."))

	for (var/mob/O in oviewers(M))
		O.show_message("[M] vanishes into thin air!", 1)
	playsound(M.loc,'sound/effects/cloak_scout_on.ogg', 15, 1)

	M.alpha = 10

	var/datum/mob_hud/security/advanced/SA = huds[MOB_HUD_SECURITY_ADVANCED]
	SA.remove_from_hud(M)
	var/datum/mob_hud/xeno_infection/XI = huds[MOB_HUD_XENO_INFECTION]
	XI.remove_from_hud(M)

	spawn(1)
		anim(M.loc,M,'icons/mob/mob.dmi',,"cloak",,M.dir)

	camo_active_timer = world.timeofday + SCOUT_CLOAK_TIMER
	process_active_camo(usr)
	return 1

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/camo_off(var/mob/user)
	if (!user)
		return 0

	to_chat(user, "<span class='warning'>Your cloak's camouflage has deactivated!</span>")
	camo_active = 0

	for (var/mob/O in oviewers(user))
		O.show_message("[user.name] shimmers into existence!",1)
	playsound(user.loc,'sound/effects/cloak_scout_off.ogg', 15, 1)
	user.alpha = initial(user.alpha)

	var/datum/mob_hud/security/advanced/SA = huds[MOB_HUD_SECURITY_ADVANCED]
	SA.add_to_hud(user)
	var/datum/mob_hud/xeno_infection/XI = huds[MOB_HUD_XENO_INFECTION]
	XI.add_to_hud(user)

	spawn(1)
		anim(user.loc,user,'icons/mob/mob.dmi',,"uncloak",,user.dir)

	camo_cooldown_timer = world.timeofday + SCOUT_CLOAK_COOLDOWN
	process_camo_cooldown(user)

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/process_camo_cooldown(var/mob/user)
	set background = 1

	spawn while (!camo_ready && !camo_active)
		if (world.timeofday > camo_cooldown_timer)
			to_chat(user, "<span class='notice'>Your cloak's thermal dampeners have recharged!")
			camo_ready = 1

		sleep(10)	// Process every second.

/obj/item/storage/backpack/marine/satchel/scout_cloak/proc/process_active_camo(var/mob/user)
	set background = 1

	spawn while (camo_active)
		if (world.timeofday > camo_active_timer)
			camo_active = 0
			camo_off(user)

		sleep(10)	// Process every second.



// Welder Backpacks //

/obj/item/storage/backpack/marine/engineerpack
	name = "\improper USCM technician welderpack"
	desc = "A specialized backpack worn by USCM technicians. It carries a fueltank for quick welder refueling and use,"
	icon_state = "welderbackpack"
	var/max_fuel = 260
	max_storage_space = 15
	storage_slots = null
	has_gamemode_skin = TRUE

/obj/item/storage/backpack/marine/engineerpack/New()
	var/datum/reagents/R = new/datum/reagents(max_fuel) //Lotsa refills
	reagents = R
	R.my_atom = src
	R.add_reagent("fuel", max_fuel)
	..()


/obj/item/storage/backpack/marine/engineerpack/attackby(obj/item/W, mob/living/user)
	if(reagents.total_volume)
		if(istype(W, /obj/item/tool/weldingtool))
			var/obj/item/tool/weldingtool/T = W
			if(T.welding)
				to_chat(user, "<span class='warning'>That was close! However you realized you had the welder on and prevented disaster.</span>")
				return
			if(!(T.get_fuel()==T.max_fuel) && reagents.total_volume)
				reagents.trans_to(W, T.max_fuel)
				to_chat(user, SPAN_NOTICE("Welder refilled!"))
				playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
				return
		else if(istype(W, /obj/item/ammo_magazine/flamer_tank))
			var/obj/item/ammo_magazine/flamer_tank/FT = W
			if(!FT.current_rounds && reagents.total_volume)
				var/fuel_available = reagents.total_volume < FT.max_rounds ? reagents.total_volume : FT.max_rounds
				reagents.remove_reagent("fuel", fuel_available)
				FT.current_rounds = fuel_available
				playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
				FT.caliber = "Fuel"
				to_chat(user, SPAN_NOTICE("You refill [FT] with [lowertext(FT.caliber)]."))
				FT.update_icon()
				return
		else if(istype(W, /obj/item/weapon/gun))
			var/obj/item/weapon/gun/G = W
			if(G.under && istype(G.under, /obj/item/attachable/attached_gun/flamer))
				var/obj/item/attachable/attached_gun/flamer/F = G.under
				if(F.current_rounds < F.max_rounds)
					var/to_transfer = F.max_rounds - F.current_rounds
					if(to_transfer > reagents.total_volume)
						to_transfer = reagents.total_volume
					reagents.remove_reagent("fuel", to_transfer)
					F.current_rounds += to_transfer
					playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
					to_chat(user, SPAN_NOTICE("You refill [F] with Fuel."))
				else
					to_chat(user, "<span class='warning'>[F] is full.</span>")
			else
				to_chat(user, "<span class='warning'>Nothing to refill.</span>")
	. = ..()

/obj/item/storage/backpack/marine/engineerpack/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity) // this replaces and improves the get_dist(src,O) <= 1 checks used previously
		return
	if (istype(O, /obj/structure/reagent_dispensers/fueltank) && src.reagents.total_volume < max_fuel)
		O.reagents.trans_to(src, max_fuel)
		to_chat(user, SPAN_NOTICE(" You crack the cap off the top of the pack and fill it back up again from the tank."))
		playsound(src.loc, 'sound/effects/refill.ogg', 25, 1, 3)
		return
	else if (istype(O, /obj/structure/reagent_dispensers/fueltank) && src.reagents.total_volume == max_fuel)
		to_chat(user, SPAN_NOTICE(" The pack is already full!"))
		return
	..()

/obj/item/storage/backpack/marine/engineerpack/examine(mob/user)
	..()
	to_chat(user, "[reagents.total_volume] units of fuel left!")

// Pyrotechnician Spec backpack fuel tank
/obj/item/storage/backpack/marine/engineerpack/flamethrower
	name = "\improper USCM Pyrotechnician fueltank"
	desc = "A specialized fueltank worn by USCM Pyrotechnicians for use with the M240-T incinerator unit. A small general storage compartment is installed."
	icon_state = "flamethrower_tank"
	max_fuel = 500
	has_gamemode_skin = TRUE

/obj/item/storage/backpack/marine/engineerpack/flamethrower/attackby(obj/item/W, mob/living/user)
	if (istype(W, /obj/item/ammo_magazine/flamer_tank))
		var/obj/item/ammo_magazine/flamer_tank/FTL = W
		var/missing_volume = FTL.max_rounds - FTL.current_rounds

		//Fuel has to be standard napalm OR tank needs to be empty. We need to have a non-full tank and our backpack be dry
		if (((FTL.caliber == "UT-Napthal Fuel") || (!FTL.current_rounds)) && missing_volume && reagents.total_volume)
			var/fuel_available = reagents.total_volume < missing_volume ? reagents.total_volume : missing_volume
			reagents.remove_reagent("fuel", fuel_available)
			FTL.current_rounds = FTL.current_rounds + fuel_available
			playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
			FTL.caliber = "UT-Napthal Fuel"
			to_chat(user, SPAN_NOTICE("You refill [FTL] with [FTL.caliber]."))
			FTL.update_icon()
	. = ..()

/obj/item/storage/backpack/lightpack
	name = "\improper lightweight combat pack"
	desc = "A small lightweight pack for expeditions and short-range operations."
	icon_state = "ERT_satchel"
	worn_accessible = TRUE

/obj/item/storage/backpack/commando
	name = "commando bag"
	desc = "A heavy-duty bag carried by Weyland Yutani commandos."
	icon_state = "commandopack"
	storage_slots = null
	max_storage_space = 30

/obj/item/storage/backpack/mcommander
	name = "marine commanding officer backpack"
	desc = "The contents of this backpack are top secret."
	icon_state = "marinepack"
	storage_slots = null
	max_storage_space = 30

/obj/item/storage/backpack/ivan
	name = "The Armory"
	desc = "From the formless void, there springs an entity - More primordial than the elements themselves. In it's wake, there will follow a storm."
	icon_state = "ivan_bag"
	storage_slots = null
	max_storage_space = 30
