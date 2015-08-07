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

-- Without Layers (all in group)
--
local red = ssk.display.newCircle( group, centerX - 100, centerY - 10, { radius = 20, fill = _R_ } )	
local green = ssk.display.newCircle( group, centerX - 10 - 100, centerY + 10, { radius = 20, fill = _G_ } )
local blue = ssk.display.newCircle( group, centerX + 10 - 100, centerY + 10, { radius = 20, fill = _B_ } )

-- Using Layers
--
local layers = ssk.display.quickLayers( group, "underlay", "content", "overlay")
local red = ssk.display.newCircle( layers.overlay, centerX + 100, centerY - 10, { radius = 20, fill = _R_ } )	
local green = ssk.display.newCircle( layers.content, centerX - 10 + 100, centerY + 10, { radius = 20, fill = _G_ } )
local blue = ssk.display.newCircle( layers.underlay, centerX + 10 + 100, centerY + 10, { radius = 20, fill = _B_ } )

-- Notice how order no longer affects which object is over which object?
