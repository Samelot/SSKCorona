-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015
-- =============================================================
local public = {}

-- =============================================================
-- init( group )
-- Code that needs to run before the sample can be executed goes here.
-- This is usually stuff like loading sprites, sound files, or prepping
-- data.
--
-- group - A display group for you to place any visual content into.
--         This group is managed for you and should not be destroyed by
--         your code.
-- =============================================================
function public.init( group )
	print("Did init @ ", system.getTimer() )
end

-- =============================================================
-- cleanup()
-- Any special cleanup code goes here.  
--
-- The module itself will be destroyed as well as all content rendered into
-- the group, so you don't need to do that.
-- =============================================================
function public.cleanup( )
	print("Did cleanup @ ", system.getTimer() )
	public.isRunning = false

	local physics = require("physics")
	physics.setDrawMode( "normal" )
	physics.stop()


end

-- =============================================================
-- run( group )
--
-- group - A display group for you to place any visual content into.
--         This group is managed for you and should not be destroyed by
--         your code. 
-- =============================================================
function public.run( group )

	public.isRunning = true		

	local physics = require("physics")
	physics.start()
	physics.setGravity(0,9.8)
	physics.setDrawMode( "hybrid" )

	-- Localizations
	local newCircle 	= ssk.display.newCircle
	local newRect 		= ssk.display.newRect
	local newImageRect 	= ssk.display.newImageRect
	local easyIFC   	= ssk.easyIFC
	local mRand 		= math.random

	local angle2Vector 		= ssk.math2d.angle2Vector
	local vector2Angle 		= ssk.math2d.vector2Angle
	local scaleVec 			= ssk.math2d.scale
	local addVec 			= ssk.math2d.add
	local subVec 			= ssk.math2d.sub
	local getNormals 		= ssk.math2d.normals
	local lenVec			= ssk.math2d.length
	local normVec			= ssk.math2d.normalize


	-- Locals
	--
	local moveSpeed = 200
	local circleColors = { _R_, _G_, _B_, _O_, _Y_ }	
	local circleRadius = { 18, 16, 10, 8, 6 }	


	-- Following listener
	--
	local function onEnterFrame( self )
		if( not public.isRunning ) then
			ignore( "enterFrame", self )
			return
		end

		local myNum = self.myNum
		local prior = self.priorCircle
		local vec = subVec( prior, self )
		vec = normVec( vec )
		vec = scaleVec( vec, 2 * circleRadius[myNum-1] + 2 )
		self.x = prior.x + vec.x
		self.y = prior.y + vec.y
	end

	-- Background to catch touches
	--
	local circles = {}
	local x = centerX
	local y = centerY
	for i = 1, 5 do
		if( i == 1 ) then
			circles[i] = newCircle( group, x, y, { radius = circleRadius[i], fill = circleColors[i] }  )
		else
			circles[i] = newCircle( group, x, y, { radius = circleRadius[i], fill = circleColors[i], myNum = i,  priorCircle = circles[i-1], enterFrame = onEnterFrame }  )			
		end
		x = x - 2 * circleRadius[i] + 2
		
	end

	-- Touch Listener (and mover)
	--
	local function onTouch( self, event )
		if( event.phase == "began" ) then
			-- Stop any current transitions
			-- 
			for i = 1, #circles do
				transition.cancel( circles[i] )
			end

			-- Calc distance First circle needs to move
			--
			local tvec = { x = event.x, y = event.y }
			local vec = subVec( tvec, circles[1] )
			local len = lenVec( vec )
			local time = 1000 * len / moveSpeed
			transition.to( circles[1], { x = tvec.x, y = tvec.y, time = time })
		end
		return true
	end

	local touchCatcher = newRect( group, centerX, centerY, { w = fullw, h = fullh, touch = onTouch, fill = _DARKERGREY_ } )
	touchCatcher:toBack()
end

-- =============================================================
-- More... add any additional functions you need below
-- =============================================================


-- =============================================================
-- Functions below this marker are optional.
-- They are used by the sampler to provide more details about the
-- sample and to do special sampler-only setup or cleanup.
-- =============================================================
function public.about()
	local altName = "Following Circles 2 (MAY 2015)"
	local description = 
	'<font size="16" color="SteelBlue">Following Circles 2(MAY 2015)</font><br><br><br>' ..
    'Second answer from this post: <a href = "http://bit.ly/ssk_following_circles">CLICK HERE</a><br><br>'
	
	local video = "" -- "https://www.youtube.com/watch?v=-nCESqeKXCY"

	return altName, description, video
end
function public.samplerSetup( group )
	print("Did sampler setup @ ", system.getTimer() )
end
function public.samplerCleanup( group )
	print("Did sampler cleanup @ ", system.getTimer() )
end

return public