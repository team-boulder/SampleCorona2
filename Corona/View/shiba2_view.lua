local self = object.new()

local obj = {}
function self.create()
	if obj.group == nil then
		obj.group = display.newGroup()
	end

    obj.bg = display.newRect(0,0,_W,_H)
    obj.bg:setFillColor(0)
	--バナナくん
	obj.banana = display.newImage( ImgDir..'shiba/thinthin.png', _W/3, 400)
    obj.banana:scale(0.5,0.5)
    obj.banana.y = _H/4
	obj.b_text = display.newText('今夜どう？🍌',0,200,nil,35)
	obj.b_text.x = _W/4
	--あわびちゃん
	obj.awabi = display.newImage( ImgDir..'shiba/awabi.png', -_W/6, 400)
    obj.awabi:scale(0.5,0.5)
    obj.awabi.y = _H/2
	obj.a_text = display.newText('最低💔 近づかないで！',0,500,nil,35)
	obj.a_text.x = _W/1.6

	obj.b_text:setReferencePoint(display.CenterReferencePoint)
    obj.title = display.newText('おshibaのBanana_part2',0,50,nil,40)
    obj.title:setReferencePoint(display.CenterReferencePoint)
    obj.title.x = _W/2
    obj.back = display.newText('戻る',_W/2,_H-150,nil,50)
    obj.back:setReferencePoint(display.CenterReferencePoint)
    obj.back.x = _W/2
    obj.back.value = 'back'

    obj.back:addEventListener('tap',self.tap)
    obj.group:insert( obj.bg )
    obj.group:insert( obj.title )
    obj.group:insert( obj.back )
	obj.group:insert( obj.banana)
	obj.group:insert( obj.b_text)
	obj.group:insert( obj.awabi)
	obj.group:insert( obj.a_text)

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
		name   = 'shiba_view-tap',
		value  = e.target.value,
	}
	self:dispatchEvent( event )
	return true
end

return self
