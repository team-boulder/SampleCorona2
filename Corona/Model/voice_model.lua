local self = object.new()

local tonumber = tonumber

userInfoData = {}

function self.check( word )
	local function networkListener( e )
		-- print( e )
		if not e.isError then
			local data = json.decode( e.response )
			print(data)
			if data.result == 'success' then
				self:dispatchEvent( { name = 'user_model-recoverStamina', result = 'success', data = data } )
			else
				self:dispatchEvent( { name = 'user_model-recoverStamina', result = 'failure', data = data } )
			end
		end
	end

	local tmp_id = string.random( 10, '%l%d' )

	--付加するパラメータ
	local params = {}
	params['page']        = page
	-- params['transaction_id'] = transaction_id or tmp_id

	fnetwork.request( 'https://stream.watsonplatform.net/speech-to-text/api/v1/recognize', 'POST', networkListener, params )
end

return self