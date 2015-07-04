if "simulator" == system.getInfo( "environment" ) then
	native.showAlert( "Build for device", "This plugin is not supported on the Corona Simulator, please build for an iOS device or Xcode simulator", { "OK" } )
end
 
-- Require the widget library
local widget = require( "widget" )
 
-- Use the iOS 7 theme for this sample
widget.setTheme( "widget_theme_android_holo_dark" )
 
-- This is the name of the native popup to show, in this case we are showing the "social" popup
local popupName = "facebook"
 
-- Display a background
local background = display.newImage( "images/smiley.png", display.contentCenterX, display.contentCenterY, true )
 
-- Display some text
local achievementText = display.newText
{
	text = "You saved the planet!\n\nTouch any of the buttons below to share your victory with your friends!",
	x = display.contentCenterX,
	y = 60,
	width = display.contentWidth - 20,
	height = 0,
	font = native.systemFontBold,
	fontSize = 18,
	align = "center",
}
 
-- Exectuted upon touching & releasing a widget button
local function onShareButtonReleased( event )
	local serviceName = event.target.id
	local isAvailable = native.canShowPopup( popupName, serviceName )
 
	-- If it is possible to show the popup
	if isAvailable then
		local listener = {}
		function listener:popup( event )
			print( "name(" .. event.name .. ") type(" .. event.type .. ") action(" .. tostring(event.action) .. ") limitReached(" .. tostring(event.limitReached) .. ")" )			
		end
 
		-- Show the popup
		native.showPopup( popupName,
		{
			service = serviceName, -- The service key is ignored on Android.
			message = "I saved the planet using the Corona SDK!",
			listener = listener,
			image = 
			{
				{ filename = "images/smiley.png", baseDir = system.ResourceDirectory },
			},
			url = 
			{ 
				"http://www.coronalabs.com",
			}
		})
	else
		if isSimulator then
			native.showAlert( "Build for device", "This plugin is not supported on the Corona Simulator, please build for an iOS/Android device or the Xcode simulator", { "OK" } )
		else
			-- Popup isn't available.. Show error message
			native.showAlert( "Cannot send " .. serviceName .. " message.", "Please setup your " .. serviceName .. " account or check your network connection (on android this means that the package/app (ie Twitter) is not installed on the device)", { "OK" } )
		end
	end
end
 
 
local shareButton = widget.newButton
{
	id = "share",
	left = 0,
	top = 0,
	width = 240,
	label = "Show Share Popup",
	onRelease = onShareButtonReleased,
}
shareButton.x = display.contentCenterX