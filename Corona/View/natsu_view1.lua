local self = object.new()

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
	
	obj.image = display.newImage("Images/satoshi/tintin.png",300,400)
	obj.image:setReferencePoint(display.CenterReferencePoint)
	obj.image.x = _W/2
	obj.image.y = _H/2
	obj.image.value = 'image'
	obj.image:addEventListener('tap',self.tap)
    
    obj.group:insert( obj.bg )
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
		name   = 'natsu_view-tap1',
		value  = e.target.value,
	}
	self:dispatchEvent( event )
	return true
end

return self
