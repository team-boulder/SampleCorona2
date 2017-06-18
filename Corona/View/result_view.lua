local self = object.new()

local obj = {}
local tableData = {}
local imageNameArray = {}
-- local themeColor = {120,230,240}

local themeColor = playerInfoData['theme_color']
local headerSize = 200
local boxSize = 200

local function createContent(data)

	local group = display.newGroup()	
	local box = display.newRect(group,0,0,_W,boxSize)
	box:setStrokeColor(220)
	box.strokeWidth = 2
	local title = display.newText(group,data.name,210,50,_W-230,110,'Noto-Light.otf',25)
	title:setReferencePoint(display.CenterReferencePoint)
	title.y = box.height/3
	title:setFillColor(80)
	local price = display.newText(group,"¥"..data.price,210,50,'Noto-Medium.otf',35)
	price:setReferencePoint(display.CenterReferencePoint)
	price.y = box.height-45
	price:setFillColor(80)

	function box:touch(event)
		if event.phase == "began" then
			self:setFillColor(unpack(themeColor))
			timer.performWithDelay(100,function()
				self:setFillColor(255)
			end)
		end
	end
	box:addEventListener('touch')

	return group


end

function self.create(res)
	if obj.group == nil then
		obj.group = display.newGroup()
		if res == nil then res = {} end

		obj.contentNum = 0
		obj.title = display.newImage(ImgDir..'home/amazon_logo01.png')
		obj.title:setReferencePoint(display.CenterReferencePoint)
		obj.title:scale(0.3,0.3)
		obj.title.x = _W/2+20
		obj.title.y = 50
		obj.header = display.newRect(0,0,_W,headerSize)
		obj.header:setFillColor(unpack(themeColor))
		obj.header.value = 'header'
		obj.header:addEventListener( "tap",self.tap )
		obj.textBox = display.newRect(30,110,580,70)
		function obj.textBox:tap()
			obj.textField.isVisible = true
			obj.placeholder.isVisible = false
			native.setKeyboardFocus( obj.textField )
		end
		obj.textBox:addEventListener( "tap" )
		obj.placeholder = display.newText("検索キーワードを入力",130,125,_W-140,50,'Noto-Light.otf',25)
		obj.placeholder:setFillColor(50)
		obj.textField = native.newTextField(120,122,400,50)
		obj.textField.size = 35
		obj.textField.hasBackground = false
		obj.textField.isVisible = false
		obj.textField.font = native.newFont( 'Noto-Light.otf',25 )
		obj.textField:addEventListener( "userInput", textListener )
		obj.musi = display.newImage(ImgDir..'home/search.png')
		obj.musi:setReferencePoint(display.CenterReferencePoint)
		obj.musi:scale(0.07,0.07)
		obj.musi.x = 70
		obj.musi.y = 145
		
		--obj.searchButton = display.newImage(ImgDir .. 'result/ecalbt008_002.png',_W-100,5)
		--obj.searchButton.xScale = 3
		--obj.textField:setReferencePoint(display.CenterReferencePoint)
		--obj.textField.x = _W/2
		--obj.textField.y = obj.header.height/2
		obj.menu = display.newImage( ImgDir .. 'result/menu.png',20,35)
		obj.menuArea = display.newRect(0,0,150,100)
		obj.menuArea.value = 'menu'
		obj.menuArea.isVisible = false
		obj.menuArea.isHitTestable = true
		obj.menuArea:addEventListener('tap',self.tap)
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

		self.refreshTable(res)
		-- 連想配列から取り出してテーブルを作成
		
		
		--[[
		-- 追加ボタンの生成
		obj.addButton = display.newGroup()
		local circle = display.newCircle( obj.addButton, _W-100, _H-100, 50)
		local plus = display.newText( obj.addButton, '＋', 0, 0, nil, 70)
		plus:setReferencePoint(display.CenterReferencePoint)
		plus.x = circle.x
		plus.y = circle.y
		circle:setFillColor(unpack(themeColor))
		circle.fill.effect = "filter.bloom"
		circle.fill.effect.levels.white = 0.2
		circle.fill.effect.levels.black = 1.0
		circle.fill.effect.levels.gamma = 0.2

		
		obj.addButton:setReferencePoint(circle.x, circle.y)
		obj.addButton.anim = true
		obj.addButton.value = 'add'
		obj.addButton:addEventListener('tap',self.tap)

		--]]
		
		-- メニューを予め作成しておく
		obj.menuGroup = display.newGroup()
		obj.menuBG = display.newRect(0,0,_W,_H)
		obj.menuBG:setFillColor(0,0,0,150)
		obj.menuBG.alpha = 0
		obj.menuBG.value = 'menubg'
		obj.menuBG:addEventListener('tap',self.tap)
		obj.menuBG:addEventListener('touch',self.touch)
		obj.menuWindow = display.newRect(obj.menuGroup,0, 0, 400, _H)
		obj.menuWindow:setFillColor(240)
		obj.menuWindow.value = 'menuWindow'
		obj.menuWindow:addEventListener('tap',self.tap)
		obj.menuWindow:addEventListener('touch',self.touch)
		obj.menuHeader = display.newRect(obj.menuGroup,0,0,400,100)
		obj.menuHeader:setFillColor(unpack(themeColor))
		obj.menuWindow.value = 'menuHeader'
		obj.menuTitle = display.newText(obj.menuGroup,'設定',0,0,'Noto-Light.otf',35)
		obj.menuTitle:setReferencePoint(display.CenterReferencePoint)
		obj.menuTitle:setFillColor(100)
		obj.menuTitle.x = obj.menuWindow.x 
		obj.menuTitle.y = 50
		obj.menuSetting = display.newText(obj.menuGroup,'厳しめ',0,0,'Noto-Light.otf',35)
		obj.menuSetting:setReferencePoint(display.CenterReferencePoint)
		obj.menuSetting:setFillColor(100)
		obj.menuSetting.x = obj.menuWindow.x 
		obj.menuSetting.y = 180
		obj.menuSetting.value = 'setting'
		obj.menuSetting:addEventListener('tap',self.tap)

		obj.menuSetting2 = display.newText(obj.menuGroup,'甘め',0,0,'Noto-Light.otf',35)
		obj.menuSetting2:setReferencePoint(display.CenterReferencePoint)
		obj.menuSetting2:setFillColor(100)
		obj.menuSetting2.x = obj.menuWindow.x 
		obj.menuSetting2.y = 250
		obj.menuSetting2.value = 'setting2'
		obj.menuSetting2:addEventListener('tap',self.tap)

		obj.menuGroup.x = -400
		obj.menuGroup.alpha = 0

		--[[
		-- ポップアップウィンドウも予め作成しておく
		obj.popupGroup = display.newGroup()
		obj.bg = display.newRect(obj.popupGroup,0,0,_W,_H)
		obj.bg:setFillColor(0,0,0,150)
		obj.bg.value = 'bg'
		obj.bg:addEventListener('tap',self.tap)
		obj.bg:addEventListener('touch',self.touch)
		obj.popupWindow = display.newRect(obj.popupGroup,1/10*_W, 1/5*_H, 4/5*_W, 3/5*_H)
		obj.popupWindow:setFillColor(240)
		obj.popupWindow.value = 'popupWindow'
		obj.popupWindow:addEventListener('tap',self.tap)
		obj.popupWindow:addEventListener('touch',self.touch)
		obj.message = display.newText(obj.popupGroup,'ラベルを入力してください',0,0,'Noto-Light.otf',35)
		obj.message:setReferencePoint(display.CenterReferencePoint)
		obj.message:setFillColor(100)
		obj.message.x = obj.popupWindow.x 
		obj.message.y = obj.popupWindow.y - 200
		obj.textField = native.newTextField( 0,0, obj.popupWindow.width*0.8, 80 )
		obj.textField:setReferencePoint(display.CenterReferencePoint)
		obj.textField.x = obj.popupWindow.x 
		obj.textField.y = obj.popupWindow.y - 50
		obj.textField.isVisible = false
		obj.accept = display.newText(obj.popupGroup,'追加',0,0,'Noto-Medium.otf',35)
		obj.accept:setReferencePoint(display.CenterReferencePoint)
		obj.accept:setFillColor(unpack(themeColor))
		obj.accept.x = obj.popupWindow.x 
		obj.accept.y = obj.popupWindow.y + 200
		obj.accept.value = 'accept'
		obj.accept:addEventListener('tap',self.tap)
		obj.popupGroup:insert(obj.textField)
		obj.popupGroup.alpha = 0
		]]--

		obj.group:insert( obj.scrollView )
		obj.group:insert( obj.header )
		obj.group:insert( obj.title )
		obj.group:insert( obj.textBox )
		obj.group:insert( obj.placeholder )
		obj.group:insert( obj.musi )
		obj.group:insert( obj.menu )
		obj.group:insert( obj.menuArea )
		--obj.group:insert( obj.addButton )
		obj.group:insert( obj.menuBG )
		obj.group:insert( obj.menuGroup )
		--obj.group:insert( obj.popupGroup )

		return obj.group
	end
