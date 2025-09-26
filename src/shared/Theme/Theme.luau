local Theme = {
	font = Enum.Font.FredokaOne,
	color = {
		-- Core Wood Theme
		panel = Color3.fromRGB(181, 136, 99), -- Oak
		border = Color3.fromRGB(92, 64, 51), -- Walnut
		text = Color3.fromRGB(250, 240, 210), -- Parchment
		subtle = Color3.fromRGB(95, 85, 80), -- Stone/Shadow
		accent = Color3.fromRGB(70, 160, 150), -- Sea teal
		gold = Color3.fromRGB(230, 180, 80), -- Amber

		-- 🌱 Greens (growth, health, “go” states)
		greenLight = Color3.fromRGB(150, 200, 120), -- leaf
		green = Color3.fromRGB(90, 160, 90), -- forest
		greenDark = Color3.fromRGB(50, 100, 60), -- pine

		-- 🌊 Blues (calm, water, info states)
		blueLight = Color3.fromRGB(140, 180, 220), -- sky
		blue = Color3.fromRGB(80, 130, 190), -- ocean
		blueDark = Color3.fromRGB(40, 70, 120), -- deep sea

		-- ❤️ Reds (alerts, rare loot, cancel states)
		redLight = Color3.fromRGB(220, 140, 140), -- coral
		red = Color3.fromRGB(190, 90, 70), -- rust
		redDark = Color3.fromRGB(120, 50, 40), -- brick

		-- 🟣 Purples (magic, rare/epic states)
		purpleLight = Color3.fromRGB(180, 150, 220),
		purple = Color3.fromRGB(140, 110, 190),
		purpleDark = Color3.fromRGB(90, 70, 130),

		-- ⚪ Neutrals (backgrounds, disabled states)
		white = Color3.fromRGB(255, 255, 255),
		gray = Color3.fromRGB(160, 160, 160),
		black = Color3.fromRGB(20, 20, 20),
	},
	button = {
		image = "rbxassetid://107775994550465",
		hoverImage = "rbxassetid://130925689990072",
		pressedImage = "rbxassetid://106232614340873",
	},
	radius = 8,
	padding = 10,
	strokeTransparency = 0.25,
}

return Theme
