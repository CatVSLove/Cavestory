--Misc variables

variables = {}

function variables:load()
  gravity = 100
  scale = 4

  playstate = 1
  titlestate = 2

  gamestate = titlestate

  fontMain = love.graphics.newFont('fonts/CaveStory.ttf', 15 * scale)
  function GetFontHeight(font)
    font = font or fontMain

    return font:getHeight(" ")
  end
end
