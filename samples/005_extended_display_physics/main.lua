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


local physics = require "physics"
physics.setGravity( 0, 10 )
physics.start()
--physics.setDrawMode( "hybrid" )

-- Localizations
local newCircle 	= ssk.display.newCircle
local newRect   	= ssk.display.newRect
local newImageRect  = ssk.display.newImageRect
local easyIFC   	= ssk.easyIFC

-- =============================================================
-- SSK Versions
-- =============================================================
easyIFC:quickLabel( group, "2 Lines Using SSK", centerX - 100, centerY - 100 )

newImageRect( group, centerX - 100 , centerY - 50,
	          "yellow_round.png", {}, { radius = 20, bounce = 1, gravityScale = 0.2 } )	

newImageRect( group, centerX - 100, centerY + 100, 
	          "square2.png", {}, { bodyType = "static" } ) 


-- =============================================================
-- Traditional Corona versions
-- =============================================================

easyIFC:quickLabel( group, "9 Lines Traditionally", centerX + 100, centerY - 100 )

local ball = display.newImageRect( group, "yellow_round.png", 40, 40 )
ball.x = centerX + 100
ball.y = centerY - 50
physics.addBody( ball, { radius = 20, bounce = 1, radius = 20  } )
ball.gravityScale = 0.2

local block = display.newImageRect( group, "square2.png", 40, 40 )
block.x = centerX + 100
block.y = centerY + 100
physics.addBody( block, "static" )
