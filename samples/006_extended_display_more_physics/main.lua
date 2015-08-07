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

easyIFC:quickLabel( group, "Goofy Newton's Cradle: 17 Lines", centerX, centerY - 135, gameFont, 14 )


local layers = ssk.display.quickLayers( group, "underlay", "ropes", "content", "overlay")

local anchor = newRect( layers.content, centerX, centerY, {size = 10, fill = _O_ }, { bodyType = "static" } )

local function enterFrame( self, event )
	if( self.removeSelf == nil ) then 
		Runtime:removeEventListener("enterFrame", self)
		return 
	end
	display.remove(self.rope)
	self.rope = display.newLine( layers.ropes, anchor.x, anchor.y, self.x, self.y )
	self.rope.strokeWidth = 2
end
local a = newImageRect( layers.content, centerX-100, centerY, 
	                    "yellow_round.png", 
	                    { radius = 20,  enterFrame = enterFrame }, 
	                    { bounce = 1, linearDamping = -0.25 } )	

local b = newImageRect( layers.content, centerX, centerY+100, 
						"blue_round.png", 
						{ radius = 20, enterFrame = enterFrame }, 
						{ bounce = 1, density = 1, linearDamping = -0.25 } )

local c = newImageRect( layers.content, centerX+100, centerY, 
						"green_round.png", 
						{ radius = 20, enterFrame = enterFrame}, 
						{ bounce = 1, density = 1.5, linearDamping = -0.25 } )

physics.newJoint( "distance", anchor, a, anchor.x, anchor.y, a.x, a.y )
physics.newJoint( "distance", anchor, b, anchor.x, anchor.y, b.x, b.y )
physics.newJoint( "distance", anchor, c, anchor.x, anchor.y, c.x, c.y )