end

function self.refreshTable(res)

	if res ~= nil then
		if obj.scrollContent then
			display.remove(obj.scrollContent)
			obj.scrollContent = nil
		end
		obj.scrollContent = display.newGroup()

		for i,v in ipairs(res) do
			local box = createContent(v)
			box.y = headerSize + (i-1)*boxSize
			v.num = i
			box.value = v
			box:addEventListener('tap',self.tap)
			obj.scrollContent:insert(box)
			obj.contentNum = obj.contentNum + 1
		end
		obj.scrollView:insert(obj.scrollContent)

		local function networkListener(event)
			local i = string.match( event.response.filename, "(.+)\.png" )
			local image = display.newImage(obj.scrollContent,event.response.filename,system.TemporaryDirectory,30,headerSize+20 +(i-1)*boxSize)
		end
		for i,v in ipairs(res) do
			os.remove(system.pathForFile( i..".png", system.TemporaryDirectory))
			network.download(v.image,"GET",networkListener, i..".png",system.TemporaryDirectory)
		end
	end
end

function self.showMenu()
	transition.to( obj.menuGroup, { time = 150, alpha = 1, x = 0 } )
	transition.to( obj.menuBG, { time = 150, alpha = 1 } )
end

function self.hideMenu()
	transition.to( obj.menuGroup, { time = 150, alpha = 0, x = -400 } )
	transition.to( obj.menuBG, { time = 150, alpha = 0 } )
