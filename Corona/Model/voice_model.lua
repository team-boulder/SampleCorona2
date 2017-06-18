local self = object.new()

local tonumber = tonumber

userInfoData = {}

function self.voice( voice )
	local function networkListener( event )
    	if ( event.isError ) then
       	 print( "Network error: ", event.response )
    	elseif ( event.phase == "ended" ) then
     	   print ( "Upload complete!" )
    	end
	end

	--local tmp_id = string.random( 10, '%l%d' )
	--付加するパラメータ
	local params = { 
		voice,
    	system.DocumentsDirectory, 
    	""
		}
	--params['query'] = voice
	-- params['transaction_id'] = transaction_id or tmp_id

	fnetwork.Upload( 'http://59.157.6.140/boulder/search.php', 'POST', networkListener,params )
end

return self