require "Player/player"
require "MapManager/mapManager"
require "enemie/enemies"
require "contadoresvisuais"

stage = {}

function stage.load()
  player.load()
  mapManager.load("")
 -- mapManager.touchedFloorCallback(player.reachFloor)
  
  -- Loop para atualizar Enemies da Lista
  enemies.load()
  viscont.load()
end

function stage.update(dt)
  if not stage.isPaused then
    mapManager.update(dt,player)
    player.update(dt)
    mapManager.handleContact(dt,player)
   -- Loop para atualizar Enemies da Lista
    enemies.update(dt)
  end
  viscont.update(dt)
end

function stage.draw()
  love.graphics.setColor(255,255,255)
  mapManager.draw()
  
  -- Loop para atualizar Enemies da Lista
  enemies.draw()
  
  player.draw()
  viscont.draw()
  if stage.isPaused then
    stage.pauseDraw()
  end
end

function stage.pauseDraw()
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  love.graphics.setColor(0,0,0,100)
  love.graphics.rectangle("fill",0,0,w,h)
  love.graphics.setColor(255,255,255)
  --love.graphics.draw(game.pauseImg,0,0,0,w/game.pauseImg:getWidth(),h/game.pauseImg:getHeight())
end

function stage.start()
  love.audio.stop(audio.menuMusic)
  audio.play(audio.stageMusic)
  player.start()
  mapManager.start()
  stage.isPaused = false
end

function stage.keypressed(key)
  if key == "escape" then
    stage.isPaused = not stage.isPaused
  elseif not stage.isPaused then
    player.keypressed(key)
  end
end
