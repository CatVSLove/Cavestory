--Handles titlescreen

titlescreen = {}

function titlescreen:load()
  titlesong = love.audio.newSource('music/TitleTheme.ogg', 'stream')
  titlesong:setLooping(true)

  titlesong:play()

  self.animation = player.animations.right:clone()

  titlescreen.buttonY = love.graphics.getHeight() / 2 - GetFontHeight()
end

function titlescreen:update(dt)
  self.animation:update(publicDT)
end

function titlescreen:draw()
  love.graphics.setColor(0.125, 0.125, 0.125)
    love.graphics.rectangle('fill', 0, 0, windowWidth, windowHeight)
  love.graphics.setColor(1, 1, 1)
  
  self.animation:draw(player.spritesheet, love.graphics.getWidth() / 13, titlescreen.buttonY - player.height, nil, scale)

  love.graphics.print("Start game.", love.graphics.getWidth() / 8, love.graphics.getHeight() / 2 - GetFontHeight())
  love.graphics.print("Exit...", love.graphics.getWidth() / 8, love.graphics.getHeight() / 2 - GetFontHeight() + GetFontHeight() * 3)
end

function titlescreen:keypressed(key)
  if key == 'return' then
    gamestate = playstate
    titlesong:stop()

    levelsong = love.audio.newSource('music/Gestation.ogg', 'stream')
    levelsong:setLooping(true)

    levelsong:play()
  end
end
