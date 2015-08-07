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
-- Step 2. - Example (comparison of SSK vs Traditional Corona)
-- =============================================================

local group = display.newGroup()



-- Localizations
local newImageRect = ssk.display.newImageRect
local easyIFC   = ssk.easyIFC

-- =============================================================
-- SSK Versions
-- =============================================================

easyIFC:quickLabel( group, "Each made with one line using SSK", centerX, centerY - 100 )

-- 1
newImageRect( group, 45, centerY - 50, "smiley.png" )	 

-- 2
newImageRect( group, 95, centerY - 50, "smiley.png", { fill = _R_ } )

-- 3
newImageRect( group, 145, centerY - 50, "smiley.png", { radius = 10, fill = _B_, stroke = _W_, strokeWidth = 2 } )

-- 4
newImageRect( group, 195, centerY - 50, "smiley.png", { size = 20, fill = _O_ } )

-- 5
newImageRect( group, 245, centerY - 50, "smiley.png", { radius = 20, scale = 0.5, fill = _Y_ } )

-- 6
newImageRect( group, 295, centerY - 50, "smiley.png", { xScale = 0.75, fill = _C_ } )

-- 7
newImageRect( group, 345, centerY - 50, "smiley.png", { yScale = 0.75, rotation = 15, fill = _PURPLE_ } )

-- 8
newImageRect( group, 395, centerY - 50, "smiley.png", { fill = { type = "image", baseDir = system.ResourceDirectory, filename = "water.png"} } )

-- 9
newImageRect( group, 445, centerY - 50, "smiley.png", { 
	fill = { type = "gradient", color1 = { 1, 0, 0.4 }, color2 = { 1, 0, 0, 0.2 }, direction = "down" }, strokeWidth = 4, 
	stroke = { type = "gradient", color1 = { 0, 1, 0.4 }, color2 = { 0, 0, 1, 0.2 }, direction = "up" } } )


-- =============================================================
-- Traditional Corona versions
-- =============================================================

easyIFC:quickLabel( group, "Each made with N lines using traditional Corona", centerX, centerY )

-- 1
local tmp = display.newImageRect( group, "smiley.png", 40, 40 )
tmp.x = 45
tmp.y = centerY + 50
easyIFC:quickLabel( group, "3", 45, centerY + 100 )

-- 2
local tmp = display.newImageRect( group, "smiley.png", 40, 40 )
tmp.x = 95
tmp.y = centerY + 50
tmp:setFillColor( 1, 0, 0 )
easyIFC:quickLabel( group, "4", 95, centerY + 100 )

-- 3
local tmp = display.newImageRect( group, "smiley.png", 40, 40 )
tmp.x = 145
tmp.y = centerY + 50
tmp:setFillColor( 0, 0, 1 )
tmp:setStrokeColor( 1, 1, 1 )
tmp.strokeWidth = 2
easyIFC:quickLabel( group, "6", 145, centerY + 100 )

-- 4
local tmp = display.newImageRect( group, "smiley.png", 20, 20 )
tmp.x = 195
tmp.y = centerY + 50
tmp:setFillColor( 1, 0.398, 0 )
easyIFC:quickLabel( group, "4", 195, centerY + 100 )

-- 5
local tmp = display.newImageRect( group, "smiley.png", 40, 40 )
tmp.x = 245
tmp.y = centerY + 50
tmp:setFillColor( 1, 1, 0 )
tmp.xScale = 0.5
tmp.yScale = 0.5
easyIFC:quickLabel( group, "6", 245, centerY + 100 )

-- 6
local tmp = display.newImageRect( group, "smiley.png", 40, 40 )
tmp.x = 295
tmp.y = centerY + 50
tmp:setFillColor( 0, 1, 1 )
tmp.xScale = 0.75
easyIFC:quickLabel( group, "5", 295, centerY + 100 )

-- 7
local tmp = display.newImageRect( group, "smiley.png", 40, 40 )
tmp.x = 345
tmp.y = centerY + 50
tmp:setFillColor( 0.625, 0.125, 0.938 )
tmp.yScale = 0.75
tmp.rotation = 15
easyIFC:quickLabel( group, "6", 345, centerY + 100 )

-- 8
local tmp = display.newImageRect( group, "smiley.png", 40, 40 )
tmp.x = 395
tmp.y = centerY + 50
tmp.fill = { type = "image", baseDir = system.ResourceDirectory, filename = "water.png"}
easyIFC:quickLabel( group, "4", 395, centerY + 100 )

-- 9
local tmp = display.newImageRect( group, "smiley.png", 40, 40 )
tmp.x = 445
tmp.y = centerY + 50
tmp.fill = { type = "gradient", color1 = { 1, 0, 0.4 }, color2 = { 1, 0, 0, 0.2 }, direction = "down" }
tmp.strokeWidth = 4
tmp.stroke = { type = "gradient", color1 = { 0, 1, 0.4 }, color2 = { 0, 0, 1, 0.2 }, direction = "up" }
easyIFC:quickLabel( group, "6", 445, centerY + 100 )
