--Shaders for extra cools graphical effects


shaders = {}

function shaders:load()
  -- Faded light source
  shaders.trueLight = love.graphics.newShader[[
      extern number playerX = 0;
      extern number playerY = 0;
      extern number shaderRad = 0;
      extern number scale = 0;

      number radius = 220 * scale;
      vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
          number distance = pow(pow(screen_coords.x - playerX, 2) + pow(screen_coords.y - playerY, 2), shaderRad);
          number alpha = distance / radius;
          return vec4(0, 0, 0, alpha);
      }
  ]]

  shaders.lightFlicker = 0.4572
  shaders.lightFlickerSpeed = 0.005
end

function shaders:update(dt)
  local px, py = player:getPosition()

  -- Get width/height of background
  local mapW = testMap.width * testMap.tilewidth
  local mapH = testMap.height * testMap.tileheight

  local lightX = (windowWidth/2)
  local lightY = (windowHeight/2)

  -- Left border
  if camera.x < windowWidth/2 then
      lightX = px
  end

  -- Top border
  if camera.y < windowHeight/2 then
      lightY = py
  end

  -- Right border
  if camera.x > (mapW - windowWidth/2) then
      lightX = (px - camera.x) + (windowWidth/2)
  end

  -- Bottom border
  if camera.y > (mapH - windowHeight/2) then
      lightY = (py - camera.y) + (windowHeight/2)
  end

  shaders.lightFlicker = shaders.lightFlicker + shaders.lightFlickerSpeed * publicDT

  if shaders.lightFlicker >= 0.46 then
    shaders.lightFlickerSpeed = -shaders.lightFlickerSpeed
    shaders.lightFlicker = 0.46
  elseif shaders.lightFlicker <= 0.4525 then
    shaders.lightFlickerSpeed = -shaders.lightFlickerSpeed
    shaders.lightFlicker = 0.4525
  end

  shaders.trueLight:send("scale", scale)
  shaders.trueLight:send("playerX", lightX)
  shaders.trueLight:send("playerY", lightY)
  shaders.trueLight:send("shaderRad", shaders.lightFlicker)
end

function shaders:draw()
  love.graphics.setShader(shaders.trueLight)
  love.graphics.rectangle("fill", -10, -10, 10000, 10000)
  love.graphics.setShader()
end