end

function self.showPopup()
	transition.to( obj.popupGroup, { time = 150, alpha = 1 } )
	obj.textField.isVisible = true
end

function self.hidePopup()
	transition.to( obj.popupGroup, { time = 150, alpha = 0 } )
	obj.textField.isVisible = false
end

function self.addLabel()
	local content = createContent(obj.textField.text)
	content.y = headerSize + obj.contentNum * boxSize
	content.value = 'temp'
	content.text = obj.textField.text
	content:addEventListener('tap',self.tap)
	obj.scrollView:insert(content)
	obj.contentNum = obj.contentNum + 1
	self.hidePopup()
	obj.textField.text = ''
end

function self.checkText()
	if obj.textField.text == '' then
		return false
    else
		return true
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

function self.touch( e )

	local event =
	{
		name   = 'result_view-touch',
		value  = e.target.value,
	}
	self:dispatchEvent( event )

	if e.target.value == 'bg' and e.target.value == 'popupWindow' then
		return false
    else
		return true
    end
end

function textListener(event)
	if ( event.phase == "began" ) then
        -- User begins editing "defaultField"
 
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        print( event.target.text )
		if obj.textField.text == "" then
			obj.placeholder.text = "検索キーワードを入力"
		else
			obj.placeholder.text = obj.textField.text
		end
		obj.textField.isVisible = false
		obj.placeholder.isVisible = true

		
		if event.phase == "submitted"  then
			local events = 
			{
				name = "result_view-search",
				value = event.target.text,
			}
			if obj.textField.text ~= "" then
				self:dispatchEvent(events)
			end
		end

 
    elseif ( event.phase == "editing" ) then
    
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
		name   = 'result_view-tap',
		value  = e.target.value,
	}
	if e.target.text then
		event['text'] = e.target.text
    end
	self:dispatchEvent( event )

	return true
end

return self
