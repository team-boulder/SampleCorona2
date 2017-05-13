--[[
@
@ Project  : 
@
@ Filename : user_model.lua
@
@ Author   : Task Nagashige
@
@ Date     : 2015-06-23
@
@ Comment  : 課金に関するユーザー情報を保持。
@            ゲーム性に関する部分は持たない。持つのはidとtoken程度。
@
]]--

local self = object.new()

local tonumber = tonumber

userInfoData = {}

local function setCache( data )
	assert( data, 'Fatal Error : not found data' )

	local res = json.encode( data )
	writeText( __userInfoDataFile, res )
	local event = 
	{
		name = 'user_model-setCache',
		data = data
	}
	self:dispatchEvent( event )
end

local function initListener( e )
	if not e.isError then
		local data = json.decode( e.response )
		if data['result'] then
			setCache( data['profile'] )
			self.getCache()

			if data.ads_in_review == true then
				__isDeveloped = true
			else
				__isDeveloped = false
			end
			local event = 
			{
				name = 'user_model-initListener',
				type = data['type'],
				data = data['profile'],
			}
			self:dispatchEvent( event )

			self.setGrowthPoint({
				growth_point_f = data.growth_point_f,
				growth_point_w = data.growth_point_w,
				growth_point_p = data.growth_point_p,
				growth_point_l = data.growth_point_l,
				growth_point_d = data.growth_point_d
			})
		end
	end
end

-- ユーザーデータをプレイヤーデータに置き換え
local function setCacheFromServer( data )
	if data then
		
		playerInfo.setDataFromServer( data )

		if data['is_tested'] then
			__isTested = true
		end

		if data['recovery_per_sec'] and tonumber( data['recovery_per_sec'] ) then
			__recovery_per_sec = tonumber( data['recovery_per_sec'] )
		end

		if data['item'] then
			playerInfoData['crystal'] = tonumber( data['item'] )
		end
	end
end

-- ユーザーデータに書き込み
function self.setData( key, value )
	assert( key, 'Fatal error : not found key' )
	assert( value, 'Fatal error : not found value' )

	-- 不正な保存を防ぐ
	local is_key = false
	for k, v in pairs ( userInfoData ) do
		if k  == key then
			is_key = true
		end
	end

	assert( is_key, 'Fatal error : invalid key' )

	userInfoData[key] = value
	self:dispatchEvent( { name = 'user_model-setData', data = userInfoData } )
end

function self.recoverStamina()
	local function networkListener( e )
		-- print( e )
		if not e.isError then
			local data = json.decode( e.response )
			if data.result == 'success' then
				self:dispatchEvent( { name = 'user_model-recoverStamina', result = 'success', stamina = data.stamina } )
				if listener then
					listener()
				end
			else
				self:dispatchEvent( { name = 'user_model-recoverStamina', result = 'failure', reason = data.reason } )
			end
		end
	end

	local tmp_id = string.random( 10, '%l%d' )

	--付加するパラメータ
	local params = {}
	params['token']          = userInfoData.token
	params['user_id']        = userInfoData.id
	params['transaction_id'] = transaction_id or tmp_id

	fnetwork.request( urlBase .. 'user/recovery_stamina.php', 'POST', networkListener, params )
end

-- ユーザー名を設定する
function self.setName( name )
	-- print( name )
	local function networkListener( e )
		-- print( e )
		if not e.isError then
			local data = json.decode( e.response )
			if data['result'] == 'success' then
				if data['name'] and data['name'] ~= '' then
					playerInfo.set( 'name', data['name'] )
					setCache( userInfoData )
					self:dispatchEvent( { name = 'user_model-setName', phase = 'success', username = data['name'] } )
				end
			else
				if data['reason'] == 'invalid word' then
					self:dispatchEvent( { name = 'user_model-setName', phase = 'failure' } )
				end
			end
		end
	end
	--付加するパラメータ
	local params = {}
	params['token'] = userInfoData['token']
	params['uid']   = userInfoData['id']
	params['name']  = url_encode( name )

	fnetwork.request( urlBase .. 'user/update_name.php', 'POST', networkListener, params )	
end

function self.getCache()
	-- cacheから起動
	local cacheData = readText( __userInfoDataFile )
	if cacheData then
		local data = json.decode( cacheData )

		-- print( data )

		userInfoData['id']        = data['uid']
		userInfoData['token']     = data['token']
		-- 課金アイテム（魔法石）
		userInfoData['item']      = tonumber( data['item'] ) or 0
		userInfoData['login_num'] = tonumber( data['login_num'] )
		userInfoData['is_debug']  = data['is_debug']
		userInfoData['is_tested'] = data['is_tested']

		setCacheFromServer( data )

		local event = 
		{
			name = 'user_model-getCache',
			data = data
		}
		self:dispatchEvent( event )
	end
end

function self.register()

	--付加するパラメータ
	local params = {}
	params['app_ver'] = __app_ver or 1
	params['platform'] = system.getInfo( 'platformName' )
	params['model'] = system.getInfo( 'model' )
	params['platform_ver'] = system.getInfo( 'platformVersion' )
	if __device_id then
		params['__device_id'] = __device_id
	end

	fnetwork.request( urlBase .. 'user/register.php', 'POST', initListener, params )
end

function self.init( uid, token )

	-- cacheから起動
	local cacheData = readText( __userInfoDataFile )
	if cacheData then
		local data = {}
		data['result'] = 'success'
		data['profile'] = json.decode( cacheData )
		data['type'] = 'cacheData'

		local event = {}
		event.response = json.encode(data)
		initListener( event )
	end

	--付加するパラメータ
	local params = {}
	params['token'] = token
	params['uid'] = uid
	params['app_ver'] = __app_ver or 1
	params['platform'] = system.getInfo( 'platformName' )
	params['model'] = system.getInfo( 'model' )
	params['platform_ver'] = system.getInfo( 'platformVersion' )
	if __device_id then
		params['device_id'] = __device_id
	end

	fnetwork.request( urlBase .. 'user/init.php', 'POST', initListener, params )	
end

-- サスペンド解除時にリクエストを送る
function self.resume()
	if userInfoData and userInfoData['id'] and userInfoData['token'] then
		local function networkListener( e )
			if not e.isError then
				local data = json.decode( e.response )
				if data['result'] == 'success' then
					self:dispatchEvent( { name = 'user_model-resume', data = data } )
				end
			end
		end

		--付加するパラメータ
		local params = {}
		params['token']   = userInfoData['token']
		params['user_id'] = userInfoData['id']

		fnetwork.request( urlBase .. 'user/resume.php', 'POST', networkListener, params )	
	end
end

-----------------------------
-- 強化玉関連
-- キャラクターを育てるのに必要
-----------------------------

-- 強化玉をセットする
function self.setGrowthPoint(growth_point)
	for k, v in pairs(growth_point) do
		v = tonumber(v) or 0
		playerInfo.set( k, v)
	end
	local event = { growth_point = growth_point}
	Runtime:dispatchEvent( 'user_model-set_growth_point', event )
end


-- 強化玉取得
function self.getGrowthPoint(attribute)
	print(playerInfoData['growth_point_'..attribute])
	print(playerInfoData)

	return playerInfoData['growth_point_'..attribute]
end

local function handler( event )
	if event.name == 'user_model-time_is_money' then
		playerInfo.set( 'crystal', event.point )
	end
end
Runtime:addEventListener( 'user_model-time_is_money', handler )

return self