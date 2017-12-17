require "dialog"
require "menu"
require "Player/player"
require "stage"
require "game_over"
require "cutscene"
game = {}

function game.load()
  player.load()
  menu.load()
  stage.load()
  game_over.load()
  game.goToMenu()
  cutscene.load()
end

function game.start()
  --game.gameState.start()
end

function game.keypressed(key)
  game.gameState.keypressed(key)
end

function game.update(dt)
  game.gameState.update(dt)
end

function game.draw()
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  game.gameState.draw(h,w)
end


function game.changeState(x)
  game.gameState = x
  game.gameState.start()
end
function game.goToCutscene()
  game.changeState(cutscene)
end

function game.goToStage()
  game.changeState(stage)
end

function game.goToMenu()
  game.changeState(menu)
end

function game.goToGameOver()
  game.changeState(game_over)
end