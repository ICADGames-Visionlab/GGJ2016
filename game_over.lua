game_over={}
function game_over.load()
  game_over.buttonWidth = 500
  game_over.buttonHeight = 150
  game_over.buttonColor = {255,0,0,255}
  game_over.selectedColor = {0,255,255,255}
  game_over.buttonyPos = 500
  game_over.buttons = {
    {XPos=250, dir = -1,img = love.graphics.newImage("menu/Retry.png"), selImg = love.graphics.newImage("menu/Retry_Selec.png")},
    {XPos=800, dir = -1,img = love.graphics.newImage("menu/Quit.png"), selImg = love.graphics.newImage("menu/Quit_Selec.png")}
  }
  game_over.time = 1
end

function game_over.start()
  love.audio.stop(audio.stageMusic)
  audio.playGameover()
  for i,but in ipairs(game_over.buttons) do
    but.y = game_over.buttonyPos
    but.x = but.XPos
  end
  game_over.isAnimating = false
  game_over.pressionado = 1
end

function game_over.update(dt)
  if game_over.isAnimating then
    for i,b in ipairs(game_over.buttons) do
      game_over.timer = game_over.timer - dt
      b.x = b.x + game_over.vel*dt
      if game_over.timer < 0 then
        game.goToStage()
      end
    end
  end
end

function game_over.keypressed(key)
  if(key == 'return') then
    if game_over.pressionado == 1 then
      game.goToStage()
    else
      game.goToMenu()
    end
  elseif(key == "left") then
    game_over.pressionado = game_over.pressionado%#game_over.buttons+1
  elseif(key == "right") then
    local q = #game_over.buttons
    game_over.pressionado = (game_over.pressionado-2+q)%q+1
  end
end

function game_over.draw()
  for i, v in ipairs(game_over.buttons) do
    local c = i == game_over.pressionado and v.selImg or v.img
    love.graphics.draw(c, v.x, v.y)
  end
  love.graphics.setColor(255,255,255)
end