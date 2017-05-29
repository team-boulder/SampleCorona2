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
		obj.header = display.newRect(0,0,_W,90)
		obj.header:setFillColor(120,230,240)
		obj.title = display.newText('   Coincheck',0,0,'Noto-Light.otf',35)
		obj.title:setReferencePoint(display.CenterReferencePoint)
		obj.title.x = _W/2
		obj.title.y = obj.header.height/2
		obj.scrollView = widget.newScrollView(
		{
        	top = 0,
        	left = 0,
        	width = _W,
        	height = _H,
        	scrollWidth = 60,
        	scrollHeight = 80
		})
		obj.scrollView:setIsLocked( true, "horizontal" )
		for i=0,20 do
			local box = display.newRect(obj.group,0,i*80+90,_W,80)
			function box:touch(event)
				print(event.phase)
				if event.phase == "began" then
					print('began')
					self:setFillColor(120,230,240)
					self.isFocus = true
					timer.performWithDelay(100,function()
						self:setFillColor(255)
					end)
				elseif self.isfocus then
					if event.phase == "ended" or event.phase == "cancelled" then
						print('end')
						self:setfillcolor(255)
						self.isfocus = false
					end
				end
			end
			box:setStrokeColor(220)
			box.strokeWidth = 2
			box:addEventListener('touch')
			obj.scrollView:insert(box)
		end
		obj.grow = display.newText('夏山',50,100,'Noto-Light.otf',35)
		obj.grow:setFillColor(0)
		obj.grow.value = 'natsu'
		obj.scrollView:insert(obj.grow)
		obj.shop = display.newText('芝',50,180,'Noto-Light.otf',35)
		obj.shop:setFillColor(0)
		obj.shop.value = 'shiba'
		obj.scrollView:insert(obj.shop)
		obj.reset = display.newText('熊川',50,260,'Noto-Light.otf',35)
		obj.reset:setFillColor(0)
		obj.reset.value = 'kuma'
		obj.scrollView:insert(obj.reset)
		obj.full = display.newText('前原',50,340,'Noto-Light.otf',35)
		obj.full:setFillColor(0)
		obj.full.value = 'mae'
		obj.scrollView:insert(obj.full)

		obj.grow:addEventListener('tap',self.tap)
		obj.shop:addEventListener('tap',self.tap)
		obj.reset:addEventListener('tap',self.tap)
		obj.full:addEventListener('tap',self.tap)

		obj.group:insert( obj.bg )
		obj.group:insert( obj.scrollView )
		obj.group:insert( obj.header )
		obj.group:insert( obj.title )

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
