local FishData = {}

FishData.FISH_SPECIES = {} :: { [string]: string }
FishData.FISH_SPECIES.Angelfish = "Angelfish"
FishData.FISH_SPECIES.Arapaima = "Arapaima"
FishData.FISH_SPECIES.Arowana = "Arowana"
FishData.FISH_SPECIES.BarbelSteed = "Barbel Steed"
FishData.FISH_SPECIES.BarredKnifejaw = "Barred Knifejaw"
FishData.FISH_SPECIES.Bass = "Bass"
FishData.FISH_SPECIES.Bitterling = "Bitterling"
FishData.FISH_SPECIES.Bluegill = "Bluegill"
FishData.FISH_SPECIES.BrookTrout = "Brook Trout"
FishData.FISH_SPECIES.Carp = "Carp"
FishData.FISH_SPECIES.Catfish = "Catfish"
FishData.FISH_SPECIES.CherrySalmon = "Cherry Salmon"
FishData.FISH_SPECIES.Coelacanth = "Coelacanth"
FishData.FISH_SPECIES.Crawfish = "Crawfish"
FishData.FISH_SPECIES.CrucianCarp = "Crucian Carp"
FishData.FISH_SPECIES.Dace = "Dace"
FishData.FISH_SPECIES.Eel = "Eel"
FishData.FISH_SPECIES.FreshwaterGoby = "Freshwater Goby"
FishData.FISH_SPECIES.Frog = "Frog"
FishData.FISH_SPECIES.GiantCatfish = "Giant Catfish"
FishData.FISH_SPECIES.GiantSnakehead = "Giant Snakehead"
FishData.FISH_SPECIES.Goldfish = "Goldfish"
FishData.FISH_SPECIES.Guppy = "Guppy"
FishData.FISH_SPECIES.Jellyfish = "Jellyfish"
FishData.FISH_SPECIES.Killifish = "Killifish"
FishData.FISH_SPECIES.Koi = "Koi"
FishData.FISH_SPECIES.LargeBass = "Large Bass"
FishData.FISH_SPECIES.LargeChar = "Large Char"
FishData.FISH_SPECIES.Loach = "Loach"
FishData.FISH_SPECIES.PaleChub = "Pale Chub"
FishData.FISH_SPECIES.Piranha = "Piranha"
FishData.FISH_SPECIES.PondSmelt = "Pond Smelt"
FishData.FISH_SPECIES.PopeyedGoldfish = "Popeyed Goldfish"
FishData.FISH_SPECIES.RainbowTrout = "Rainbow Trout"
FishData.FISH_SPECIES.RedSnapper = "Red Snapper"
FishData.FISH_SPECIES.Salmon = "Salmon"
FishData.FISH_SPECIES.SeaBass = "Sea Bass"
FishData.FISH_SPECIES.SmallBass = "Small Bass"
FishData.FISH_SPECIES.Stringfish = "Stringfish"
FishData.FISH_SPECIES.Sweetfish = "Sweetfish"

FishData.FISH_VARIANT = {
	NORMAL = "Normal",
	ELEMENTAL = "Elemental",
	ELDER = "Elder",
}

FishData.REALM_ELEMENTS = {
	[1] = "Hydro",
	[2] = "Frostreed",
	[3] = "Cinder",
	[4] = "Mossy",
}

