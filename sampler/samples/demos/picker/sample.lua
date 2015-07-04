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
end

-- =============================================================
-- run( group )
--
-- group - A display group for you to place any visual content into.
--         This group is managed for you and should not be destroyed by
--         your code. 
-- =============================================================
function public.run( group )
	
	public.picker1(group)

	public.picker2(group)

	public.picker3(group)

end


-- =============================================================
-- More... add any additional functions you need below
-- =============================================================
function public.picker1( group )
	local picker = require "ssk.wip.easyPicker.easyPicker"

	-- Create some data to fill picker
	local pickerData = {}
	for i = 1, 100 do
		pickerData[i] = i
	end

	-- Simple callback to print current entry when spinner stops
	--
	local function dump( self )
		 local valOut, indexOut = self:getValue()
		 --print( valOut .. " @ index: " .. indexOut )
	end


	-- Choose a width and height for picker
	--
	local pickerW = 100
	local pickerH = 40

	-- Place picker in group for easy assembly and placement.
	--
	local pickerGroup = display.newGroup()
	group:insert( pickerGroup )	

	-- Position group to position picker
	--
	pickerGroup.x = centerX - 100
	pickerGroup.y = centerY - 50


	-- Create rectangle and make it into a picker
	--
	local aPicker = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	picker.create( pickerGroup, aPicker, 
	              { 
					onSpin 			= dump,
		 			entries 		= pickerData,
		 			entrySpacing 	= 22,
					fontSize 		= 18,
					fontColor 		= _K_,
					font 			= native.systemFont,
				   } )
		
	-- Spinner Overlay
	local overlay = display.newImageRect( pickerGroup, "ssk/wip/easyPicker/overlay1.png", pickerW, pickerH )

	local frame = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	frame:setFillColor(unpack(_T_))
	frame:setStrokeColor(unpack(_GREY_))
	frame.strokeWidth = 2
	aPicker:setValue( 50 )
end


function public.picker2( group )
	local picker = require "ssk.wip.easyPicker.easyPicker"

	-- Localizations
	local easyIFC   = ssk.easyIFC
	--easyIFC:quickLabel( group, "Each made with one line using SSK", centerX, centerY - 50 )

	-- Create some data to fill picker
	local pickerData = {}
	for i = 1, 100 do
		pickerData[i] = i
	end

	-- Simple callback to print current entry when spinner stops
	--
	local function dump( self )
		 local valOut, indexOut = self:getValue()
		 print( valOut .. " @ index: " .. indexOut )
	end

	-- Choose a width and height for picker
	--
	local pickerW = 100
	local pickerH = 40

	-- Left Picker
	--
	local pickerGroup = display.newGroup()
	group:insert( pickerGroup )	

	-- Position group to position picker
	--
	pickerGroup.x = centerX - 60
	pickerGroup.y = centerY + 50

	-- Create rectangle and make it into a picker
	--
	local leftPicker = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	picker.create( pickerGroup, leftPicker, 
	              { 
					onSpin 			= dump,
		 			entries 		= pickerData,
		 			entrySpacing 	= 22,
					fontSize 		= 18,
					fontColor 		= _K_,
					font 			= native.systemFont,
				   } )
		
	-- Spinner Overlay
	local overlay = display.newImageRect( pickerGroup, "ssk/wip/easyPicker/overlay1.png", pickerW, pickerH )

	local frame = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	frame:setFillColor(unpack(_T_))
	frame:setStrokeColor(unpack(_G_))
	frame.strokeWidth = 2
	leftPicker:setIndex( 15 )


	-- Right Picker
	--
	local pickerGroup = display.newGroup()
	group:insert( pickerGroup )	

	-- Position group to position picker
	--
	pickerGroup.x = centerX + 60
	pickerGroup.y = centerY + 50

	-- Create rectangle and make it into a picker
	--
	local rightPicker = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	picker.create( pickerGroup, rightPicker, 
	              { 
					onSpin 			= dump,
		 			entries 		= pickerData,
		 			entrySpacing 	= 22,
					fontSize 		= 18,
					fontColor 		= _K_,
					font 			= native.systemFont,
				   } )
		
	-- Spinner Overlay
	local overlay = display.newImageRect( pickerGroup, "ssk/wip/easyPicker/overlay1.png", pickerW, pickerH )

	local frame = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	frame:setFillColor(unpack(_T_))
	frame:setStrokeColor(unpack(_B_))
	frame.strokeWidth = 2


	-- Add copy and reset functionality
	local function onCopy( event )
		rightPicker:setValue( leftPicker:getValue() )
	end
	local function onReset( event )
		leftPicker:setIndex( 1 )
		rightPicker:setIndex( 1 )
	end
	easyIFC:presetPush( group, "default", centerX - 60, centerY + 100, 80, 30, "Copy", onCopy )
	easyIFC:presetPush( group, "default", centerX + 60, centerY + 100, 80, 30, "Reset", onReset )
