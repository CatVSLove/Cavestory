--All enemies in one


enemies = {}

function enemies:load()
  --require section

  require('src/entities/enemies/chinfish')

  --load section
  chinfish:load()
end

function enemies:update(dt)
  chinfish:update(publicDT)
end

function enemies:draw()
  chinfish:draw()
end
