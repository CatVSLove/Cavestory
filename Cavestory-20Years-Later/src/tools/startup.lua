--Config and import libraries and make variables

function startup()
  --Imports

  anim8 = require('libraries/anim8')
  wf = require('libraries/windfield')
  sti = require('libraries/sti')

  cam = require('libraries/camera')
  camera = cam()

  require('src/tools/misc/variables')
  require('src/tools/collision')
  require('src/entities/entity')
  require('src/tools/misc/cameraExtras')
  require('src/tools/shaders')
  require('src/tools/background')
  require('src/tools/titlescreen')

  --Loads
  MakeVariables()

  world = wf.newWorld(0, 0)
  startCollision()

  platforms = {}
  water = {}

  testMap = sti('maps/testLevel1.lua')

  loadMapColliders('ground', platforms, 'platform')
  loadMapColliders('environment', water, 'water')

  entities:load()

  shaders:load()

  background:load('background2')

  titlescreen:load()

  --Hide mouse
  love.mouse.setVisible(false)
end
