--Extra functions for the camera


camera.lock = true

function camera:update()
	self:lookAt(player:getX(), player:getY())

	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()

	if self.lock then
		-- Left border
		if self.x < (w / 2) / scale then
				self.x = (w / 2) / scale
		end

		-- Top border
		if self.y < (h / 2) / scale then
				self.y = (h / 2) / scale
		end

		-- Get width/height of background
		local mapW = (testMap.width * testMap.tilewidth) * scale
		local mapH = (testMap.height * testMap.tileheight) * scale

		-- Right border
		if self.x > (mapW - w / 2) / scale then
				self.x = (mapW - w / 2) / scale
		end

		-- Bottom border
		if self.y > (mapH - h / 2) / scale then
				self.y = (mapH - h / 2) / scale
		end
	end

	camera:zoomTo(scale)
end

function camera:shake(time, speed)
	-- ..body.
end
