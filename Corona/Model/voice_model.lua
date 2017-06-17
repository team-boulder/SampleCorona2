local self = object.new()

local mime = require( "mime" )
local tonumber = tonumber


userInfoData = {}

function self.recognation()
	local function networkListener( e )
		-- print( e )
		if not e.isError then
			local data = json.decode( e.response )
			print(e.response)
		end
	end
	params = {}
	params["bodyType"] = "binary"
	--付加するパラメータ
	print("hoge")
  	network.upload( 
    	"http://59.157.6.140/boulder/upload.php", 
    	"POST", 
    	networkListener, 
    	"Model/HON2_22A.wav", 
    	"multipart/form-encoded"
    )

end

return self