FishData.FISH_ASSETS = {} :: { [string]: string }
FishData.FISH_ASSETS.Angelfish = {
	Basic = "rbxassetid://83578364860938",
	Normal = {
		[1] = "rbxassetid://97335350830190",
		[2] = "rbxassetid://77484062357970",
		[3] = "rbxassetid://113299413920730",
		[4] = "rbxassetid://133671426615547",
		[5] = "rbxassetid://107928364606102",
		[6] = "rbxassetid://91532934907826",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://96007122170277",
			[2] = "rbxassetid://110544938582615",
			[3] = "rbxassetid://134817467929504",
			[4] = "rbxassetid://74237879830037",
			[5] = "rbxassetid://126750181875625",
			[6] = "rbxassetid://130345456032364",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://74499013828378",
		[2] = "rbxassetid://121317277228535",
		[3] = "rbxassetid://136460338431145",
		[4] = "rbxassetid://128217136466110",
		[5] = "rbxassetid://129873546201678",
		[6] = "rbxassetid://95258512303805",
	},
}
FishData.FISH_ASSETS.Arapaima = {
	Basic = "rbxassetid://96370022587959",
	Normal = {
		[1] = "rbxassetid://95585469969346",
		[2] = "rbxassetid://77960058207206",
		[3] = "rbxassetid://72794134395574",
		[4] = "rbxassetid://137929241285509",
		[5] = "rbxassetid://138320654023729",
		[6] = "rbxassetid://87218247404219",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://73551892022466",
			[2] = "rbxassetid://97595828957182",
			[3] = "rbxassetid://90943040791980",
			[4] = "rbxassetid://116130065787839",
			[5] = "rbxassetid://113004321936968",
			[6] = "rbxassetid://126562068676414",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://90521893557648",
		[2] = "rbxassetid://81901001153286",
		[3] = "rbxassetid://123745485590801",
		[4] = "rbxassetid://104377489225239",
		[5] = "rbxassetid://78239521033709",
		[6] = "rbxassetid://123904764092719",
	},
}
FishData.FISH_ASSETS.Arowana = {
	Basic = "rbxassetid://76503195631360",
	Normal = {
		[1] = "rbxassetid://126888302954260",
		[2] = "rbxassetid://74287632594382",
		[3] = "rbxassetid://84168249549811",
		[4] = "rbxassetid://113310597687709",
		[5] = "rbxassetid://86675298545252",
		[6] = "rbxassetid://137606793131191",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://79009987377574",
			[2] = "rbxassetid://94331083429357",
			[3] = "rbxassetid://79422500921988",
			[4] = "rbxassetid://87251812998306",
			[5] = "rbxassetid://120789142262524",
			[6] = "rbxassetid://120587560585155",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://86547689106077",
		[2] = "rbxassetid://93923097904603",
		[3] = "rbxassetid://124058589604967",
		[4] = "rbxassetid://106171235745963",
		[5] = "rbxassetid://129098182152103",
		[6] = "rbxassetid://114329547893704",
	},
}
FishData.FISH_ASSETS.BarbelSteed = {
	Basic = "rbxassetid://105076154741698",
	Normal = {
		[1] = "rbxassetid://92889904264561",
		[2] = "rbxassetid://129951896160503",
		[3] = "rbxassetid://103762984120241",
		[4] = "rbxassetid://90529780038584",
		[5] = "rbxassetid://134111941566447",
		[6] = "rbxassetid://87596041113784",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://99581770577848",
			[2] = "rbxassetid://126380203787842",
			[3] = "rbxassetid://74036356810290",
			[4] = "rbxassetid://140572169026137",
			[5] = "rbxassetid://129372002513347",
			[6] = "rbxassetid://102027502740682",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://81049051972644",
		[2] = "rbxassetid://79343065530484",
		[3] = "rbxassetid://117399774554505",
		[4] = "rbxassetid://139595349065933",
		[5] = "rbxassetid://113067746818097",
		[6] = "rbxassetid://118452111479271",
	},
}
FishData.FISH_ASSETS.BarredKnifejaw = {
	Basic = "rbxassetid://85395337326281",
	Normal = {
		[1] = "rbxassetid://78703844987117",
		[2] = "rbxassetid://92238491002409",
		[3] = "rbxassetid://75813234404793",
		[4] = "rbxassetid://116431227346551",
		[5] = "rbxassetid://119842775645915",
		[6] = "rbxassetid://70506065230793",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://122157159153473",
			[2] = "rbxassetid://83701139612091",
			[3] = "rbxassetid://118226937612683",
			[4] = "rbxassetid://73799377304007",
			[5] = "rbxassetid://79565685810895",
			[6] = "rbxassetid://100683076203388",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://105966020823390",
		[2] = "rbxassetid://96187629086522",
		[3] = "rbxassetid://129131513499758",
		[4] = "rbxassetid://105878141553183",
		[5] = "rbxassetid://101339269521629",
		[6] = "rbxassetid://120494554934632",
	},
}
FishData.FISH_ASSETS.Bass = {
	Basic = "rbxassetid://96840948891799",
	Normal = {
		[1] = "rbxassetid://135242864442249",
		[2] = "rbxassetid://132046970254564",
		[3] = "rbxassetid://78369342991290",
		[4] = "rbxassetid://129947528483076",
		[5] = "rbxassetid://129028949179347",
		[6] = "rbxassetid://87354414919203",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://122009288260146",
			[2] = "rbxassetid://112831961832568",
			[3] = "rbxassetid://103947523682896",
			[4] = "rbxassetid://93341263785804",
			[5] = "rbxassetid://75553290922948",
			[6] = "rbxassetid://99763993827311",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://105887865478553",
		[2] = "rbxassetid://116100068911542",
		[3] = "rbxassetid://89050319800161",
		[4] = "rbxassetid://95545886059653",
		[5] = "rbxassetid://119700334945755",
		[6] = "rbxassetid://130253048247777",
	},
}
FishData.FISH_ASSETS.Bitterling = {
	Basic = "rbxassetid://96787195810404",
	Normal = {
		[1] = "rbxassetid://97687857270143",
		[2] = "rbxassetid://123820761598753",
		[3] = "rbxassetid://84790322794984",
		[4] = "rbxassetid://108075300130093",
		[5] = "rbxassetid://100455558328387",
		[6] = "rbxassetid://124886710694687",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://95819241978691",
			[2] = "rbxassetid://79702076112291",
			[3] = "rbxassetid://84755115623625",
			[4] = "rbxassetid://111301841410860",
			[5] = "rbxassetid://101732906718609",
			[6] = "rbxassetid://89827811635057",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://111758017953636",
		[2] = "rbxassetid://99992605697071",
		[3] = "rbxassetid://74857550473376",
		[4] = "rbxassetid://113108098659668",
		[5] = "rbxassetid://73178305298159",
		[6] = "rbxassetid://114314095534031",
	},
}
FishData.FISH_ASSETS.Bluegill = {
	Basic = "rbxassetid://108042629661534",
	Normal = {
		[1] = "rbxassetid://87448637380839",
		[2] = "rbxassetid://77708065286185",
		[3] = "rbxassetid://71020157737606",
		[4] = "rbxassetid://122039364821555",
		[5] = "rbxassetid://101604308221687",
		[6] = "rbxassetid://100827573024851",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://111313808019982",
			[2] = "rbxassetid://87168102950068",
			[3] = "rbxassetid://80788337624304",
			[4] = "rbxassetid://70796287915932",
			[5] = "rbxassetid://96787244639929",
			[6] = "rbxassetid://118505055250838",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://73764709197178",
		[2] = "rbxassetid://125373344140379",
		[3] = "rbxassetid://99408658711882",
		[4] = "rbxassetid://129279371903746",
		[5] = "rbxassetid://137895379358296",
		[6] = "rbxassetid://112470171536786",
	},
}
FishData.FISH_ASSETS.BrookTrout = {
	Basic = "rbxassetid://105404322537487",
	Normal = {
		[1] = "rbxassetid://78884374460850",
		[2] = "rbxassetid://117474399988095",
		[3] = "rbxassetid://126541957651595",
		[4] = "rbxassetid://81040075034563",
		[5] = "rbxassetid://138286245595906",
		[6] = "rbxassetid://119561213608256",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://104121226679507",
			[2] = "rbxassetid://127836638505190",
			[3] = "rbxassetid://95958163739802",
			[4] = "rbxassetid://114591879721878",
			[5] = "rbxassetid://122785529368176",
			[6] = "rbxassetid://95209968924480",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://123564282242751",
		[2] = "rbxassetid://76068737684768",
		[3] = "rbxassetid://97581478497304",
		[4] = "rbxassetid://126927140413418",
		[5] = "rbxassetid://108798162542816",
		[6] = "rbxassetid://104886718361465",
	},
}
FishData.FISH_ASSETS.Carp = {
	Basic = "rbxassetid://91747718476926",
	Normal = {
		[1] = "rbxassetid://98106143618637",
		[2] = "rbxassetid://93094364333235",
		[3] = "rbxassetid://106181495429022",
		[4] = "rbxassetid://139363237922454",
		[5] = "rbxassetid://114635718764234",
		[6] = "rbxassetid://129519808725100",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://118225536122701",
			[2] = "rbxassetid://113602030348737",
			[3] = "rbxassetid://71112341139700",
			[4] = "rbxassetid://98141432764487",
			[5] = "rbxassetid://114110014534412",
			[6] = "rbxassetid://108125234636768",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://74894642062983",
		[2] = "rbxassetid://84024549657063",
		[3] = "rbxassetid://117294147417480",
		[4] = "rbxassetid://76372071676613",
		[5] = "rbxassetid://74848918986860",
		[6] = "rbxassetid://71766318624884",
	},
}
FishData.FISH_ASSETS.Catfish = {
	Basic = "rbxassetid://111006637548705",
	Normal = {
		[1] = "rbxassetid://97457609572499",
		[2] = "rbxassetid://121872917896776",
		[3] = "rbxassetid://80870054460813",
		[4] = "rbxassetid://109312386978191",
		[5] = "rbxassetid://81451593196042",
		[6] = "rbxassetid://76807339062973",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://138016205839551",
			[2] = "rbxassetid://77231684995180",
			[3] = "rbxassetid://80363435706208",
			[4] = "rbxassetid://75060222299859",
			[5] = "rbxassetid://70417980887572",
			[6] = "rbxassetid://104536378986235",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://135602468366047",
		[2] = "rbxassetid://98039596417461",
		[3] = "rbxassetid://70466223103410",
		[4] = "rbxassetid://126285658900163",
		[5] = "rbxassetid://81897066040895",
		[6] = "rbxassetid://130547897445692",
	},
}
FishData.FISH_ASSETS.CherrySalmon = {
	Basic = "rbxassetid://138275758587126",
	Normal = {
		[1] = "rbxassetid://105341167722129",
		[2] = "rbxassetid://133250340017617",
		[3] = "rbxassetid://71673843968014",
		[4] = "rbxassetid://87469862162361",
		[5] = "rbxassetid://91966989630804",
		[6] = "rbxassetid://88578291504407",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://137327042385483",
			[2] = "rbxassetid://130912182488103",
			[3] = "rbxassetid://82378551410346",
			[4] = "rbxassetid://79937394809727",
			[5] = "rbxassetid://131393464312486",
			[6] = "rbxassetid://84880395509249",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://137909843705552",
		[2] = "rbxassetid://89955958184479",
		[3] = "rbxassetid://113470227341821",
		[4] = "rbxassetid://80257758083543",
		[5] = "rbxassetid://127701488656742",
		[6] = "rbxassetid://98007135491007",
	},
}
FishData.FISH_ASSETS.Coelacanth = {
	Basic = "rbxassetid://94383069472078",
	Normal = {
		[1] = "rbxassetid://119506827718778",
		[2] = "rbxassetid://97607318858682",
		[3] = "rbxassetid://99334523627004",
		[4] = "rbxassetid://94260229054930",
		[5] = "rbxassetid://78381581030524",
		[6] = "rbxassetid://80868525223299",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://83455499708169",
			[2] = "rbxassetid://122135200153992",
			[3] = "rbxassetid://133905557108713",
			[4] = "rbxassetid://80620161010472",
			[5] = "rbxassetid://129280897917058",
			[6] = "rbxassetid://71072069420411",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://135470370118925",
		[2] = "rbxassetid://85911187999524",
		[3] = "rbxassetid://132361555585052",
		[4] = "rbxassetid://75312763535689",
		[5] = "rbxassetid://112114303069937",
		[6] = "rbxassetid://74279121106189",
	},
}
FishData.FISH_ASSETS.Crawfish = {
	Basic = "rbxassetid://112301819531848",
	Normal = {
		[1] = "rbxassetid://73836714867555",
		[2] = "rbxassetid://116262830699406",
		[3] = "rbxassetid://76204892629721",
		[4] = "rbxassetid://139641527754423",
		[5] = "rbxassetid://80937316969560",
		[6] = "rbxassetid://87784720045774",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://97183823558173",
			[2] = "rbxassetid://112388664679062",
			[3] = "rbxassetid://100366196926574",
			[4] = "rbxassetid://104942756021517",
			[5] = "rbxassetid://74436367902850",
			[6] = "rbxassetid://71665349063820",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://92467280183447",
		[2] = "rbxassetid://109688923072676",
		[3] = "rbxassetid://83688818945180",
		[4] = "rbxassetid://95986571131099",
		[5] = "rbxassetid://76784681829185",
		[6] = "rbxassetid://104374465667226",
	},
}
FishData.FISH_ASSETS.CrucianCarp = {
	Basic = "rbxassetid://103818263202004",
	Normal = {
		[1] = "rbxassetid://127483321222836",
		[2] = "rbxassetid://87469579012445",
		[3] = "rbxassetid://134674573516370",
		[4] = "rbxassetid://94507915612756",
		[5] = "rbxassetid://111750786660676",
		[6] = "rbxassetid://123027528908183",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://92098026263152",
			[2] = "rbxassetid://76748715208899",
			[3] = "rbxassetid://75232161968542",
			[4] = "rbxassetid://94807353257761",
			[5] = "rbxassetid://82251713185828",
			[6] = "rbxassetid://72347920632009",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://95177775305518",
		[2] = "rbxassetid://122207796988893",
		[3] = "rbxassetid://80728130474378",
		[4] = "rbxassetid://116414594088904",
		[5] = "rbxassetid://124023528950203",
		[6] = "rbxassetid://137825928085525",
	},
}
FishData.FISH_ASSETS.Dace = {
	Basic = "rbxassetid://112928940795107",
	Normal = {
		[1] = "rbxassetid://137420530288756",
		[2] = "rbxassetid://128604307361564",
		[3] = "rbxassetid://94771987627125",
		[4] = "rbxassetid://121155195398463",
		[5] = "rbxassetid://97608856623193",
		[6] = "rbxassetid://97200778050076",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://116039966101387",
			[2] = "rbxassetid://97849751348709",
			[3] = "rbxassetid://120419577664314",
			[4] = "rbxassetid://102000668604972",
			[5] = "rbxassetid://132984247911057",
			[6] = "rbxassetid://79572103307632",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://102539061881015",
		[2] = "rbxassetid://134740579693090",
		[3] = "rbxassetid://95637517666602",
		[4] = "rbxassetid://79361265938645",
		[5] = "rbxassetid://98217363650362",
		[6] = "rbxassetid://74993799249783",
	},
}
FishData.FISH_ASSETS.Eel = {
	Basic = "rbxassetid://137156661085545",
	Normal = {
		[1] = "rbxassetid://98988856638257",
		[2] = "rbxassetid://137801353082190",
		[3] = "rbxassetid://137153564820312",
		[4] = "rbxassetid://111556341874010",
		[5] = "rbxassetid://105094324002425",
		[6] = "rbxassetid://81502675126172",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://127517483922876",
			[2] = "rbxassetid://91247675298843",
			[3] = "rbxassetid://109244257696181",
			[4] = "rbxassetid://121912523625695",
			[5] = "rbxassetid://73479393474825",
			[6] = "rbxassetid://133668403334409",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://109576998001512",
		[2] = "rbxassetid://76783350470503",
		[3] = "rbxassetid://97795679713441",
		[4] = "rbxassetid://79208291159218",
		[5] = "rbxassetid://121306098055096",
		[6] = "rbxassetid://107789274895006",
	},
}
FishData.FISH_ASSETS.FreshwaterGoby = {
	Basic = "rbxassetid://112156637470281",
	Normal = {
		[1] = "rbxassetid://112434442026027",
		[2] = "rbxassetid://79859056159580",
		[3] = "rbxassetid://133950119398238",
		[4] = "rbxassetid://137027642978441",
		[5] = "rbxassetid://132287730979466",
		[6] = "rbxassetid://124341493853040",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://136946615343340",
			[2] = "rbxassetid://119565020950089",
			[3] = "rbxassetid://129407801389727",
			[4] = "rbxassetid://107396982288721",
			[5] = "rbxassetid://90104344478151",
			[6] = "rbxassetid://98124095176815",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://88322341487122",
		[2] = "rbxassetid://80127804146596",
		[3] = "rbxassetid://104216384784893",
		[4] = "rbxassetid://104898767763916",
		[5] = "rbxassetid://91457776668694",
		[6] = "rbxassetid://116925711246206",
	},
}
FishData.FISH_ASSETS.Frog = {
	Basic = "rbxassetid://88470358145230",
	Normal = {
		[1] = "rbxassetid://96283540157073",
		[2] = "rbxassetid://123218292295596",
		[3] = "rbxassetid://108613886336081",
		[4] = "rbxassetid://94597341788135",
		[5] = "rbxassetid://85423517457537",
		[6] = "rbxassetid://113909473564215",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://89957908799178",
			[2] = "rbxassetid://83217621613410",
			[3] = "rbxassetid://104067980911174",
			[4] = "rbxassetid://96548045776686",
			[5] = "rbxassetid://86712784495841",
			[6] = "rbxassetid://107338062048164",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://72972855185872",
		[2] = "rbxassetid://131241432927091",
		[3] = "rbxassetid://128109434476311",
		[4] = "rbxassetid://94496358094375",
		[5] = "rbxassetid://98313646023752",
		[6] = "rbxassetid://89548059504215",
	},
}
FishData.FISH_ASSETS.GiantCatfish = {
	Basic = "rbxassetid://120809858055011",
	Normal = {
		[1] = "rbxassetid://114534667465473",
		[2] = "rbxassetid://71691583544515",
		[3] = "rbxassetid://118882229885953",
		[4] = "rbxassetid://105826256409877",
		[5] = "rbxassetid://107348379339967",
		[6] = "rbxassetid://102543463112759",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://128048101848164",
			[2] = "rbxassetid://110532338644264",
			[3] = "rbxassetid://71714988165864",
			[4] = "rbxassetid://106546624965617",
			[5] = "rbxassetid://70725674122074",
			[6] = "rbxassetid://81863654635571",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://116239983857285",
		[2] = "rbxassetid://140364302351031",
		[3] = "rbxassetid://138347353246188",
		[4] = "rbxassetid://120944569180380",
		[5] = "rbxassetid://134032213206459",
		[6] = "rbxassetid://112285054654552",
	},
}
FishData.FISH_ASSETS.GiantSnakehead = {
	Basic = "rbxassetid://82038816998506",
	Normal = {
		[1] = "rbxassetid://77929738905344",
		[2] = "rbxassetid://114753091547709",
		[3] = "rbxassetid://89243790355988",
		[4] = "rbxassetid://135275472362569",
		[5] = "rbxassetid://104194188750355",
		[6] = "rbxassetid://111731307506814",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://127885021718297",
			[2] = "rbxassetid://117992390875215",
			[3] = "rbxassetid://128964341730225",
			[4] = "rbxassetid://85277739262420",
			[5] = "rbxassetid://81883451202676",
			[6] = "rbxassetid://113875818230875",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://75712683926645",
		[2] = "rbxassetid://129598817588008",
		[3] = "rbxassetid://132339126325995",
		[4] = "rbxassetid://125803502761771",
		[5] = "rbxassetid://91466468995242",
		[6] = "rbxassetid://107190083840394",
	},
}
FishData.FISH_ASSETS.Goldfish = {
	Basic = "rbxassetid://109447227038296",
	Normal = {
		[1] = "rbxassetid://90849605805071",
		[2] = "rbxassetid://90264994706190",
		[3] = "rbxassetid://102868271932267",
		[4] = "rbxassetid://120692287322300",
		[5] = "rbxassetid://87512797299620",
		[6] = "rbxassetid://132553514532639",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://75873248109576",
			[2] = "rbxassetid://108430000838894",
			[3] = "rbxassetid://89822293650555",
			[4] = "rbxassetid://81995873261419",
			[5] = "rbxassetid://105296623193058",
			[6] = "rbxassetid://123985910657182",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://77391095029195",
		[2] = "rbxassetid://91754632013194",
		[3] = "rbxassetid://92610380919652",
		[4] = "rbxassetid://136455798657328",
		[5] = "rbxassetid://94447951713483",
		[6] = "rbxassetid://138526546894542",
	},
}
FishData.FISH_ASSETS.Guppy = {
	Basic = "rbxassetid://85228785333111",
	Normal = {
		[1] = "rbxassetid://117067350428541",
		[2] = "rbxassetid://119887295559861",
		[3] = "rbxassetid://121027136358662",
		[4] = "rbxassetid://85389010570061",
		[5] = "rbxassetid://90613670608056",
		[6] = "rbxassetid://99543377057123",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://95646641973014",
			[2] = "rbxassetid://130467549266005",
			[3] = "rbxassetid://75555396372008",
			[4] = "rbxassetid://85643764703458",
			[5] = "rbxassetid://103263259851311",
			[6] = "rbxassetid://102405192601639",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://137946516571640",
		[2] = "rbxassetid://86984649620899",
		[3] = "rbxassetid://135200952906360",
		[4] = "rbxassetid://98199596184893",
		[5] = "rbxassetid://83515645041558",
		[6] = "rbxassetid://138275758144813",
	},
}
FishData.FISH_ASSETS.Jellyfish = {
	Basic = "rbxassetid://97443124421485",
	Normal = {
		[1] = "rbxassetid://105641815411767",
		[2] = "rbxassetid://90539778948411",
		[3] = "rbxassetid://99013726493064",
		[4] = "rbxassetid://138001158671484",
		[5] = "rbxassetid://108606796027443",
		[6] = "rbxassetid://126078073892300",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://110302596273992",
			[2] = "rbxassetid://136137725972571",
			[3] = "rbxassetid://103846402271239",
			[4] = "rbxassetid://136514613264609",
			[5] = "rbxassetid://97567790358509",
			[6] = "rbxassetid://109782787046914",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://133952243410651",
		[2] = "rbxassetid://92717302690067",
		[3] = "rbxassetid://72475486166836",
		[4] = "rbxassetid://123751462141410",
		[5] = "rbxassetid://121862208688493",
		[6] = "rbxassetid://137506857895608",
	},
}
FishData.FISH_ASSETS.Killifish = {
	Basic = "rbxassetid://111150372476083",
	Normal = {
		[1] = "rbxassetid://116737855968642",
		[2] = "rbxassetid://131477819425951",
		[3] = "rbxassetid://119148623615177",
		[4] = "rbxassetid://93873993920500",
		[5] = "rbxassetid://73733551027799",
		[6] = "rbxassetid://85847038584263",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://135108472317257",
			[2] = "rbxassetid://99272135239415",
			[3] = "rbxassetid://71504644881326",
			[4] = "rbxassetid://97531630498678",
			[5] = "rbxassetid://87100726298553",
			[6] = "rbxassetid://121837525014887",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://86381854213174",
		[2] = "rbxassetid://130973754567330",
		[3] = "rbxassetid://102152365861121",
		[4] = "rbxassetid://115017085017167",
		[5] = "rbxassetid://116741101525836",
		[6] = "rbxassetid://123964217012489",
	},
}
FishData.FISH_ASSETS.Koi = {
	Basic = "rbxassetid://71744957804591",
	Normal = {
		[1] = "rbxassetid://104795010650454",
		[2] = "rbxassetid://93068666223125",
		[3] = "rbxassetid://83429682188134",
		[4] = "rbxassetid://93327962272870",
		[5] = "rbxassetid://127054219795239",
		[6] = "rbxassetid://137641788724881",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://79780432779159",
			[2] = "rbxassetid://82026387129826",
			[3] = "rbxassetid://102311177192308",
			[4] = "rbxassetid://115804169227025",
			[5] = "rbxassetid://108465397666691",
			[6] = "rbxassetid://83740008649084",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://95279199863691",
		[2] = "rbxassetid://83604366038729",
		[3] = "rbxassetid://96660858130441",
		[4] = "rbxassetid://120698494714904",
		[5] = "rbxassetid://135148088199885",
		[6] = "rbxassetid://76976875708763",
	},
}
FishData.FISH_ASSETS.LargeBass = {
	Basic = "rbxassetid://122535060454257",
	Normal = {
		[1] = "rbxassetid://93640563644569",
		[2] = "rbxassetid://97916391949776",
		[3] = "rbxassetid://131980430153954",
		[4] = "rbxassetid://72243246942113",
		[5] = "rbxassetid://112537936974888",
		[6] = "rbxassetid://80418900456851",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://108224361335264",
			[2] = "rbxassetid://90684392785648",
			[3] = "rbxassetid://126139905774069",
			[4] = "rbxassetid://74430452465045",
			[5] = "rbxassetid://112203828726151",
			[6] = "rbxassetid://113132942983695",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://83623624495611",
		[2] = "rbxassetid://131038362135191",
		[3] = "rbxassetid://89875371709262",
		[4] = "rbxassetid://106125421542859",
		[5] = "rbxassetid://138463162341103",
		[6] = "rbxassetid://78782246570111",
	},
}
FishData.FISH_ASSETS.LargeChar = {
	Basic = "rbxassetid://129183832440303",
	Normal = {
		[1] = "rbxassetid://91390092422196",
		[2] = "rbxassetid://90193998168863",
		[3] = "rbxassetid://74870442924301",
		[4] = "rbxassetid://132176131234107",
		[5] = "rbxassetid://73036470961554",
		[6] = "rbxassetid://136576787850320",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://113704860132857",
			[2] = "rbxassetid://100336839236583",
			[3] = "rbxassetid://124637981521141",
			[4] = "rbxassetid://138028885705733",
			[5] = "rbxassetid://138331288950094",
			[6] = "rbxassetid://103226313261178",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://126954437080810",
		[2] = "rbxassetid://78730069929499",
		[3] = "rbxassetid://116667310642599",
		[4] = "rbxassetid://125810087732234",
		[5] = "rbxassetid://110067809338495",
		[6] = "rbxassetid://135125329751085",
	},
}
FishData.FISH_ASSETS.Loach = {
	Basic = "rbxassetid://138753984920583",
	Normal = {
		[1] = "rbxassetid://139223647265326",
		[2] = "rbxassetid://118557213755040",
		[3] = "rbxassetid://103682496863876",
		[4] = "rbxassetid://108957593594570",
		[5] = "rbxassetid://98842798669137",
		[6] = "rbxassetid://104685064744778",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://116138523582958",
			[2] = "rbxassetid://84818236851173",
			[3] = "rbxassetid://137197455392417",
			[4] = "rbxassetid://122336168025637",
			[5] = "rbxassetid://79805317836300",
			[6] = "rbxassetid://109344738679606",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://139800593008781",
		[2] = "rbxassetid://139483681719757",
		[3] = "rbxassetid://93022148312026",
		[4] = "rbxassetid://107445216176174",
		[5] = "rbxassetid://80027919760190",
		[6] = "rbxassetid://98326097065241",
	},
}
FishData.FISH_ASSETS.PaleChub = {
	Basic = "rbxassetid://132935772379645",
	Normal = {
		[1] = "rbxassetid://93283165875815",
		[2] = "rbxassetid://74939489389455",
		[3] = "rbxassetid://99951743526394",
		[4] = "rbxassetid://80563903661043",
		[5] = "rbxassetid://115523659384272",
		[6] = "rbxassetid://132717614434720",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://107234509276723",
			[2] = "rbxassetid://70947114467886",
			[3] = "rbxassetid://98635117044524",
			[4] = "rbxassetid://80548059248159",
			[5] = "rbxassetid://114615030911370",
			[6] = "rbxassetid://98827519691997",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://128017788258384",
		[2] = "rbxassetid://91215347686069",
		[3] = "rbxassetid://116904881472758",
		[4] = "rbxassetid://78988297275509",
		[5] = "rbxassetid://134955249288649",
		[6] = "rbxassetid://115411217586107",
	},
}
FishData.FISH_ASSETS.Piranha = {
	Basic = "rbxassetid://72421627397129",
	Normal = {
		[1] = "rbxassetid://140115992496015",
		[2] = "rbxassetid://124635125739168",
		[3] = "rbxassetid://109610694155585",
		[4] = "rbxassetid://97650550825972",
		[5] = "rbxassetid://83485679009545",
		[6] = "rbxassetid://119035666397471",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://107741177167704",
			[2] = "rbxassetid://90048684457599",
			[3] = "rbxassetid://122827727878377",
			[4] = "rbxassetid://137574312830467",
			[5] = "rbxassetid://104979531178784",
			[6] = "rbxassetid://105708774545625",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://135838539560668",
		[2] = "rbxassetid://89486546954285",
		[3] = "rbxassetid://75227907482504",
		[4] = "rbxassetid://105152745824969",
		[5] = "rbxassetid://132052422074996",
		[6] = "rbxassetid://135473713936885",
	},
}
FishData.FISH_ASSETS.PondSmelt = {
	Basic = "rbxassetid://118717718528519",
	Normal = {
		[1] = "rbxassetid://123652427191302",
		[2] = "rbxassetid://137788400333421",
		[3] = "rbxassetid://137355656638042",
		[4] = "rbxassetid://91827939908276",
		[5] = "rbxassetid://79096666623147",
		[6] = "rbxassetid://138341867503397",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://132519122207036",
			[2] = "rbxassetid://107307550180990",
			[3] = "rbxassetid://110902653898392",
			[4] = "rbxassetid://139522793003683",
			[5] = "rbxassetid://98190735353906",
			[6] = "rbxassetid://134410255301609",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://124728836025309",
		[2] = "rbxassetid://74788063560838",
		[3] = "rbxassetid://97086667832036",
		[4] = "rbxassetid://91715314706668",
		[5] = "rbxassetid://121125526730133",
		[6] = "rbxassetid://118337668374183",
	},
}
FishData.FISH_ASSETS.PopeyedGoldfish = {
	Basic = "rbxassetid://125811719952199",
	Normal = {
		[1] = "rbxassetid://139370281203749",
		[2] = "rbxassetid://113528217911084",
		[3] = "rbxassetid://85228752641867",
		[4] = "rbxassetid://91884033563157",
		[5] = "rbxassetid://135008488124621",
		[6] = "rbxassetid://100774942050446",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://135056689654160",
			[2] = "rbxassetid://80416311881210",
			[3] = "rbxassetid://108945959038200",
			[4] = "rbxassetid://94963531870259",
			[5] = "rbxassetid://138249765112311",
			[6] = "rbxassetid://96292417813989",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://93524915690586",
		[2] = "rbxassetid://75102763832770",
		[3] = "rbxassetid://71289785413671",
		[4] = "rbxassetid://101950360839707",
		[5] = "rbxassetid://73982143678634",
		[6] = "rbxassetid://100915354440339",
	},
}
FishData.FISH_ASSETS.RainbowTrout = {
	Basic = "rbxassetid://81996596695909",
	Normal = {
		[1] = "rbxassetid://123813841806942",
		[2] = "rbxassetid://134760881417489",
		[3] = "rbxassetid://117188210339355",
		[4] = "rbxassetid://124659519129554",
		[5] = "rbxassetid://82020763188026",
		[6] = "rbxassetid://98843335683623",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://126024064821965",
			[2] = "rbxassetid://98415487364898",
			[3] = "rbxassetid://108209802990099",
			[4] = "rbxassetid://87253544717122",
			[5] = "rbxassetid://90848222879322",
			[6] = "rbxassetid://82283682954382",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://140569727584156",
		[2] = "rbxassetid://85496428253800",
		[3] = "rbxassetid://100582500203210",
		[4] = "rbxassetid://71352031417899",
		[5] = "rbxassetid://109248298710972",
		[6] = "rbxassetid://99981315605393",
	},
}
FishData.FISH_ASSETS.RedSnapper = {
	Basic = "rbxassetid://106056877657794",
	Normal = {
		[1] = "rbxassetid://120226509483532",
		[2] = "rbxassetid://91029816277771",
		[3] = "rbxassetid://90623704823227",
		[4] = "rbxassetid://132658020759440",
		[5] = "rbxassetid://72856975350326",
		[6] = "rbxassetid://134388806048449",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://81242343932313",
			[2] = "rbxassetid://102577505039039",
			[3] = "rbxassetid://120058939548769",
			[4] = "rbxassetid://71950376358445",
			[5] = "rbxassetid://119588433525902",
			[6] = "rbxassetid://125002757846477",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://137696029595158",
		[2] = "rbxassetid://97375261279072",
		[3] = "rbxassetid://94201797953686",
		[4] = "rbxassetid://119539516412753",
		[5] = "rbxassetid://129470033009286",
		[6] = "rbxassetid://93065511506486",
	},
}
FishData.FISH_ASSETS.Salmon = {
	Basic = "rbxassetid://98206754418478",
	Normal = {
		[1] = "rbxassetid://92460602954019",
		[2] = "rbxassetid://127520036213908",
		[3] = "rbxassetid://85782232147327",
		[4] = "rbxassetid://88953663017365",
		[5] = "rbxassetid://137791912907939",
		[6] = "rbxassetid://104552570773621",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://134891575754190",
			[2] = "rbxassetid://122915462489728",
			[3] = "rbxassetid://72838394623343",
			[4] = "rbxassetid://73300503594980",
			[5] = "rbxassetid://139344014290044",
			[6] = "rbxassetid://129416501489885",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://104567145368288",
		[2] = "rbxassetid://115992273608365",
		[3] = "rbxassetid://92011181258267",
		[4] = "rbxassetid://95429511125684",
		[5] = "rbxassetid://92048280659112",
		[6] = "rbxassetid://89568354138087",
	},
}
FishData.FISH_ASSETS.SeaBass = {
	Basic = "rbxassetid://94054055538793",
	Normal = {
		[1] = "rbxassetid://120884265688544",
		[2] = "rbxassetid://91859302698389",
		[3] = "rbxassetid://91752963864147",
		[4] = "rbxassetid://90125485001203",
		[5] = "rbxassetid://90409268390499",
		[6] = "rbxassetid://122156771342338",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://105705717643503",
			[2] = "rbxassetid://121211469118880",
			[3] = "rbxassetid://111370354939632",
			[4] = "rbxassetid://74819454329506",
			[5] = "rbxassetid://120507251677064",
			[6] = "rbxassetid://92557075189486",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://76883291460280",
		[2] = "rbxassetid://124596228353757",
		[3] = "rbxassetid://106779441843773",
		[4] = "rbxassetid://119661013386326",
		[5] = "rbxassetid://106050758811810",
		[6] = "rbxassetid://92182987034523",
	},
}
FishData.FISH_ASSETS.SmallBass = {
	Basic = "rbxassetid://101021387124519",
	Normal = {
		[1] = "rbxassetid://81869340897287",
		[2] = "rbxassetid://112047234810389",
		[3] = "rbxassetid://104696767262976",
		[4] = "rbxassetid://70921297339795",
		[5] = "rbxassetid://138955704377253",
		[6] = "rbxassetid://113307957713180",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://132125308477929",
			[2] = "rbxassetid://96933634182776",
			[3] = "rbxassetid://108765169769556",
			[4] = "rbxassetid://137368947439440",
			[5] = "rbxassetid://111337070661963",
			[6] = "rbxassetid://124999221628640",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://82583384733511",
		[2] = "rbxassetid://77671752111005",
		[3] = "rbxassetid://77718849071855",
		[4] = "rbxassetid://88520477732380",
		[5] = "rbxassetid://85746587721391",
		[6] = "rbxassetid://108826494497668",
	},
}
FishData.FISH_ASSETS.Stringfish = {
	Basic = "rbxassetid://74094826647180",
	Normal = {
		[1] = "rbxassetid://109845671825977",
		[2] = "rbxassetid://85023331168293",
		[3] = "rbxassetid://86288643205251",
		[4] = "rbxassetid://90174531634882",
		[5] = "rbxassetid://99449631760851",
		[6] = "rbxassetid://94223409282472",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://88806220734269",
			[2] = "rbxassetid://98012467898713",
			[3] = "rbxassetid://127672361363859",
			[4] = "rbxassetid://75553205739003",
			[5] = "rbxassetid://119760580069501",
			[6] = "rbxassetid://105264809162683",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://130704309237850",
		[2] = "rbxassetid://119303774545930",
		[3] = "rbxassetid://139155606081928",
		[4] = "rbxassetid://130260474740800",
		[5] = "rbxassetid://111693304562818",
		[6] = "rbxassetid://126571745120285",
	},
}
FishData.FISH_ASSETS.Sweetfish = {
	Basic = "rbxassetid://94878203154381",
	Normal = {
		[1] = "rbxassetid://114888547359608",
		[2] = "rbxassetid://123490042096626",
		[3] = "rbxassetid://120826658437856",
		[4] = "rbxassetid://71957416367059",
		[5] = "rbxassetid://81117118775504",
		[6] = "rbxassetid://136783806983921",
	},
	Elemental = {
		[1] = {
			[1] = "rbxassetid://85995442732645",
			[2] = "rbxassetid://105716381469275",
			[3] = "rbxassetid://123023819637097",
			[4] = "rbxassetid://136903002858783",
			[5] = "rbxassetid://128670899664621",
			[6] = "rbxassetid://127515952189202",
		},
		[2] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[3] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
		[4] = { [1] = "rbxassetid://", [2] = "rbxassetid://", [3] = "rbxassetid://", [4] = "rbxassetid://", [5] = "rbxassetid://", [6] = "rbxassetid://" },
	},
	Elder = {
		[1] = "rbxassetid://110667374111846",
		[2] = "rbxassetid://72595687400889",
		[3] = "rbxassetid://137009915647927",
		[4] = "rbxassetid://134563003886249",
		[5] = "rbxassetid://84750292927694",
		[6] = "rbxassetid://124436678302734",
	},
}

