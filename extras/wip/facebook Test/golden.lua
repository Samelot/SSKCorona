local json = require "json"
require "ssk.loadSSK"


-- Request user's access and refresh tokens
local requestCredentials = function(code)
	local params = {}
	params.body = string.format("code=%s&client_id=%s&client_secret=%s&redirect_uri=%s&grant_type=authorization_code", code, options.client_id, options.client_secret, options.redirect_uri)
	network.request( "https://accounts.google.com/o/oauth2/token", "POST", requestCredentialsCallback, params)
end


-- Listen to the httprequest google does on local ServerSocket
local redirectCallback =  function (request)
	-- Sample succes request
	-- GET /?code=4/lNorA-RhjdU87F7XfTV3ib8oeqOX.ItKgfHhj74fHshQV0ieZDAqsb31Aqui HTTP/1.1
	-- Sample error response
	-- GET /?error=access_denied HTTP/1.1

	-- Check if the returned request header contains a code or an error
	-- TODO: Check if this regexes are really working on all conditions on all kinds of users
	local errors = string.match(request, "GET /??error=([%w_/.=?]+)")
	local code = string.match(request, "GET /??code=([%w--_/.=?]+)")

	print(errors,code)

end

-- Starts a local TCP server to listen to Google redirect callback
local startServer = function()
	-- Create Socket
	local tcpServerSocket , err = socket.tcp()
	local backlog = 0

	-- Check Socket
	if tcpServerSocket == nil then
	return nil , err
	end

	-- Allow Address Reuse
	tcpServerSocket:setoption( "reuseaddr" , true )

	-- Bind Socket
	local res, err = tcpServerSocket:bind( "*" , "9006" )
	if res == nil then
	return nil , err
	end

	-- Check Connection
	res , err = tcpServerSocket:listen( backlog )
	if res == nil then
	return nil , err
	end

	local serverTimer = timer.performWithDelay(10, function() 
		tcpServerSocket:settimeout( 0 )
		client = tcpServerSocket:accept()
		if (client ~= nil) then
			ip, port = client:getpeername()
			print(">>>>>>>>>>>> Got connection from ".. ip .. " on port " .. port)

			local request, err = client:receive()
			if not err then
				--client:close()
				--timer.cancel(serverTimer)
				--redirectCallback(request)
				print("GOT REQUEST", request )
				native.cancelWebPopup()
			end
		end
	end, 0)
end

startServer()

local redirect = url_encode( "http://localhost:9006" )

local url = "https://www.facebook.com/v2.0/dialog/oauth?client_id=587740081284791&redirect_uri=http://localhost:9006"
--system.openURL( "https://www.facebook.com/v2.0/dialog/oauth?client_id=587740081284791&redirect_uri=" .. redirect .. "" )
--system.openURL( "https://www.facebook.com/v2.0/dialog/oauth?client_id=587740081284791&redirect_uri=http://localhost:9006" )


local function networkListener( event )
	table.print_r(event)

    if ( event.isError ) then
        print( "Network error!" )
    else
        print ( "RESPONSE: " .. event.response )
    end
end

-- Access Google over SSL:
--network.request( url, "POST", networkListener )

native.showWebPopup( url )  






