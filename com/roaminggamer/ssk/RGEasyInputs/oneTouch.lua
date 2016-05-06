-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
-- One Touch - Touch Pad Builder
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

local newRect   = ssk.display.rect


local function destroy( self )
	if( self.key ) then 
		ignore("key", self)
		self.key = nil
	end
	display.remove(self)
end

local function sleep( self )
	self.proxy.sleeping = true
end


local function wake( self )
	self.proxy.sleeping = false
end

local function getPressed( self )
	return self.proxy.pressed
end

local function create( group, params )
	group 	= group or display.currentStage
	params 	= params or {}

	local debugEn 		= params.debugEn or false
	local fill 			= params.fill or {1,0,0}
	local alpha 		= params.alpha or debugEn and 0.25 or 0
	local eventName 	= params.eventName or "onOneTouch"
	local keyboardEn	= fnn(params.keyboardEn, false)	
	local appleTVEn		= fnn(params.appleTVEn, false)	
	
	local function onTouch( self, event )
		local phase = event.phase

		if( self.sleeping ) then return false end

		if( phase == "began" ) then
			self.isFocus = true
			display.currentStage:setFocus( event.target, event.id )
			if( debugEn ) then self:setFillColor( unpack( _W_ ) ) end			

		elseif( self.isFocus ) then			
			if( phase == "ended" or phase == "cancelled" ) then
				self.isFocus = false
				display.currentStage:setFocus( event.target, nil )
				if( debugEn ) then self:setFillColor( unpack( fill ) ) end
			end
		end
		
		if( not( phase == "moved" and self.__lfc == ssk.__lfc ) ) then
			local newEvent = table.shallowCopy( event )
			newEvent.name = nil
			post(eventName,newEvent)
		end
		self.__lfc = ssk.__lfc
		return false
	end

	local inputHelper = display.newGroup()
	group:insert(inputHelper)

	local tmp = newRect( inputHelper, centerX, centerY,
		{ w = fullw, h = fullh, fill = fill, alpha = alpha, touch = onTouch, isHitTestable = true })

	inputHelper.proxy = tmp

	--tmp:addEventListener( "touch" )

	if(keyboardEn == true or appleTVEn == true ) then
		tmp.key = function( self, event )
			table.dump(event)

			if( self.sleeping ) then return false end

			if(not self or self.removeSelf == nil) then
				ignore("key", self)
				return
			end
			if( keyboardEn and ( event.keyName == "w" or event.keyName == "up" ) ) then
				local newEvent = table.deepCopy( event )
				if(event.phase == "down") then
					newEvent.phase = "began"
					newEvent.name = nil
					if( debugEn ) then self:setFillColor( unpack( _W_ ) ) end
					self.pressed = true
					post( eventName, newEvent )
				elseif(event.phase == "up") then
					newEvent.phase = "ended"
					newEvent.name = nil
					if( debugEn ) then self:setFillColor( unpack( fill ) ) end
					self.pressed	= false
					post( eventName, newEvent )
				end			
			end
			if( appleTVEn and ( event.keyName == "buttonZ" ) ) then
				local newEvent = table.deepCopy( event )
				if(event.phase == "down") then
					newEvent.phase = "began"
					newEvent.name = nil
					if( debugEn ) then self:setFillColor( unpack( _W_ ) ) end
					self.pressed = true
					post( eventName, newEvent )
					timer.performWithDelay( 100, function() self:setFillColor( unpack( fill ) ) end )
				end			
			end
		end
		listen("key", tmp)
	end	

	inputHelper.sleeping 	= false
	inputHelper.pressed  	= false

	inputHelper.destroy = destroy
	inputHelper.wake = wake
	inputHelper.sleep = sleep
	inputHelper.getPressed = getPressed

	return inputHelper
end


local public = {}
public.create 		= create
return public
