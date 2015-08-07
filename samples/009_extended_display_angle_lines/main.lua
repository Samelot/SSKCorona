-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
-- SSK Sampler
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
display.setStatusBar(display.HiddenStatusBar)  -- Hide that pesky bar
io.output():setvbuf("no") -- Don't use buffer for console messages
-- =============================================================

-- =============================================================
-- Step 1. - Load SSK (optionally select default font)
-- =============================================================
--_G.gameFont = native.systemFont  -- optional
require "ssk.loadSSK"


-- =============================================================
-- Step 2. - Example
-- =============================================================

local group = display.newGroup()

-- Localizations
local newAngleLine = ssk.display.newAngleLine
local easyIFC   = ssk.easyIFC

easyIFC:quickLabel( group, "Various Angle Lines Using SSK", centerX + 80, centerY - 50, gameFont, 14 )

local curY = 10
local tmp = newAngleLine( group, 50, curY, 135, 200 )

curY = curY + 20
local tmp = newAngleLine( group, 50, curY, 135, 200, { w = 2, fill = _R_ } )

curY = curY + 20
local tmp = newAngleLine( group, 50, curY, 135, 200, { w = 1, dashLen = 3, gapLen = 5, fill = _C_, style = "dashed" } )

curY = curY + 20
local tmp = newAngleLine( group, 50, curY, 135, 200, { radius = 3, gapLen = 5, fill = _O_, style = "dotted", stroke = _Y_, strokeWidth = 1} )

curY = curY + 20
local tmp = newAngleLine( group, 50, curY, 135, 200, { gapLen = 10, dashLen = 6, headSize = 4, fill = _O_, style = "arrows"} )

curY = curY + 20
local tmp = newAngleLine( group, 50, curY, 135, 200, { gapLen = 10, dashLen = 1, headSize = 4, fill = _C_, style = "arrows"} )