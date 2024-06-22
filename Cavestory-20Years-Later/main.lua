--Main file called at start

function love.load()
  math.randomseed(os.time()) --Random number
  love.graphics.setDefaultFilter("nearest", "nearest") --Pixel art scales with no blur

  require('src/tools/startup') --Imports startup file with code imports for less clutter
end

function love.update(dt)
  if dt > 0.05 then
    dt = 0.05 --Update cap so nothing breaks under lag
  end

  publicDT = dt --Any function can use dt

  windowWidth, windowHeight = love.graphics.getDimensions() --Size of the game's window

  testMap:update(publicDT) --Tiles have animation
  shaders:update(publicDT) --Updates shaders position

  if gamestate == playstate then
    if not pause then
      world:update(publicDT) --Updates colliders for the current frame
    end

    entities:update(publicDT) --All entity update here
  elseif gamestate == titlestate then
    titlescreen:update(publicDT) --Updates titlescreen animations
  end

  camera:update() --Updates camera position
end

function love.draw()
  love.graphics.setFont(fontMain) --Set's the font

  if gamestate == playstate then
    background:draw()

    camera:attach() --Draws from camera's pov

      testMap:drawLayer(testMap.layers['background']) --Map layer gets drawn

      entities:draw() --All entities get drawn here


      testMap:drawLayer(testMap.layers['forgeground']) --Map layer gets drawn
      testMap:drawLayer(testMap.layers['forgeground2']) --Map layer gets drawn

      shaders:draw() --Shader effects

      --debugDraw() --Draw debug colliders and hitboxes

    camera:detach() --Stops drawing from the camera's pov
  elseif gamestate == titlestate then
    titlescreen:draw() --Draws titlescreen effects
  end
end

function love.keypressed(key)
  if gamestate == playstate then
    player:keypressed(key) --Player input press
  elseif gamestate == titlestate then
    titlescreen:keypressed(key) --Handles input on titlescreen
  end
end

function love.keyreleased(key)
  if gamestate == playstate then
    player:keyreleased(key) --Player input release
  end
end
