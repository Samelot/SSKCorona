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
local newLine 	= ssk.display.newLine
local easyIFC   = ssk.easyIFC

easyIFC:quickLabel( group, "Various Lines in 6 Lines Using SSK", centerX, centerY - 25, gameFont, 14 )

newLine( group, 50, centerY, 450, centerY )
newLine( group, 50, centerY + 20, 450, centerY + 20, { w = 2, fill = _R_ } )
newLine( group, 50, centerY + 40, 450, centerY + 40, { w = 1, dashLen = 3, gapLen = 5, fill = _C_, style = "dashed" } )
newLine( group, 50, centerY + 60, 450, centerY + 60, { radius = 3, gapLen = 5, fill = _O_, style = "dotted", stroke = _Y_, strokeWidth = 1} )
newLine( group, 50, centerY + 80, 450, centerY + 80, { gapLen = 10, dashLen = 6, headSize = 4, fill = _O_, style = "arrows"} )
newLine( group, 50, centerY + 100, 450, centerY + 100, { gapLen = 10, dashLen = 0, headSize = 4, fill = _C_, style = "arrows"} )
