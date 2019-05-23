config = {}

config.dic = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1"
config.dance = "ld_girl_a_song_a_p1_f"

-- When you add a new place in this config : don't forget to config also its in "server/main.lua" in Config section (the price, to be securized: server-side)
-- Après avoir ajouté un nouveau lieu pour les danses, n'oublie pas de rajouter le même lieu dans le server/main.lua, dans la partie "Config"
config.places = {
	-- Unicorn config
	{
		id = 1,
		positions = { -- Strippers pos
		  {x=101.884, y=-1289.77, z=28.258, a=290.598},
		  {x=104.6779, y=-1295.2697, z=28.258, a=297.289},
		  {x=104.0453, y=-1292.199, z=28.258, a=298.912},
		  {x=107.359, y=-1290.2869, z=27.8587, a=297.33},
		  {x=112.0371 ,y=-1286.2375, z=27.4586, a=30.04},
		  {x=113.205, y=-1288.293, z=27.4586, a=211.88}
		},
		startPos = {x=94.9993, y=-1293.52, z=29.2688}, -- Pos to call strippers
		stopPos = {x=101.859, y=-1296.26, z=28.7688}, -- Pos to hire strippers
		dispawnPos = {x=108.313, y=-1305.77, z=28.7688}, -- Pos where strippers dispawn
		dispawnTime = 25000, -- Time until the strippers dispawn
		hash = {1544875514, -2126242959} -- Hash of the strippers models
	},
	-- After hours DLC (nightclub)
	{
		id = 2,
		positions = {
		  {x=-1598.49, y=-3015.65, z=-78.2112, a=0.0},
	  	{x=-1596.15, y=-3008.19, z=-79.211, a=0.0}
		},
		startPos = {x=-1619.49, y=-3011.14, z=-75.205},
		stopPos = {x=-1615.27, y=-3019.46, z=-75.205},
		dispawnPos = {x=-1615.27, y=-3019.46, z=-75.205},
		dispawnTime = 45000,
		hash = {1544875514, -2126242959}
	}
}
