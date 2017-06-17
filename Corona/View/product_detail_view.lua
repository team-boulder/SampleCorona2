local self = object.new()
local anim = require("Plugin.anim.anim")
local widget = require( "widget" )

local obj = {}

local function onAccelerate( event )
    print( event.name, event.xGravity, event.yGravity, event.zGravity )
end

local themeColor = playerInfoData['theme_color']

function self.create(params)
	if obj.group == nil then
		obj.group = display.newGroup()
	end
	height = 0
	local url = params.url
	print(url)
    local image = params.image or display.newImageRect( ImgDir .. 'product_detail/NoImage.png', 512, 512)
    local name  = params.name  or "hoge"
	local price = params.price or 0
	local detail = params.detail or "ここに詳細の文が入ります.デジタル大辞泉 - 文章の用語解説 - 1 文を連ねて、まとまった思想・感情を表現したもの。主に詩に対して、散文をいう。2 文法で、文よりも大きな単位。一文だけのこともあるが、通常はいくつかの文が集まって、まとまった思想・話題を表現するもの。3 威儀"

	--if image.width > 512 then
	--	image:scale(0.5,0.5)
	--end

	obj.view = native.newWebView(0,100,_W,_H-100)
	obj.view:request(url)

    obj.bg = display.newRect(0,0,_W,_H)
    obj.bg:setFillColor(255)
	obj.bg.value = 'bg'
	obj.header = display.newRect(0,0,_W,100)
	obj.header:setFillColor(unpack(themeColor))
	--[[obj.back = display.newImage(ImgDir..'result/back.png',20,20)
	obj.back.value = 'back'
	obj.back:addEventListener("tap",self.tap)]]--
	obj.title = display.newImage(ImgDir..'home/amazon_logo01.png')
	obj.title:setReferencePoint(display.CenterReferencePoint)
	obj.title:scale(0.3,0.3)
	obj.title.x = _W/2+20
	obj.title.y = 50
	obj.back = display.newImageRect("back.png",800,800)
	obj.back:scale(0.06,0.06)
	obj.back.x = _W-30
	obj.back.y = 30
	obj.back.value = "back"
	obj.back:addEventListener("tap",self.tap)
	-- obj.title = display.newText('   甘zon',0,0,'Noto-Light.otf',35)
	-- obj.title:setReferencePoint(display.CenterReferencePoint)
	-- obj.title.x = _W/2
	-- obj.title.y = obj.header.height/2
    
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


	obj.p_name = display.newText(params.name,0,0,'Noto-Light.otf',35)
	obj.p_name:setReferencePoint(display.CenterReferencePoint)
	obj.p_name:setFillColor(0)
	obj.p_name.x = _W/2
	obj.p_name.y = height + obj.p_name.height / 2 + 20
	height = height + obj.p_name.height
	
	obj.image = display.newImage(params.num..".png",system.TemporaryDirectory)
	obj.image:setReferencePoint(display.CenterReferencePoint)
	obj.image.x = _W/2
	obj.image.y = height + obj.image.height / 2 + 30
	height = height + obj.image.height + 20
    
	obj.price = display.newText("¥"..price,0,0,'Noto-Light.otf',60)
	obj.price:setReferencePoint(display.CenterReferencePoint)
	obj.price:setFillColor(0)
	obj.price.x = _W/6
	obj.price.y = height + obj.price.height / 2 + 20
	height = height + obj.price.height
	
	obj.detail = native.newTextBox(0,0,512,200)
	obj.detail.text = params.description
	obj.detail:setReferencePoint(display.CenterReferencePoint)
	--obj.detail:setFillColor(0)
	obj.detail.x = _W/2
	obj.detail.y = height + obj.detail.height / 2 + 20
	height = height + obj.detail.height

	obj.scrollView:insert(obj.p_name)
	obj.scrollView:insert(obj.image)
	obj.scrollView:insert(obj.price)
	obj.scrollView:insert(obj.detail)

	obj.group:insert( obj.bg )
	obj.group:insert( obj.header )
	obj.group:insert( obj.title )
	obj.group:insert( obj.scrollView )
	--obj.group:insert( obj.view )
	obj.group:insert( obj.back )
	

    


    return obj.group
end

function self.destroy()
	print("asdfasdf")
	obj.view:removeSelf()
	-- obj.view.isVisible = false
	obj.view = nil
	if obj.group then
		local function remove()
			display.remove( obj.group )
			obj.group = nil
		end
		-- remove()
		transition.to( obj.group, { time = 200, alpha = 0, onComplete = remove } )
	end
end

function self.tap( e )
	local event =
	{
		name   = 'product_detail_view-tap',
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
