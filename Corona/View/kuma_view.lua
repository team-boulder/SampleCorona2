local self = object.new()

local on = 0
local time = 5000
local obj = {}
local options1 = 
{ 
    title = "ボルダリングジムbigfoot福岡店", 
    subtitle = "ロック クライミング ジム", 
    listener = markerListener1,
	-- imageFile = "boul1.png",
}

function self.create()
	if obj.group == nil then
		obj.group = display.newGroup()
	end

    obj.bg = display.newRect(0,0,_W,_H)
    obj.bg:setFillColor(255,255,255)
    obj.title = display.newText('付近のボルダリングジムはこちら',0,100,nil,40)
    obj.title:setReferencePoint(display.CenterReferencePoint)
	obj.title:setFillColor(0)
    obj.title.x = _W/2
    -- obj.title.value = 'back'

    -- obj.back = display.newText('戻る',_W/2,_H-200,nil,50)
    -- obj.back:setReferencePoint(display.CenterReferencePoint)
    -- obj.back.x = _W/2
    -- obj.back.value = 'Noback'
	-- anim.new(obj.back)
    -- -- obj.back.value = 'back'
	obj.back = display.newImageRect("back.png",800,800)
	obj.back:scale(0.06,0.06)
	obj.back.x = _W-30
	obj.back.y = 30
	-- obj.back = display.newRect(_W-60,10,50,50)
    obj.back:setReferencePoint(display.CenterReferencePoint)
	obj.back:setFillColor(128)
    obj.back.value = 'back'

    -- obj.ifback = display.newText('押しても戻りません',_W/2,_H-125,nil,50)
    -- obj.ifback:setReferencePoint(display.CenterReferencePoint)
	-- obj.ifback:setFillColor( 255, 0, 0)
    -- obj.ifback.x = _W/2
    -- obj.ifback.value = 'ifback'
	-- obj.ifback.isVisible = false
	-- anim.new(obj.ifback)
	-- obj.ifback:punipuni()
	-- transition.to( obj.rect, { time = time - playerInfoData['age'] * 2000, transition=easing.continuousLoop,x=(0), y=(0), iterations=-1, xScale=0.3, yScale=0.3} )
    -- obj.shop:addEventListener('tap',self.tap)
    obj.title:addEventListener('tap',self.tap)
    -- obj.rect:addEventListener('tap',self.tap)
    -- obj.title:addEventListener('tap',self.tap)
    obj.back:addEventListener('tap',self.tap)
    obj.group:insert( obj.bg )
    obj.group:insert( obj.title )
    obj.group:insert( obj.back )
	-- obj.group:insert( obj.rect )
	-- obj.group:insert( obj.ifback )

	obj.myMap = native.newMapView( 0, _H/2 - 220, _W, 500 )
	Runtime:addEventListener( "location", self.gpsHandler )
	--elf.locationHandler()

	obj.group:insert( obj.myMap )

    return obj.group
end

function self.gpsHandler( event )
	local latitude = event.latitude
	local longitude = event.longitude
	obj.myMap:setRegion( latitude, longitude, 0.02, 0.02 )
	Runtime:removeEventListener( "location", self.gpsHandler )
end

function self.locationHandler()
	-- local latitude = event.latitude
	-- local longitude = event.longitude
	local options1 = 
{ 
    title = "ボルダリングジムbigfoot福岡店", 
    subtitle = "ロック クライミング ジム", 
    listener = markerListener1,
	-- imageFile = "boul1.png",
}
	local options2 = 
{ 
    title = "ボルダリングジム・ホアホア", 
    subtitle = "ロック クライミング ジム", 
    listener = markerListener2,
	-- imageFile = "boul1.png",
}
	local options3 = 
{ 
    title = "ブラボークライミング福岡天神", 
    subtitle = "ロック クライミング ジム", 
    listener = markerListener3,
	-- imageFile = "boul1.png",
}
	local options4 = 
{ 
    title = "Mono Climbing Studio", 
    subtitle = "ロック クライミング ジム", 
    listener = markerListener4,
	-- imageFile = "boul1.png",
}

	-- if obj.markerID then
	-- 	obj.myMap:removeMarker( obj.markerID )
	-- end
	-- obj.markerID = obj.myMap:addMarker( 33.593716, 130.405979, options1 )
	obj.myMap:addMarker( 33.593716, 130.405979, options1 )
	obj.myMap:addMarker( 33.591188, 130.430758, options2 )
	obj.myMap:addMarker( 33.589241, 130.392957, options3 )
	obj.myMap:addMarker( 33.567811, 130.442033, options4 )
	-- obj.myMap:setRegion( 33.567811, 130.442033, 0.02, 0.02 )
	-- obj.myMap:setRegion( latitude, longitude, 0.02, 0.02 )
	print(latitude)
