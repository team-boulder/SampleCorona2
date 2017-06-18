local self = object.new()
local mime = require( "mime" )
local tonumber = tonumber


userInfoData = {}

function self.recognation( path )
	local function networkListener( e )
		-- print( e )
		if not e.isError then
			local data = json.decode( e.response )
			print(e.response)
		end
	end
	
	local headers = {}
	local body = {}
	headers["Authentication"] = mime.b64("e467fb30-ce6e-49b0-becf-0086a1cf62e3:MvCwVR7FVK3b")
 
	local params = {}
	local filePath = system.pathForFile( path, system.DocumentsDirectory)
	--body["path"] = system.DocumentsDirectory
	--body["filename"] = path
	--body["baseDirectory"] = system.DocumentsDirectoryS
	--print(filePath)
	--headers["Content-Type"] = "multipart/form-encoded"
	--params.headers = headers
	--params.body    = body
	params["rate"] = 1600
	--付加するパラメータ
	print("hoge2")
  	network.upload( 
    	"https://stream.watsonplatform.net/speech-to-text/api/v1/models/ja-JP_BroadbandModel/recognize?continuous=true", 
    	"POST", 
    	networkListener,
		path,
		system.DocumentsDirectory,
		"audio/wav"		
    )
end

return self