#define WIRE		"wire"
#define WIRING		"wiring"
#define UNWIRE		"unwire"
#define UNWIRING	"unwiring"

/obj/item/device/integrated_electronics/wirer
	name = "circuit wirer"
	desc = "It's a small wiring tool, with a wire roll, electric soldering iron, wire cutter, and more in one package. \
	The wires used are generally useful for small electronics, such as circuitboards and breadboards, as opposed to larger wires \
	used for power or data transmission."
	icon = 'icons/obj/assemblies/electronic_tools.dmi'
	icon_state = "wirer-wire"
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	w_class = ITEM_SIZE_SMALL
	var/datum/integrated_io/selected_io = null
	var/mode = WIRE
	matter = list(MATERIAL_ALUMINIUM = 1500, MATERIAL_STEEL = 1000, MATERIAL_GLASS = 500, MATERIAL_PLASTIC = 500)

/obj/item/device/integrated_electronics/wirer/on_update_icon()
	icon_state = "wirer-[mode]"

/obj/item/device/integrated_electronics/wirer/proc/wire(var/datum/integrated_io/io, mob/user)
	if(!io.holder.assembly)
		to_chat(user, "<span class='warning'>\The [io.holder] needs to be secured inside an assembly first.</span>")
		return
	switch(mode)
		if(WIRE)
			select_io(io)
			to_chat(user, "<span class='notice'>You attach a data wire to \the [selected_io.holder]'s [selected_io.name] data channel.</span>")
			update_icon()

		if(WIRING)
			if(!selected_io)
				mode = WIRE
				.()
			if(io == selected_io)
				to_chat(user, "<span class='warning'>Wiring \the [selected_io.holder]'s [selected_io.name] into itself is rather pointless.</span>")
				return
			if(io.io_type != selected_io.io_type)
				to_chat(user, "<span class='warning'>Those two types of channels are incompatible.  The first is a [selected_io.io_type], \
				while the second is a [io.io_type].</span>")
				return
			if(io.holder.assembly && io.holder.assembly != selected_io.holder.assembly)
				to_chat(user, "<span class='warning'>Both \the [io.holder] and \the [selected_io.holder] need to be inside the same assembly.</span>")
				return
			selected_io.connect_pin(io)

			to_chat(user, "<span class='notice'>You connect \the [selected_io.holder]'s [selected_io.name] to \the [io.holder]'s [io.name].</span>")
			update_icon()
			selected_io.holder.interact(user) // This is to update the UI.
			unselect_io(selected_io)

		if(UNWIRE)
			if(!io.linked.len)
				to_chat(user, "<span class='warning'>There is nothing connected to \the [io] data channel.</span>")
				return
			select_io(io)
			to_chat(user, "<span class='notice'>You prepare to detach a data wire from \the [selected_io.holder]'s [selected_io.name] data channel.</span>")
			update_icon()

		if(UNWIRING)
			if(!selected_io)
				mode = UNWIRE
				.()
			if(io == selected_io)
				to_chat(user, "<span class='warning'>You can't wire a pin into each other, so unwiring \the [selected_io.holder] from \
				the same pin is rather moot.</span>")
				return
			if(selected_io in io.linked)
				selected_io.disconnect_pin(io)
				to_chat(user, "<span class='notice'>You disconnect \the [selected_io.holder]'s [selected_io.name] from \
				\the [io.holder]'s [io.name].</span>")
				selected_io.holder.interact(user) // This is to update the UI.
				unselect_io(selected_io)
				update_icon()
			else
				to_chat(user, "<span class='warning'>\The [selected_io.holder]'s [selected_io.name] and \the [io.holder]'s \
				[io.name] are not connected.</span>")

/obj/item/device/integrated_electronics/wirer/proc/select_io(datum/integrated_io/io)
	if(selected_io)
		unselect_io(selected_io)
	selected_io = io
	GLOB.destroyed_event.register(selected_io, src, PROC_REF(unselect_io))
	switch(mode)
		if(UNWIRE)
			mode = UNWIRING
		if(WIRE)
			mode = WIRING

/obj/item/device/integrated_electronics/wirer/proc/unselect_io(datum/integrated_io/io)
	if(selected_io != io)
		return
	GLOB.destroyed_event.unregister(selected_io, src)
	selected_io = null
	switch(mode)
		if(UNWIRING)
			mode = UNWIRE
		if(WIRING)
			mode = WIRE

/obj/item/device/integrated_electronics/wirer/attack_self(mob/user)
	switch(mode)
		if(WIRE)
			mode = UNWIRE
		if(WIRING)
			if(selected_io)
				unselect_io(selected_io)
				to_chat(user, "<span class='notice'>You decide not to wire the data channel.</span>")
		if(UNWIRE)
			mode = WIRE
		if(UNWIRING)
			if(selected_io)
				unselect_io(selected_io)
				to_chat(user, "<span class='notice'>You decide not to disconnect the data channel.</span>")
	update_icon()
	to_chat(user, "<span class='notice'>You set \the [src] to [mode].</span>")

#undef WIRE
#undef WIRING
#undef UNWIRE
#undef UNWIRING
