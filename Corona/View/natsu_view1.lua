local self = object.new()
local playerInfo = require( ContDir .. 'playerInfo')

local obj = {}
function self.create()
	if obj.group == nil then
		obj.group = display.newGroup()
	end

    obj.bg = display.newRect(0,0,_W,_H)
    obj.bg:setFillColor(0)

	obj.back = display.newText('戻る',_W/2,_H-150,nil,50)
    obj.back:setReferencePoint(display.CenterReferencePoint)
    obj.back.x = _W/2
    obj.back.value = 'back'
	obj.back:addEventListener('tap',self.tap)
	
	obj.image = display.newImageRect("Images/satoshi/tintin.png",300,400)
	obj.image:setReferencePoint(display.CenterReferencePoint)
	obj.image.x = _W/2
	obj.image.y = _H/2
	obj.image.value = 'image'
	obj.image:addEventListener('tap',self.tap)

	obj.whiteimage = display.newImageRect("Images/satoshi/white.png",200,200)
	obj.whiteimage:setReferencePoint(display.CenterReferencePoint)
	obj.whiteimage.x = _W/2
	obj.whiteimage.y = 200
	obj.whiteimage.value = 'whiteimage'
	obj.whiteimage.alpha = 0.1 * playerInfoData['test']
	obj.whiteimage:addEventListener('tap',self.tap)
	

	obj.text = display.newText("↑画像タップしてね",0,0,nil,40)
	obj.text.x = _W/2
	obj.text.y = _H/2 + 300
	obj.text.value = 'text'
    
    obj.group:insert( obj.bg )
	obj.group:insert( obj.back)
	obj.group:insert( obj.image )
	obj.group:insert( obj.whiteimage )
	obj.group:insert( obj.text )

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
		name   = 'natsu_view-tap1',
		value  = e.target.value,
	}
	self:dispatchEvent( event )
	return true
end

function self.refresh(tapCount)
	obj.whiteimage.alpha = obj.whiteimage.alpha + 0.1
	print(tapCount)
	if tapCount == 10 then
		obj.whiteimage.alpha = 0
		--timer.performWithDelay(100, listener )
	end
end

--Timer処理がうまく動きません。
local function listener(event)
	print("timer")
	obj.whiteimage.alpha = 0
end


return self
