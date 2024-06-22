--Handler for the player

local width, height = 4, 16

player = world:newBSGRectangleCollider(30, 240 - height, width, height, 0.5)

function player:load()
  self:setFixedRotation(true)
  self:setCollisionClass('player')

  self.width, self.height = width, height
  self.gravity = gravity

  self.jumpSpeed = 450 / 4
  self.speed = 75
  self.jumpTime = 0.4
  self.yFactor = 0
  self.isMoving = false

  self.xV, self.yV = 0, self.gravity

  self.spritesheet = love.graphics.newImage('sprites/entities/player.png')
  self.animationCell = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())

  self.animations = {}
  self.animations.left = anim8.newAnimation(self.animationCell('1-4', 1), 0.1625)
  self.animations.right = anim8.newAnimation(self.animationCell('1-4', 2), 0.1625)

  self.currentAnimation = self.animations.right
  self.dir = 'right'
  self.animationSpeed = 1
  self.isJumping = false
end

function player:OnGround()
  local querys = world:queryRectangleArea(self:getX() - self.width / 2 + 0.25, self:getY() + self.height / 2 - 1.25, self.width - 0.5, 3, {"platform", "enemy"})

  if #querys > 0 then
    return true
  end
end

function player:HitCeiling()
  local querys = world:queryRectangleArea(self:getX() - self.width / 2 + 0.25, self:getY() - self.height / 2 + 0.25 - 4, self.width - 0.5, 2, {"platform", "enemy"})

  if #querys > 0 then
    return true
  end
end

function player:update(dt)
  self.isMoving = false

  if self.xV ~= 0 then
    self.isMoving = true
  end

  if self.xV ~= 0 then
    if self.isMoving == true then
      if self.dir == 'left' then
        self.xV = -self.speed
      else
        self.xV = self.speed
      end
    end
  end

  if self:enter('water') then
    self.speed = 25
    self.gravity = gravity / 3
    self.animationSpeed = 1.75
    self.yV = self.gravity
    self.jumpSpeed = 450 / (1.5 * 4)
  end

  if self:exit('water') then
    self.speed = 75
    self.gravity = gravity
    self.animationSpeed = 1
    self.jumpSpeed = 450 / 4
    if not self:OnGround() then
      self.yV = -self.jumpSpeed
    else
      self.yV = self.gravity
    end
  end

  if self:OnGround() then
    if self.isMoving == true then
      self.yFactor = self.gravity / 1.75
    else
      self.yFactor = self.gravity
    end
  else
    self.yFactor = 0
  end

  if self.jumpTimeTimer then
    self.jumpTimeTimer = self.jumpTimeTimer - publicDT
    self.jumpFrame = 4
    self.isJumping = true

    if self.jumpTimeTimer <= 0 or self:HitCeiling() then
      self.yV = self.yV + (2050 / 4) * publicDT

      if self.yV >= self.gravity then
        self.jumpTimeTimer = nil
        self.isJumping = false
        self.jumpFrame = 2
        self.yV = self.gravity
      end
    end
  end

  self:setLinearVelocity(self.xV, self.yV - self.yFactor)
  self.currentAnimation:update(publicDT / self.animationSpeed)

  if not self:OnGround() then
    self.jumpFrame = self.jumpFrame or 2

    self.currentAnimation:gotoFrame(self.jumpFrame)
  end

  if self.isMoving == false and self:OnGround() then
    self.currentAnimation:gotoFrame(1)
  end
end

function player:draw()
  self.currentAnimation:draw(self.spritesheet, self:getX() - 16 * (1 / 2), self:getY() - self.height / 2)
end

function player:keypressed(key)
  if key == 'z' and self:OnGround() then
    self.yV = -self.jumpSpeed
    self:setLinearVelocity(self.xV, self.yV)
    self.jumpTimeTimer = self.jumpTime
  end

  if key == 'left' then
    self.xV = -self.speed
    self.currentAnimation = self.animations.left
    self.dir = 'left'
  end

  if key == 'right' then
    self.xV = self.speed
    self.currentAnimation = self.animations.right
    self.dir = 'right'
  end

  if key == 'up' then
    --TODO add player look up animations
  end
end

function player:keyreleased(key)
  if key == 'left' and not love.keyboard.isDown('right') then
    self.xV = 0
  end

  if key == 'right' and not love.keyboard.isDown('left') then
    self.xV = 0
  end

  if key == 'z' then
    self.jumpTimeTimer = 0
  end
end
