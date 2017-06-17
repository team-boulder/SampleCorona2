local self = object.new()
local anim = require("Plugin.anim.anim")
local widget = require( "widget" )

local obj = {}

local function onAccelerate( event )
    print( event.name, event.xGravity, event.yGravity, event.zGravity )
end

local themeColor = playerInfoData['theme_color']

function self.create()
	if obj.group == nil then
		obj.group = display.newGroup()
	end
	height = 0
	local params = {}
	
    local image = params.image or display.newImage( ImgDir .. 'product_detail/NoImage.png')
    local name  = params.name  or "hoge"
	local price = params.price or 0

    obj.bg = display.newRect(0,0,_W,_H)
    obj.bg:setFillColor(255)
	obj.header = display.newRect(0,0,_W,100)
	obj.header:setFillColor(unpack(themeColor))
	obj.title = display.newText('   甘zon',0,0,'Noto-Light.otf',35)
	obj.title:setReferencePoint(display.CenterReferencePoint)
	obj.title.x = _W/2
	obj.title.y = obj.header.height/2
	height = height + obj.header.height
    
	obj.scrollView = widget.newScrollView(
		{
        	top = obj.header.height,
        	left = 0,
        	width = _W,
        	height = _H,
        	scrollWidth = 60,
        	scrollHeight = 80
		})
	obj.scrollView:setIsLocked( true, "horizontal" )


	obj.p_name = display.newText("name",0,0,'Noto-Light.otf',35)
	obj.p_name:setReferencePoint(display.CenterReferencePoint)
	obj.p_name:setFillColor(0)
	obj.p_name.x = _W/2
	obj.p_name.y = height + obj.p_name.height / 2 + 20
	height = height + obj.p_name.height
	
	obj.image = image
	obj.image:setReferencePoint(display.CenterReferencePoint)
	obj.image.x = _W/2
	obj.image.y = height + obj.image.height / 2 + 30
	height = height + obj.image.height
    
	obj.price = display.newText(price,0,0,'Noto-Light.otf',35)
	obj.price:setReferencePoint(display.CenterReferencePoint)
	obj.price:setFillColor(0)
	obj.price.x = _W/2
	obj.price.y = height + obj.price.height / 2 + 20
	height = height + obj.price.height
	

	obj.group:insert( obj.bg )
	obj.group:insert( obj.header )
	obj.group:insert( obj.scrollView )
	obj.group:insert( obj.title )
    obj.group:insert( obj.p_name )
	obj.group:insert( obj.image )
    


    return obj.group
end

function self.destroy()
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
		name   = 'product_detail-tap',
		value  = e.target.value,
	}
	self:dispatchEvent( event )
	return true
end

function self.onComplete( event )
	local photo = event.target
	if (photo) then  
		photo.x = _W / 2
   		photo.y = _H / 2
		photo.width = _W * 0.8
		photo.height = _H * photo.width/_W * 0.8
   		obj.group:insert( photo )
   		print( "photo w,h = " .. photo.width .. "," .. photo.height )
	end
end


local function onGyroscopeDataReceived( event )
    -- Calculate approximate rotation traveled via delta time
    -- Remember that rotation rate is in radians per second
    local deltaRadians = event.xRotation * event.deltaTime
    local deltaDegrees = deltaRadians * (180/math.pi)
	print(deltaRadians)
	obj.text.rotation(event.xRotation)
end


function self.puni() 
	obj.text:stopAnim()
	obj.text:punipuni()
end 

return self