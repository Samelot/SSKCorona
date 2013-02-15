-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2013 
-- =============================================================
-- SSKCorona Sampler Main Menu
-- =============================================================
-- Short and Sweet License: 
-- 1. You may use anything you find in the SSKCorona library and sampler to make apps and games for free or $$.
-- 2. You may not sell or distribute SSKCorona or the sampler as your own work.
-- 3. If you intend to use the art or external code assets, you must read and follow the licenses found in the
--    various associated readMe.txt files near those assets.
--
-- Credit?:  Mentioning SSKCorona and/or Roaming Gamer, LLC. in your credits is not required, but it would be nice.  Thanks!
--
-- =============================================================
--
-- =============================================================

local storyboard = require( "storyboard" )
local scene      = storyboard.newScene()

--local debugLevel = 1 -- Comment out to get global debugLevel from main.cs
local dp = ssk.debugPrinter.newPrinter( debugLevel )
local dprint = dp.print

----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
-- Variables
local enableMultiplayer = true
local screenGroup
local layers -- Local reference to display layers 
local objs

local mode

-- Callbacks/Functions
local createLayers
local addInterfaceElements

local onOK
local onCancel
local onUsername
----------------------------------------------------------------------
--	Scene Methods:
-- scene:createScene( event )  - Called when the scene's view does not exist
-- scene:willEnterScene( event ) -- Called BEFORE scene has moved onscreen
-- scene:enterScene( event )   - Called immediately after scene has moved onscreen
-- scene:exitScene( event )    - Called when scene is about to move offscreen
-- scene:didExitScene( event ) - Called AFTER scene has finished moving offscreen
-- scene:destroyScene( event ) - Called prior to the removal of scene's "view" (display group)
-- scene:overlayBegan( event ) - Called if/when overlay scene is displayed via storyboard.showOverlay()
-- scene:overlayEnded( event ) - Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
----------------------------------------------------------------------
function scene:createScene( event )
	screenGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willEnterScene( event )
	screenGroup = self.view

	mode = event.params.mode

	createLayers()
	addInterfaceElements()
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:enterScene( event )
	screenGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:exitScene( event )
	screenGroup = self.view	
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didExitScene( event )
	screenGroup = self.view

	-- Close the keyboard if it is open
	native.setKeyboardFocus( nil )

	-- Remove the player name input field
	if( objs.playerNameField ) then
		objs.playerNameField:removeSelf()
	end

	-- Clear all references to objects we created in 'createScene()' (or elsewhere).
	layers:destroy()
	layers = nil
	objs = {}

end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:destroyScene( event )
	screenGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:overlayBegan( event )
	screenGroup = self.view
	local overlay_name = event.sceneName  -- name of the overlay scene
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:overlayEnded( event )
	screenGroup = self.view
	local overlay_name = event.sceneName  -- name of the overlay scene
end

----------------------------------------------------------------------
--				FUNCTION/CALLBACK DEFINITIONS						--
----------------------------------------------------------------------
-- createLayers() - Create layers for this scene
createLayers = function( )
	layers = ssk.display.quickLayers( screenGroup, "background", "playerList", "interfaces" )
end

-- addInterfaceElements() - Create interfaces for this scene
addInterfaceElements = function( )

	objs = {} 

	-- Background Image
	objs.backImage   = ssk.display.backImage( layers.background, "protoBack2.png" ) 

	-- ==========================================
	-- Buttons and Labels
	-- ==========================================
	local curY = 25
	local tmpButton
	local tmpLabel

	-- Page Title 
	if( mode == "new") then
		ssk.labels:presetLabel( layers.interfaces, "default", "New Player", centerX, curY, { fontSize = 24 } )
	else
		ssk.labels:presetLabel( layers.interfaces, "default", "Rename Player", centerX, curY, { fontSize = 24 } )
	end

	-- Player Name Input Field
	curY = curY + 35
	objs.playerNameField     = native.newTextField( 0,0, 200, 50 )
	layers.interfaces:insert(objs.playerNameField)
	objs.playerNameField:setReferencePoint( display.CenterReferencePoint )
	objs.playerNameField.x = centerX
	objs.playerNameField.y = curY
	objs.playerNameField.font  = native.newFont( native.systemFontBold, 14 )
	objs.playerNameField:addEventListener( "userInput", onUsername )
	--native.setKeyboardFocus( objs.playerNameField )

	if(mode == "rename") then
		objs.playerNameField.text = currentPlayer.name
	end

	-- OK
	curY = curY + 55
	ssk.buttons:presetPush( layers.interfaces, "default", centerX - 50 , curY, 90, 30,  "OK", onOK )
	ssk.buttons:presetPush( layers.interfaces, "default", centerX + 50 , curY, 90, 30,  "Cancel", onCancel )
		
end	

onOK = function ( event ) 

	local tmpName = objs.playerNameField.text or ""
	local newUserName = ""

	for aTok in tmpName:gmatch("%S+") do
		print(aTok)
		newUserName = newUserName .. aTok
	end

	for k,v in pairs( knownPlayers ) do
		if (v == newUsername) then
			newUserName = nil
			break
		end
	end

	if( newUserName ) then

		-- NEW PLAYER
		if(mode == "new") then
			currentPlayer.name = newUserName
			initDefaults()
			knownPlayers[currentPlayer.name] = currentPlayer.name
			saveCurrentPlayer()
			saveKnownPlayers()

		-- RENAME PLAYER
		else
			knownPlayers[currentPlayer.name] = nil
			currentPlayer.name = newUserName
			knownPlayers[currentPlayer.name] = currentPlayer.name
			saveCurrentPlayer()
			saveKnownPlayers()
		end
	end

	local options =
	{
		effect = "fade",
		time = 200,
		params =
		{
			logicSource = nil
		}
	}

	native.setKeyboardFocus( nil )

	storyboard.gotoScene( "interfaces.NotMe", options  )	

	return true
end

onCancel = function ( event ) 
	local options =
	{
		effect = "fade",
		time = 200,
		params =
		{
			logicSource = nil
		}
	}

	storyboard.gotoScene( "interfaces.NotMe", options  )	

	return true
end

onUsername = function ( event )

	if ( "began" == event.phase ) then
		-- This is the "keyboard has appeared" event
		-- In some cases you may want to adjust the interface when the keyboard appears.
	
	elseif ( "ended" == event.phase ) then
		-- This event is called when the user stops editing a field: for example, when they touch a different field
	
	elseif ( "submitted" == event.phase ) then
		-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
		onOk()
	end

end



---------------------------------------------------------------------------------
-- Scene Dispatch Events, Etc. - Generally Do Not Touch Below This Line
---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "willEnterScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "didExitScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "overlayBegan", scene )
scene:addEventListener( "overlayEnded", scene )
---------------------------------------------------------------------------------

return scene
