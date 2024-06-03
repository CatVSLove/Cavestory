function camera:update()
	self:lookAt(player:getX(), player:getY())

	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()

	-- Left border
	if self.x < w/2 then
			self.x = w/2
	end

	-- Top border
	if self.y < h/2 then
			self.y = h/2
	end

	-- Get width/height of background
	local mapW = (testMap.width * testMap.tilewidth) * scale
	local mapH = (testMap.height * testMap.tileheight) * scale

	-- Right border
	if self.x > (mapW - w/2) then
			self.x = (mapW - w/2)
	end

	-- Bottom border
	if self.y > (mapH - h/2) then
			self.y = (mapH - h/2)
	end
end

function camera:shake(time, speed)
	--Body
end
