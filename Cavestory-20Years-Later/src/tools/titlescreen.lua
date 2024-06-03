--Handles titlescreen

titlescreen = {}

function titlescreen:load()
  titlesong = love.audio.newSource('music/TitleTheme.ogg', 'stream')
  titlesong:setLooping(true)

  titlesong:play()
end

function titlescreen:update(dt)
  player.currentAnimation:update(publicDT)
end

function titlescreen:draw()
  camera:attach()

    player:draw()

  camera:detach()

  love.graphics.print( "Press Start!", love.graphics.getWidth() / 8, love.graphics.getHeight() / 2 - 20)
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
