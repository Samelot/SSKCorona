-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
-- SSK behaviors
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
local behaviors = {}
if( _G.ssk ) then _G.ssk.behaviors = behaviors end

-- Prep Manager and Utils
behaviors.manager = require "com.roaminggamer.ssk.behaviors.manager"
behaviors.utils   = require "com.roaminggamer.ssk.behaviors.utils"
local bmgr        = behaviors.manager
local butils      = behaviors.utils

-- Load Behaviors
require "com.roaminggamer.ssk.behaviors.collision.onCollisionBegan_ExecuteCallback"
require "com.roaminggamer.ssk.behaviors.collision.onCollisionBegan_PrintMessage"
require "com.roaminggamer.ssk.behaviors.collision.onCollisionEnded_ExecuteCallback"
require "com.roaminggamer.ssk.behaviors.collision.onCollisionEnded_PrintMessage"
require "com.roaminggamer.ssk.behaviors.collision.onPostCollision_PrintMessage"
require "com.roaminggamer.ssk.behaviors.collision.onPreCollision_PrintMessage"
require "com.roaminggamer.ssk.behaviors.movers.dragDrop"
require "com.roaminggamer.ssk.behaviors.movers.faceTouch"
require "com.roaminggamer.ssk.behaviors.movers.faceTouchFixedRate"
require "com.roaminggamer.ssk.behaviors.movers.moveToTouch"
require "com.roaminggamer.ssk.behaviors.movers.moveToTouchFixedRate"
require "com.roaminggamer.ssk.behaviors.movers.onTouch_applyContinuousForce"
require "com.roaminggamer.ssk.behaviors.movers.onTouch_applyForwardForce"
require "com.roaminggamer.ssk.behaviors.movers.onTouch_applyTimedForce"
require "com.roaminggamer.ssk.behaviors.physics.physics_hasForce"

return behaviors