end


function public.picker3( group )
	local picker = require "ssk.wip.easyPicker.easyPicker"

	-- Create some data to fill picker
	local pickerData = {}
	local letters = "abcdefghijklmnopqrstuvwxyz"
	for i = 1, letters:len() do
		pickerData[#pickerData+1] = string.format("images/letterBlocks/%s.png", letters:sub(i,i))
	end

	-- Simple callback to print current entry when spinner stops
	--
	local function dump( self )
		 local val, index = self:getValue()
		 print( "Letter: " .. letters:sub(index,index) )
	end


	-- Choose a width and height for picker
	--
	local pickerW = 40
	local pickerH = 80

	-- Make three side-by-side pickers
	--
	local pickerGroup = display.newGroup()
	group:insert( pickerGroup )	
	pickerGroup.x = centerX + 20
	pickerGroup.y = centerY - 50
	local aPicker = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	picker.create( pickerGroup, aPicker, 
	              { 
					onSpin 				= dump,
		 			entries 			= pickerData,
		 			entriesAreImages 	= true,
		 			imgW				= 32,
		 			imgH				= 32,
		 			entrySpacing 		= 10,
				   } )
		
	aPicker:setIndex( 19 )
	local pickerGroup = display.newGroup()
	group:insert( pickerGroup )	
	pickerGroup.x = centerX + 60
	pickerGroup.y = centerY - 50
	local aPicker = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	picker.create( pickerGroup, aPicker, 
	              { 
					onSpin 				= dump,
		 			entries 			= pickerData,
		 			entriesAreImages 	= true,
		 			imgW				= 32,
		 			imgH				= 32,
		 			entrySpacing 		= 10,
				   } )
		
	aPicker:setIndex( 19 )

	local pickerGroup = display.newGroup()
	group:insert( pickerGroup )	
	pickerGroup.x = centerX + 100
	pickerGroup.y = centerY - 50
	local aPicker = display.newRect( pickerGroup, 0, 0, pickerW, pickerH )
	picker.create( pickerGroup, aPicker, 
	              { 
					onSpin 				= dump,
		 			entries 			= pickerData,
		 			entriesAreImages 	= true,
		 			imgW				= 32,
		 			imgH				= 32,
		 			entrySpacing 		= 10,
				   } )
		
	aPicker:setIndex( 11 )


	local frame = display.newRect( group, centerX + 60, centerY - 50, pickerW * 3, pickerH )
	frame:setFillColor(unpack(_T_))
	frame:setStrokeColor(unpack(_O_))
	frame.strokeWidth = 2


end



-- =============================================================
-- Functions below this marker are optional.
-- They are used by the sampler to provide more details about the
-- sample and to do special sampler-only setup or cleanup.
-- =============================================================
function public.about()
	local altName = "Easy Picker"
	local description = ""
	return altName, description
end
function public.samplerSetup( group )
	print("Did sampler setup @ ", system.getTimer() )
end
function public.samplerCleanup( group )
	print("Did sampler cleanup @ ", system.getTimer() )
end

return public