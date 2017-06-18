local scene = storyboard.newScene()

-- require view
local result_view = require( ViewDir .. 'result_view' )
local search_model = require( ModelDir .. 'search_model' )
local voice_model = require( ModelDir .. 'voice_model' )

local function modelHandler( event )
	if event.name == 'search_model-search' then
		--print(event.data)
		result_view.refreshTable(event.data)
	end
end

local function viewHandler( event )
	if event.name == 'result_view-search' then
		search_model.search(event.value)
	end
	if event.name == 'result_view-tap' then

		if event.value.num then
			-- print("num"..event.value)
			storyboard.showOverlay(ContDir..'product_detail',{effect = "slideLeft",isModal = true,params = event.value })
		end
		if event.value == 'shiba' then
			storyboard.gotoScene(ContDir..'shiba',{effect="slideLeft"})
		end
		if event.value == 'natsu' then
			storyboard.gotoScene(ContDir..'natsu',{effect="slideLeft"})
		end
		if event.value == 'kuma' then
			storyboard.gotoScene(ContDir..'kuma',{effect="slideLeft"})
		end
		if event.value == 'mae' then
			storyboard.gotoScene(ContDir..'product_detail',{effect="slideLeft"})
		end
		if event.value == 'temp' then
			storyboard.showOverlay(ContDir..'temp',{effect="slideLeft",params = { title = event.text or 'temp' } })
		end
		if event.value == 'add' then
			result_view.showPopup()
		end
		if event.value == 'menu' then
			result_view.showMenu()
		end
		if event.value == 'menubg' then
			result_view.hideMenu()
		end
		if event.value == 'setting' then
			result_view.hideMenu()
			storyboard.gotoScene(ContDir..'setting',{effect="slideLeft" })
		end
		if event.value == 'setting2' then
			result_view.hideMenu()
			storyboard.gotoScene(ContDir..'setting',{effect="slideLeft" })
		end
		if event.value == 'bg' then
			result_view.hidePopup()
		end
		if event.value == 'rec' then
			local filePath = system.pathForFile( "newRecording.wav", system.DocumentsDirectory )
			r = media.newRecording( filePath )
			r:startRecording()
			print("recording")
			timer.performWithDelay( 3000,function()
			r:stopRecording()
			print("complete")
			print("playing")
			--media.playSound( "newRecording.wav" ,system.DocumentsDirectory)
			voice_model.recognation( "newRecording.wav" )
			print("hoge1")
			end)
			print("hoge3")
			
		end
		if event.value == 'accept' then
			local function onComplete( event )
				if ( event.action == "clicked" ) then
					local i = event.index
					if ( i == 1 ) then
						result_view.addLabel()
					end
				end
			end
			if result_view.checkText() then
				native.showAlert( "確認", "本当に追加しますか", { "OK", "キャンセル" }, onComplete )
            else
				native.showAlert( "警告", "入力欄が空白です", { "OK" })
			end
		end
	end
end


function scene:createScene( event )
	local group = self.view
end

function scene:willEnterScene( event )
	local group = self.view

	search_model:addEventListener( modelHandler )
	result_view:addEventListener( viewHandler )

	local view_obj = result_view.create()
	group:insert( view_obj )

end

function scene:enterScene( event )
	local group = self.view
	search_model.search("人気")
end

function scene:exitScene( event )
	local group = self.view

	search_model:removeEventListener( modelHandler )
	result_view:removeEventListener( viewHandler )

end

function scene:didExitScene( event )
	local group = self.view

end

function scene:destroyScene( event )
	local group = self.view
	result_view.destroy()
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
