local self = object.new()

local obj = {}
local tableData = {
	{ label = '夏山', value = 'natsu' },
	{ label = '芝',   value = 'shiba' },
	{ label = '熊川', value = 'kuma' },
	{ label = '前原', value = 'mae' },
}

local function createContent(str)
	local group = display.newGroup()
	local box = display.newRect(group,0,0,_W,80)
	box:setStrokeColor(220)
	box.strokeWidth = 2
	local text = display.newText(group,str,50,0,'Noto-Light.otf',35)
	text:setReferencePoint(display.CenterReferencePoint)
	text.y = box.height/2
	text:setFillColor(0)
	function box:touch(event)
		print(event.phase)
		if event.phase == "began" then
			self:setFillColor(120,230,240)
			timer.performWithDelay(100,function()
				self:setFillColor(255)
			end)
		end
	end
	box:addEventListener('touch')
	return group
end

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

		for i,v in ipairs(tableData) do
			obj[v.value] = createContent(v.label)
			obj[v.value].y = 90 + (i-1)*80
			obj[v.value].value = v.value
			obj[v.value]:addEventListener('tap',self.tap)
			obj.scrollView:insert(obj[v.value])
		end
		-- for i=0,20 do
		-- 	local box = display.newRect(obj.group,0,i*80+90,_W,80)
		-- 	function box:touch(event)
		-- 		print(event.phase)
		-- 		if event.phase == "began" then
		-- 			self:setFillColor(120,230,240)
		-- 			timer.performWithDelay(100,function()
		-- 				self:setFillColor(255)
		-- 			end)
		-- 		end
		-- 	end
		-- 	box:setStrokeColor(220)
		-- 	box.strokeWidth = 2
		-- 	box:addEventListener('touch')
		-- 	obj.scrollView:insert(box)
		-- end
		-- obj.natsu = display.newText('夏山',50,100,'Noto-Light.otf',35)
		-- obj.natsu:setFillColor(0)
		-- obj.natsu.value = 'natsu'
		-- obj.scrollView:insert(obj.natsu)
		-- obj.shiba = display.newText('芝',50,180,'Noto-Light.otf',35)
		-- obj.shiba:setFillColor(0)
		-- obj.shiba.value = 'shiba'
		-- obj.scrollView:insert(obj.shiba)
		-- obj.kuma = display.newText('熊川',50,260,'Noto-Light.otf',35)
		-- obj.kuma:setFillColor(0)
		-- obj.kuma.value = 'kuma'
		-- obj.scrollView:insert(obj.kuma)
		-- obj.mae = display.newText('前原',50,340,'Noto-Light.otf',35)
		-- obj.mae:setFillColor(0)
		-- obj.mae.value = 'mae'
		-- obj.scrollView:insert(obj.mae)

		-- obj.natsu:addEventListener('tap',self.tap)
		-- obj.shiba:addEventListener('tap',self.tap)
		-- obj.kuma:addEventListener('tap',self.tap)
		-- obj.mae:addEventListener('tap',self.tap)

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
		remove()
		-- transition.to( obj.group, { time = 200, alpha = 0, onComplete = remove } )
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
