-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
-- 								License
-- =============================================================
--[[
	> SSK is free to use.
	> SSK is free to edit.
	> SSK is free to use in a free or commercial game.
	> SSK is free to use in a free or commercial non-game app.
	> SSK is free to use without crediting the author (credits are still appreciated).
	> SSK is free to use without crediting the project (credits are still appreciated).
	> SSK is NOT free to sell for anything.
	> SSK is NOT free to credit yourself with.
]]
-- =============================================================
local easyInputs = {}
_G.ssk.easyInputs = easyInputs
easyInputs.joystick 		= require("com.roaminggamer.ssk.RGEasyInputs.joystick")
easyInputs.cornerButtons 	= require("com.roaminggamer.ssk.RGEasyInputs.cornerButtons")
easyInputs.oneTouch 		= require("com.roaminggamer.ssk.RGEasyInputs.oneTouch")
easyInputs.twoTouch 		= require("com.roaminggamer.ssk.RGEasyInputs.twoTouch")
easyInputs.oneStick 		= require("com.roaminggamer.ssk.RGEasyInputs.oneStick")
easyInputs.twoStick 		= require("com.roaminggamer.ssk.RGEasyInputs.twoStick")
easyInputs.oneStickOneTouch = require("com.roaminggamer.ssk.RGEasyInputs.oneStickOneTouch")
--table.dump(easyInputs)
return easyInputs