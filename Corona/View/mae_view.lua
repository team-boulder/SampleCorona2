local self = object.new()
local anim = require("Plugin.anim.anim")


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

    obj.back = display.newText('戻る',_W/2,_H-150,nil,50)
    obj.back:setReferencePoint(display.CenterReferencePoint)
    obj.back.x = _W/2
	obj.back.value = 'back'
	obj.back:addEventListener('tap',self.tap)
	
	obj.shiba = display.newText('芝',_W/2 + 100,_H-300,nil,50)
    obj.shiba:setReferencePoint(display.CenterReferencePoint)
    obj.shiba.value = 'shiba'
	obj.shiba:addEventListener('tap',self.tap)
    
	obj.kuma = display.newText('熊',_W/2 - 100,_H-300,nil,50)
    obj.kuma:setReferencePoint(display.CenterReferencePoint)
    obj.kuma.value = 'kuma'
	obj.kuma:addEventListener('tap',self.tap)

	obj.natsu = display.newText('夏',_W/2,_H-300,nil,50)
    obj.natsu:setReferencePoint(display.CenterReferencePoint)
    obj.natsu.value = 'natsu'
	obj.natsu:addEventListener('tap',self.tap)

	obj.text = display.newText('前原だよ！！', 0, _H-500, nil, 100)
	obj.text:setReferencePoint(display.CenterReferencePoint)
	obj.text.value = 'maehara'
	obj.text:addEventListener('tap',self.tap)
	anim.new(obj.text)


    obj.group:insert( obj.bg )
    obj.group:insert( obj.title )
    obj.group:insert( obj.back )
	obj.group:insert( obj.shiba )
	obj.group:insert( obj.kuma )
	obj.group:insert( obj.natsu )
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
		name   = 'mae_view-tap',
		value  = e.target.value,
	}
	self:dispatchEvent( event )
	return true
end

function self.puni()
	obj.text:punipuni()
end 

return self
