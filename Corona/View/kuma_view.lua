local self = object.new()

local on = 0
local time = 5000
local obj = {}
function self.create()
	if obj.group == nil then
		obj.group = display.newGroup()
	end

    obj.bg = display.newRect(0,0,_W,_H)
    obj.bg:setFillColor(0)
    obj.title = display.newText('ショップ',0,50,nil,40)
    obj.title:setReferencePoint(display.CenterReferencePoint)
    obj.title.x = _W/2
    obj.title.value = 'shop'

    obj.back = display.newText('戻る',_W/2,_H-200,nil,50)
    obj.back:setReferencePoint(display.CenterReferencePoint)
    obj.back.x = _W/2
    obj.back.value = 'Noback'
	anim.new(obj.back)
    -- obj.back.value = 'back'
	obj.rect = display.newRect(_W-200,_H-200,200,100)
    obj.rect:setReferencePoint(display.CenterReferencePoint)
	obj.rect:setFillColor( math.random(0,255), math.random(0,255), math.random(0,255))
    obj.rect.value = 'rect'

    obj.ifback = display.newText('押しても戻りません',_W/2,_H-125,nil,50)
    obj.ifback:setReferencePoint(display.CenterReferencePoint)
	obj.ifback:setFillColor( 255, 0, 0)
    obj.ifback.x = _W/2
    obj.ifback.value = 'ifback'
	obj.ifback.isVisible = false
	anim.new(obj.ifback)
	obj.ifback:punipuni()
	print(playerInfoData['age'])
	print(time - playerInfoData['age'] * 2000) 
	transition.to( obj.rect, { time = time - playerInfoData['age'] * 2000, transition=easing.continuousLoop,x=(0), y=(0), iterations=-1, xScale=0.3, yScale=0.3} )
    -- obj.back:addEventListener('tap',self.tap)
    obj.rect:addEventListener('tap',self.tap)
    obj.title:addEventListener('tap',self.tap)
    obj.back:addEventListener('tap',self.tap)
    obj.group:insert( obj.bg )
    obj.group:insert( obj.title )
    obj.group:insert( obj.back )
	obj.group:insert( obj.rect )
	obj.group:insert( obj.ifback )

	Runtime:addEventListener( "location", self.locationHandler )

	obj.myMap = native.newMapView( 0, _H/2 - 220, _W, 500 )
	obj.group:insert( obj.myMap )

    return obj.group
end

function self.locationHandler( event )
	local latitude = event.latitude
	local longitude = event.longitude
	if obj.markerID then
		obj.myMap:removeMarker( obj.markerID )
	end
	obj.markerID = obj.myMap:addMarker( latitude,longitude)
	print(latitude)
	print(longitude)
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

function self.puni()
	obj.back:punipuni()
end

function self.reflesh()
	obj.ifback.isVisible = true
end 

local function puni()
end

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
