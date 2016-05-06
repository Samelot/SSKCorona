-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
-- Two Touch - Touch Pads Builder
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
local newRect           = ssk.display.rect
local inputHelper

local function destroy( self )
	display.remove(inputHelper)
	inputHelper = nil
	leftPressed = false
	rightPressed = false
	left = nil
	right = nil
end

local function destroy( self )
	if( self.left and self.left.key ) then 
		ignore("key", self.left)
		self.left.key = nil
	end
	if( self.right and self.right.key ) then 
		ignore("key", self.right)
		self.right.key = nil
	end
	display.remove(self)
end


local function sleep( self )
	self.sleeping = true
end


local function wake( self )
	self.sleeping = false
end




local function create( group, params )
	group 	= group or display.currentStage
	params 	= params or {}

	system.activate("multitouch")
	
	local debugEn 			= params.debugEn or false
	local leftFill			= params.leftFill or {0,0,1}
	local rightFill			= params.rightFill or {1,0,0}
	local alpha 			= params.alpha or debugEn and 0.25 or 0
	local leftEventName 	= params.leftEventName or "onTwoTouchLeft"
	local rightEventName 	= params.rightEventName or "onTwoTouchRight"
	local keyboardEn		= fnn(params.keyboardEn, false)	

	local function onTouch( self, event )
		local phase = event.phase

		if( self.parent.sleeping ) then return false end

		if( phase == "began" ) then
			self.isFocus = true
			display.currentStage:setFocus( event.target, event.id )
			if( debugEn ) then self:setFillColor( unpack( _W_ ) ) end


		elseif( self.isFocus ) then
			if( phase == "ended" or phase == "cancelled" ) then
				self.isFocus = false
				display.currentStage:setFocus( event.target, nil )
				if( debugEn ) then self:setFillColor( unpack( self.myFill ) ) end
			end
		end

		if( not( phase == "moved" and self.__lfc == ssk.__lfc ) ) then
			local newEvent = table.shallowCopy( event )
			newEvent.name = nil
			post(self.myEventName,newEvent)
		end
		self.__lfc = ssk.__lfc

		return false
	end

	inputHelper = display.newGroup()
	group:insert(inputHelper)

	inputHelper.left = newRect( inputHelper, centerX - fullw/4, centerY,
		{ w = fullw/2, h =  fullh, fill = leftFill, alpha = alpha, 
		  myEventName = leftEventName, touch = onTouch, myFill = leftFill, isHitTestable = true })

	inputHelper.right = newRect( inputHelper, centerX + fullw/4, centerY,
		{ w = fullw/2, h = fullh, fill = rightFill, alpha = alpha, 
		  myEventName = rightEventName, touch = onTouch, myFill = rightFill, isHitTestable = true })

	--left:addEventListener( "touch" )
	--right:addEventListener( "touch" )

	if(keyboardEn == true ) then		
		inputHelper.left.key = function( self, event )			
			if( inputHelper.sleeping ) then return false end
			--if(not self or self.removeSelf == nil) then
			if( event.keyName == "a" or event.keyName == "left" ) then
				local newEvent = table.deepCopy( event )
				if(event.phase == "down") then
					newEvent.phase = "began"
					newEvent.name = nil
					if( debugEn ) then self:setFillColor( unpack( _W_ ) ) end
					leftPressed = true
					post( leftEventName, newEvent )
				elseif(event.phase == "up") then
					newEvent.phase = "ended"
					newEvent.name = nil
					if( debugEn ) then self:setFillColor( unpack( self.myFill ) ) end
					leftPressed = false
					post( leftEventName, newEvent )
				end
			end
		end
		listen("key", inputHelper.left)
	end


	inputHelper.finalize = function( self )
		if( self.destroy ) then
			self:destroy()
		end
	end; inputHelper:addEventListener("finalize")

	if(keyboardEn == true ) then
		inputHelper.right.key = function( self, event )			
			--if(not self or self.removeSelf == nil) then
			if( event.keyName == "d" or event.keyName == "right" ) then
				local newEvent = table.deepCopy( event )
				if(event.phase == "down") then
					newEvent.phase = "began"
					newEvent.name = nil
					if( debugEn ) then self:setFillColor( unpack( _W_ ) ) end
					rightPressed = true
					post( rightEventName, newEvent )
				elseif(event.phase == "up") then
					newEvent.phase = "ended"
					newEvent.name = nil
					rightPressed = false
					if( debugEn ) then self:setFillColor( unpack( self.myFill ) ) end
					post( rightEventName, newEvent )
				end
			end
		end
		listen("key", inputHelper.right)
	end


	return inputHelper
end


local public = {}
public.create 		= create
return public