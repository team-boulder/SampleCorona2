local self = object.new()

local tonumber = tonumber

userInfoData = {}

function self.search( word )
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
	params['query']        = word
	-- params['transaction_id'] = transaction_id or tmp_id

	fnetwork.request( 'http://59.157.6.140/boulder/search.php', 'POST', networkListener, params )
end

return self