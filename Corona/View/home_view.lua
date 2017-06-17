--local anim = require("Plugin.anim.anim")
local self = object.new()

local obj = {}
local TextColor = {0,0,0}

local themeColor = {255,255,255}
local themeColor2 = {0,0,0}
--playerInfoData['theme_color']
local headerSize = 150

function self.create()
	if obj.group == nil then
		obj.group = display.newGroup()

		-- tytle
		--obj.BG = require( ViewDir .. 'background' )
		--obj.bg = obj.BG.create()
		obj.background = display.newRect(0,0,_W,_H)
		obj.background:setFillColor(unpack(themeColor))
		obj.header = display.newRect(0,0,_W,headerSize)
		obj.header:setFillColor(unpack(themeColor2))
		obj.head_con = display.newImage(ImgDir..'home/icon.png')
		obj.head_con:setReferencePoint(display.CenterReferencePoint)
		obj.head_con:scale(0.3,0.3)
		obj.head_con.x = _W/5
		obj.head_con.y = _H/15
		--obj.header.isVisible = false
		obj.title = display.newImage(ImgDir..'home/amazon_logo01.png')
		obj.title:setReferencePoint(display.CenterReferencePoint)
		obj.title:scale(0.65,0.65)
		obj.title.x = _W/2
		obj.title.y = _H/2-100

		obj.serch = native.newTextField(0,0,3*_W/4-25,80)
		obj.serch:setTextColor( 0.8, 0.8, 0.8 )
		obj.serch.hasBackground = false
		obj.serch.size = 32
		-- Resize the text field height to fit the font
		obj.serch:resizeHeightToFitFont()
		obj.serch.text = "検索ワードを入力してください"
		obj.serch.x = _W/2
		obj.serch.y = _H/2 + 50
		--anim.new(obj.title)
		--obj.title:punipuni()

		obj.musi = display.newImage(ImgDir..'home/musi.png')
		obj.musi:setReferencePoint(display.CenterReferencePoint)
		obj.musi:scale(0.07,0.07)
		obj.musi.x = 3*_W/4 +100
		obj.musi.y = _H/2+50

		-- local sheetOptions = {
		-- 	width = 512,
		-- 	height = 256,
		-- 	numFrames = 8
		-- }
		-- obj.cat = graphics.newImageSheet( ImgDir.."home/cat.png", sheetOptions )
		-- obj.title = display.newText('Season of チャリ走',0,0,'Noto-Midium.otf',60)
		-- obj.title:setReferencePoint(display.CenterReferencePoint)
		-- obj.title.x = _W/2
		-- obj.title.y = _H/5 + headerSize/3
		-- obj.title:setFillColor(unpack(TextColor))
		-- obj.title2 = display.newText('~Presented team Boulder~',0,0,'Noto-Midium.otf',40)
		-- obj.title2:setReferencePoint(display.CenterReferencePoint)
		-- obj.title2.x = _W/2
		-- obj.title2.y = _H/5 + headerSize*2/3
		-- obj.title2:setFillColor(unpack(TextColor))


		-- Startボタンの生成
		--obj.startButton = display.newGroup()
		--local circle = display.newCircle( obj.startButton, _W-150, _H-150, 100)
		--local plus = display.newText( obj.startButton, 'Start', 0, 0, nil, 70)
		--plus:setReferencePoint(display.CenterReferencePoint)
		--plus.x = circle.x
		--plus.y = circle.y
		--circle:setFillColor(255,50,50)
		--circle.fill.effect = "filter.bloom"
		--circle.fill.effect.levels.white = 0.2
		--circle.fill.effect.levels.black = 1.0
		--circle.fill.effect.levels.gamma = 0.2
		--obj.startButton:setReferencePoint(circle.x, circle.y)
		--obj.startButton.anim = true
		--obj.startButton.value = 'start'
		--obj.startButton:addEventListener('tap',self.tap)

		obj.group:insert( obj.background )
		obj.group:insert( obj.header )
		obj.group:insert( obj.head_con )
		obj.group:insert( obj.title )
		obj.group:insert( obj.serch )
		obj.group:insert( obj.musi )
		--obj.group:insert( obj.max )
		-- obj.group:insert( obj.title3 )
		--obj.group:insert( obj.startButton )

		return obj.group
	end
end


function self.destroy()
	obj.BG.destroy()
	if obj.group then
		local function remove()
			display.remove( obj.group )
			obj.group = nil
		end
		remove()
		-- transition.to( obj.group, { time = 200, alpha = 0, onComplete = remove } )
	end
end

function self.touch( e )

	local event =
	{
		name   = 'home_view-touch',
		value  = e.target.value,
	}
	self:dispatchEvent( event )

	if e.target.value == 'bg' and e.target.value == 'popupWindow' then
		return false
    else
		return true
    end
end

function self.tap( e )

	if e.target.anim then
		transition.to(e.target,{
			time=100,
			xScale=0.8,
			yScale=0.8,
			transition=easing.continuousLoop
		})
	end

	local event =
	{
		name   = 'home_view-tap',
		value  = e.target.value,
	}
	if e.target.text then
		event['text'] = e.target.text
    end
	self:dispatchEvent( event )

	if e.target.value == 'bg' and e.target.value == 'popupWindow' then
		return false
    else
		return true
    end
end

return self
