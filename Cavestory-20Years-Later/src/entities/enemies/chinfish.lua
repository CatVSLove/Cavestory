-- Chinfish handler


chinfish = {}

function chinfish:spawn()
  self.colliders = {}

  loadMapColliders('enemies', self.colliders, "enemy", self.width, self.height)

  for i, enemyC in ipairs(self.colliders) do
    enemyC.currentAnimation = self.animations.idle:clone()
    enemyC.dir = testMap.layers['enemies'].objects[i].name
  end
end

function chinfish:load()
  self.width, self.height = 16, 10

  self.spritesheet = love.graphics.newImage('sprites/entities/enemies/chinfish.png')
  self.animationCell = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())

  self.animations = {}

  self.animations.idle = anim8.newAnimation(self.animationCell('1-2', 1), 0.325)
  self.animations.hurt = anim8.newAnimation(self.animationCell('3-3', 1), 0.325)

  self:spawn()
end

function chinfish:update(dt)
  for i, enemyC in ipairs(self.colliders) do
    enemyC.currentAnimation:update(publicDT + (math.random(-0.325, 0) * publicDT))
  end
end

function chinfish:draw()
  for i, enemyC in ipairs(self.colliders) do
    if enemyC.dir == 'left' then
      enemyC.currentAnimation:draw(self.spritesheet, enemyC:getX() - self.width / 2, enemyC:getY() - self.height)
    else
      enemyC.currentAnimation:draw(self.spritesheet, enemyC:getX() + self.width / 2, enemyC:getY() - self.height / 1.1, nil, -1, 1)
    end
  end
end
