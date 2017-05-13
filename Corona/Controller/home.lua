--[[
@
@ Project  :
@
@ Filename : start.lua
@
@ Author   : Task Nagashige
@
@ Date     : 2015-10-10
@
@ Comment  : アプリ起動時に色々な情報を取ってきて起動の準備をするページ。
@            実態はスプラッシュが表示されているのみ
@
]]--

local scene = storyboard.newScene()

-- require view
local home_view = require( ViewDir .. 'home_view' )

local function viewHandler( event )
	if event.name == 'home_view-tap' then

		if event.value == 'shiba' then
			storyboard.gotoScene(ContDir..'shiba')
		end
		if event.value == 'natsu' then
			storyboard.gotoScene(ContDir..'natsu')
		end
		if event.value == 'kuma' then
			storyboard.gotoScene(ContDir..'kuma')
		end
		if event.value == 'mae' then
			storyboard.gotoScene(ContDir..'mae')
		end
		if event.value == 'block_tap' then
			if playerInfoData['block'] < block_model.current_limit then
				playerInfoData['block'] = playerInfoData['block'] + playerInfoData['pet_tap']
			end
		end
		--テスト用
		if event.value == 'full' then
			playerInfoData['block'] = block_model.current_limit
		end
		if event.value == 'reset' then
			playerInfoData['block_limit'] = 1000
			playerInfoData['block_speed'] = 10
			playerInfoData['block'] = 0
			playerInfoData['block_food'] = 20
			playerInfoData['spd'] = 1000
			playerInfoData['pet_tap'] = 1
			playerInfoData['block_evol'] = 500
		end
	end
end


function scene:createScene( event )
	local group = self.view
end

function scene:willEnterScene( event )
	local group = self.view

	sound.loopPlay(sound.home)
	--user_model:addEventListener( modelHandler )
	home_view:addEventListener( viewHandler )

	local view_obj = home_view.create()
	group:insert( view_obj )

end

function scene:enterScene( event )
	local group = self.view
end

function scene:exitScene( event )
	local group = self.view

	--user_model:removeEventListener( modelHandler )
	home_view:removeEventListener( viewHandler )

	home_view.destroy()

end

function scene:didExitScene( event )
	local group = self.view

end

function scene:destroyScene( event )
	local group = self.view
end


-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

scene:addEventListener( "didExitScene", scene )
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeAll() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene
