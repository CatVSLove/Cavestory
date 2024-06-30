--Background handler


background = {}

function background:load(backgroundFile)
  if backgroundFile then
    self.image = love.graphics.newImage('tilesets/backgrounds/'.. backgroundFile .. '.png')
    return
  end

  self.image = nil --Set's background image to nil so nothing draws even if a background was passed in before...
end

function background:draw()
  if self.image then
    local repeatTimeRow = love.graphics:getWidth() / self.image:getWidth()
    repeatTimeRow = math.ceil(repeatTimeRow)

    local repeatTimeColl = love.graphics:getHeight() / self.image:getHeight()
    repeatTimeColl = math.ceil(repeatTimeColl)

    local columns = 1
    local rows = 1

    while true do
      love.graphics.draw(self.image, rows * self.image:getWidth() * scale - self.image:getWidth() * scale * 2, columns * self.image:getHeight() * scale - self.image:getHeight() * scale * 2, nil, scale)

      if rows > repeatTimeRow then
        if columns > repeatTimeColl then
          break
        end

        columns = columns + 1
        rows = 1
      end

      rows = rows + 1
    end
  end
end
