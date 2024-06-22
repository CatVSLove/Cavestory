--Functions for the collision system

function startCollision()
  world:addCollisionClass("platform")
  world:addCollisionClass("water")


  world:addCollisionClass("enemy")

  world:addCollisionClass("player", {ignores = {"water"} } )
end

function normalize(x, y)
    local normalizeFactor = math.sqrt(2)

    if x ~= 0 and y ~= 0 then
        x = x / normalizeFactor
        y = y / normalizeFactor
    end

    return x, y
end

function loadMapColliders(layer, tablename, class, width, height)
  if type(tablename) ~= 'table' then
    error("Make sure you pass in a table for your second argument.")
  end

  if testMap.layers[layer] then
    for i, obj in ipairs(testMap.layers[layer].objects) do

      local collider

      if obj.width == 0 then
        obj.width = width
      end

      if obj.height == 0 then
        obj.height = height
      end

      if obj.shape ~= "polygon" then
        collider = world:newBSGRectangleCollider(obj.x, obj.y, obj.width, obj.height, 0.25)
      else

        local dVertices = {}

        for _, vertex in ipairs(obj.polygon) do
            table.insert(dVertices, vertex.x)
            table.insert(dVertices, vertex.y)
        end

        collider = world:newPolygonCollider(dVertices)
      end

      if class then
        collider:setCollisionClass(class)
      end

      collider:setType('static')

      table.insert(tablename, collider)
    end
  end
end

function debugDraw()
  love.graphics.push()
    love.graphics.setLineWidth(0.5)

    world:setQueryDebugDrawing(true)
    world:draw()

  love.graphics.pop()
end