FishData.FISH_ASSETS_MASKED = {} :: { [string]: string }
FishData.FISH_ASSETS_MASKED.Angelfish = "rbxassetid://77109860394237"
FishData.FISH_ASSETS_MASKED.Arapaima = "rbxassetid://89800185202888"
FishData.FISH_ASSETS_MASKED.Arowana = "rbxassetid://82928567658181"
FishData.FISH_ASSETS_MASKED.BarbelSteed = "rbxassetid://125956703164581"
FishData.FISH_ASSETS_MASKED.BarredKnifejaw = "rbxassetid://76747518887539"
FishData.FISH_ASSETS_MASKED.Bass = "rbxassetid://99772489317275"
FishData.FISH_ASSETS_MASKED.Bitterling = "rbxassetid://107478892945381"
FishData.FISH_ASSETS_MASKED.Bluegill = "rbxassetid://72637955838823"
FishData.FISH_ASSETS_MASKED.BrookTrout = "rbxassetid://134110863090361"
FishData.FISH_ASSETS_MASKED.Carp = "rbxassetid://124678984212865"
FishData.FISH_ASSETS_MASKED.Catfish = "rbxassetid://85882962915022"
FishData.FISH_ASSETS_MASKED.CherrySalmon = "rbxassetid://83858443439943"
FishData.FISH_ASSETS_MASKED.Coelacanth = "rbxassetid://87029810461797"
FishData.FISH_ASSETS_MASKED.Crawfish = "rbxassetid://86628573484566"
FishData.FISH_ASSETS_MASKED.CrucianCarp = "rbxassetid://127257965532413"
FishData.FISH_ASSETS_MASKED.Dace = "rbxassetid://89253811370527"
FishData.FISH_ASSETS_MASKED.Eel = "rbxassetid://101391736492652"
FishData.FISH_ASSETS_MASKED.FreshwaterGoby = "rbxassetid://134948006149386"
FishData.FISH_ASSETS_MASKED.Frog = "rbxassetid://99843270154317"
FishData.FISH_ASSETS_MASKED.GiantCatfish = "rbxassetid://108657133678434"
FishData.FISH_ASSETS_MASKED.GiantSnakehead = "rbxassetid://124573542666596"
FishData.FISH_ASSETS_MASKED.Goldfish = "rbxassetid://84723504847593"
FishData.FISH_ASSETS_MASKED.Guppy = "rbxassetid://117494062996307"
FishData.FISH_ASSETS_MASKED.Jellyfish = "rbxassetid://75660067180044"
FishData.FISH_ASSETS_MASKED.Killifish = "rbxassetid://101658374926168"
FishData.FISH_ASSETS_MASKED.Koi = "rbxassetid://101310715373826"
FishData.FISH_ASSETS_MASKED.LargeBass = "rbxassetid://130564021063606"
FishData.FISH_ASSETS_MASKED.LargeChar = "rbxassetid://135449004001247"
FishData.FISH_ASSETS_MASKED.Loach = "rbxassetid://100241345423171"
FishData.FISH_ASSETS_MASKED.PaleChub = "rbxassetid://121795734063284"
FishData.FISH_ASSETS_MASKED.Piranha = "rbxassetid://84183499885130"
FishData.FISH_ASSETS_MASKED.PondSmelt = "rbxassetid://92562661707372"
FishData.FISH_ASSETS_MASKED.PopeyedGoldfish = "rbxassetid://123610217707969"
FishData.FISH_ASSETS_MASKED.RainbowTrout = "rbxassetid://135272844622320"
FishData.FISH_ASSETS_MASKED.RedSnapper = "rbxassetid://78299527693904"
FishData.FISH_ASSETS_MASKED.Salmon = "rbxassetid://80950117232370"
FishData.FISH_ASSETS_MASKED.SeaBass = "rbxassetid://96168016674695"
FishData.FISH_ASSETS_MASKED.SmallBass = "rbxassetid://117766635398649"
FishData.FISH_ASSETS_MASKED.Stringfish = "rbxassetid://98048884610035"
FishData.FISH_ASSETS_MASKED.Sweetfish = "rbxassetid://128763225025482"

return FishData