end

function self.destroy()
	Runtime:removeEventListener( "location", self.locationHandler )
	if obj.group then
		local function remove()
			display.remove( obj.group )
			obj.group = nil
		end
		transition.to( obj.group, { time = 200, alpha = 0, onComplete = remove } )
	end
end

function self.tap( e )
	local event =
	{
		name   = 'kuma_view-tap',
		value  = e.target.value,
	}
	self:dispatchEvent( event )
	return true
end

-- function self.puni()
-- 	obj.back:punipuni()
-- end

function self.reflesh()
	obj.ifback.isVisible = true
end 

-- local function puni()
-- end

-- Map marker listener function
-- local function markerListener(event)
--     print( "type: ", event.type )  -- event type
--     print( "markerId: ", event.markerId )  -- ID of the marker that was touched
--     print( "lat: ", event.latitude )  -- latitude of the marker
--     print( "long: ", event.longitude )  -- longitude of the marker
-- end

-- local latitude = display.newText( "-", 100, 50, native.systemFont, 16 )
-- local longitude = display.newText( "-", 100, 100, native.systemFont, 16 )
-- local altitude = display.newText( "-", 100, 150, native.systemFont, 16 )
-- local accuracy = display.newText( "-", 100, 200, native.systemFont, 16 )
-- local speed = display.newText( "-", 100, 250, native.systemFont, 16 )
-- local direction = display.newText( "-", 100, 300, native.systemFont, 16 )
-- local time = display.newText( "-", 100, 350, native.systemFont, 16 )
 
-- local locationHandler = function( event )
 
--     -- Check for error (user may have turned off location services)
--     if ( event.errorCode ) then
--         native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
--         print( "Location error: " .. tostring( event.errorMessage ) )
--     else
--         local latitudeText = string.format( '%.4f', event.latitude )
--         latitude.text = latitudeText
 
--         local longitudeText = string.format( '%.4f', event.longitude )
--         longitude.text = longitudeText
 
--         local altitudeText = string.format( '%.3f', event.altitude )
--         altitude.text = altitudeText
 
--         local accuracyText = string.format( '%.3f', event.accuracy )
--         accuracy.text = accuracyText
 
--         local speedText = string.format( '%.3f', event.speed )
--         speed.text = speedText
 
--         local directionText = string.format( '%.3f', event.direction )
--         direction.text = directionText
 
--         -- Note that 'event.time' is a Unix-style timestamp, expressed in seconds since Jan. 1, 1970
--         local timeText = string.format( '%.0f', event.time )
--         time.text = timeText
--     end
-- end

-- -- Create a native map view
-- -- Sometime later (following activation of device location hardware)
-- local options = 
-- { 
--     title = "Displayed Title", 
--     subtitle = "Subtitle text", 
--     listener = markerListener,
--     -- This will look in the resources directory for the image file
--     imageFile =  "someImage.png",
--     -- Alternatively, this looks in the specified directory for the image file
--     -- imageFile = { filename="someImage.png", baseDir=system.TemporaryDirectory }
-- }
-- local result, errorMessage = myMap:addMarker( 37.331692, -122.030456, options )
-- if ( result ) then
--     print( "Marker added" )
-- else
--     print( errorMessage )
-- end

return self
