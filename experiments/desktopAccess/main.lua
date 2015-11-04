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

--_G.gameFont = native.systemFont  -- optional
require "ssk.loadSSK"

-- =============================================================
-- 
-- =============================================================
-- SSK 
local isInBounds		= ssk.easyIFC.isInBounds
local newCircle 		= ssk.display.circle
local newRect 			= ssk.display.rect
local newImageRect 		= ssk.display.imageRect
local easyIFC			= ssk.easyIFC
local ternary			= _G.ternary
local quickLayers  		= ssk.display.quickLayers

local angle2Vector 		= ssk.math2d.angle2Vector
local vector2Angle 		= ssk.math2d.vector2Angle
local scaleVec 			= ssk.math2d.scale
local addVec 			= ssk.math2d.add
local subVec 			= ssk.math2d.sub
local getNormals 		= ssk.math2d.normals

-- Lua and Corona
local mAbs 				= math.abs
local mPow 				= math.pow
local mRand 			= math.random
local getInfo			= system.getInfo
local getTimer 			= system.getTimer
local strMatch 			= string.match
local strFormat 		= string.format


-- =============================================================
-- File System Experiments
-- =============================================================


local rgFiles = ssk.rgFiles

print( rgFiles.getResourceRoot() )
print( rgFiles.getDocumentsRoot() )
print( rgFiles.getTemporaryRoot() )

local path = rgFiles.getMyDocuments() .. "test.json"

print(path)

local bubba = { 1 , 2, 3 }

local json = require "json"

local fh = io.open( path, "w" )

if(fh) then
	fh:write(json.encode( bubba ))
	io.close( fh )
	print('success')
else
	print('failure')
end	


--local path = system.pathForFile( rgFiles.getDesktop() .. "test.json", system.ResourceDirectory)
--print(path)

--table.save( bubba, rgFiles.getDesktop() .. "test.json")
--table.save( bubba, "test.json", system.TemporaryDirectory )
--[[
local vars = { "windir", "appdata", "computername", "programfiles", "systemdrive", "systemroot"}
for i = 1, #vars do
	print( vars[i], " == ", os.getenv(vars[i]))
end
--]]


