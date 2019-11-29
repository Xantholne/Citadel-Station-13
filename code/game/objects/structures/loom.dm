#define FABRIC_PER_SHEET 4


///This is a loom. It's usually made out of wood and used to weave fabric like durathread or cotton into their respective cloth types.
/obj/structure/loom
	name = "loom"
	desc = "A simple device used to weave cloth and other thread-based fabrics together into usable material."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "loom"
	density = TRUE
	anchored = TRUE

/obj/structure/loom/attackby(obj/item/I, mob/user)
	if(weave(I, user))
		return
	return ..()

/obj/structure/loom/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I, 5)
	return TRUE

///Handles the weaving.
/obj/structure/loom/proc/weave(obj/item/stack/I, mob/user)
	if(!istype(I))
		return FALSE
	if(!anchored)
		user.show_message("<span class='notice'>The loom needs to be wrenched down.</span>", 1)
		return FALSE
	if(I.amount < FABRIC_PER_SHEET)
		user.show_message("<span class='notice'>You need at least [FABRIC_PER_SHEET] units of fabric before using this.</span>", 1)
		return FALSE
	user.show_message("<span class='notice'>You start weaving \the [I.name] through the loom..</span>", 1)
	if(I.use_tool(src, user, I.pull_effort))
		if(I.amount >= FABRIC_PER_SHEET)
			new I.loom_result(drop_location())
			I.use(FABRIC_PER_SHEET)
			user.show_message("<span class='notice'>You weave \the [I.name] into a workable fabric.</span>", 1)
	return TRUE

/obj/structure/loom/unanchored
	anchored = FALSE

#undef FABRIC_PER_SHEET
