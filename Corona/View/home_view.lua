--[[
@
@ Project  :
@
@ Filename : home_view.lua
@
@ Author   : Tomohiro Matsuo
@
@ Date     : 2015-10-10
@
]]--

local self = object.new()

local obj = {}

function self.create()
	if obj.group == nil then
		obj.group = display.newGroup()

		obj.bg = display.newRect(0,0,_W,_H)
		obj.bg:setFillColor(0)
		obj.grow = display.newText('夏山',_W-200,_H/2+300,'8bit.ttf',40)
		obj.grow.value = 'natsu'
		obj.shop = display.newText('芝',_W-200,_H/2+380,'8bit.ttf',40)
		obj.shop.value = 'shiba'
		--テスト用
		obj.reset = display.newText('熊川',_W-600,_H/2+380,'8bit.ttf',40)
		obj.reset.value = 'kuma'
		obj.full = display.newText('前原',_W-600,_H/2+300,'8bit.ttf',40)
		obj.full.value = 'mae'

		obj.grow:addEventListener('tap',self.tap)
		obj.shop:addEventListener('tap',self.tap)
		obj.reset:addEventListener('tap',self.tap)
		obj.full:addEventListener('tap',self.tap)

		obj.group:insert( obj.bg )
		obj.group:insert( obj.grow )
		obj.group:insert( obj.shop )
		obj.group:insert( obj.reset )
		obj.group:insert( obj.full )

		return obj.group
	end
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
		name   = 'home_view-tap',
		value  = e.target.value,
	}
	self:dispatchEvent( event )
	return true
end

return self
