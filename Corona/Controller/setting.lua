local scene = storyboard.newScene()

-- require view
local setting_view = require( ViewDir .. 'setting_view' )

local function viewHandler( event )
	if event.name == 'setting_view-tap' then

		if event.value == 'back' then
			storyboard.gotoScene(ContDir..'result',{effect="slideRight" })
		end
		if event.value == 'rec' then
			local filePath = system.pathForFile( "newRecording.wav", system.DocumentsDirectory )
			r = media.newRecording( filePath )
			r:startRecording()
			print("recording")
			timer.performWithDelay( 1000,function()
				r:stopRecording()
				print("playing")
				media.playSound( "newRecording.wav" ,system.DocumentsDirectory)
			end)
		end
		if event.value == 'play' then
			media.playSound( "newRecording.wav" ,system.DocumentsDirectory)
		end
	end
end


function scene:createScene( event )
	local group = self.view
end

function scene:willEnterScene( event )
	local group = self.view

	setting_view:addEventListener( viewHandler )

	local view_obj = setting_view.create()
	group:insert( view_obj )

end

function scene:enterScene( event )
	local group = self.view
end

function scene:exitScene( event )
	local group = self.view

	setting_view:removeEventListener( viewHandler )

end

function scene:didExitScene( event )
	local group = self.view

end

function scene:destroyScene( event )
	local group = self.view
	setting_view.destroy()
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
