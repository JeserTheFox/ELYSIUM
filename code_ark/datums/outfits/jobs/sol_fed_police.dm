/decl/hierarchy/outfit/job/security
	hierarchy_type = /decl/hierarchy/outfit/job/security
	uniform = /obj/item/clothing/under/rank/security/ark
	suit = /obj/item/clothing/suit/storage/toggle/suit/sfp
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	l_ear = /obj/item/device/radio/headset/headset_sec
	gloves = /obj/item/clothing/gloves/sfp
	shoes = /obj/item/clothing/shoes/jackboots/sfp
	backpack_contents = list(/obj/item/handcuffs = 1)

/decl/hierarchy/outfit/job/security/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/security/sfp_curator
	name = OUTFIT_JOB_NAME("SFP Curator")
	l_ear = /obj/item/device/radio/headset/heads/hos
	id_types = list(/obj/item/card/id/security/head)
	pda_type = /obj/item/modular_computer/pda/heads/hos
	backpack_contents = list(/obj/item/handcuffs = 1)

/decl/hierarchy/outfit/job/security/sfp_investigator
	name = OUTFIT_JOB_NAME("SFP Investigator")
	head = /obj/item/clothing/head/det
	l_pocket = /obj/item/flame/lighter/zippo
	r_hand = /obj/item/storage/briefcase/crimekit
	id_types = list(/obj/item/card/id/security/sfp_investigator)
	pda_type = /obj/item/modular_computer/pda/forensics
	backpack_contents = list(/obj/item/storage/box/evidence = 1)

/decl/hierarchy/outfit/job/security/sfp_investigator/New()
	..()
	backpack_overrides.Cut()

/decl/hierarchy/outfit/job/security/sfp_agent
	name = OUTFIT_JOB_NAME("SFP Response Agent")
	l_pocket = /obj/item/device/flash
	r_pocket = /obj/item/handcuffs
	id_types = list(/obj/item/card/id/security)
	pda_type = /obj/item/modular_computer/pda/security
