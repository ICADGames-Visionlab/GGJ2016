menu={}
function menu.load()
  start = love.graphics.newImage("menu/Start_Game.png")
  start_select = love.graphics.newImage("menu/Start_Game_Selec.png")
  instructions = love.graphics.newImage("menu/Instructions.png")
  instructions_select = love.graphics.newImage("menu/Instructions_Selec.png")
  quit = love.graphics.newImage("menu/Quit.png")
  quit_select = love.graphics.newImage("menu/Quit_Selec.png")
  instructions_screen = love.graphics.newImage("menu/Instructions_Menu.png")
  instruction = false
  menu.buttonWidth = 200
  menu.buttonHeight = 100
  menu.buttonColor = {255,0,0,255}
  menu.selectedColor = {0,255,255,255}
  menu.buttonXPos = 520
  menu.buttons = {
    {yPos = 400, dir = -1 },
    {yPos = 500, dir = -1},
    {yPos = 600, dir = 1 }
  }
  menu.time = 1
  title = love.graphics.newImage("LOGO_OFICAL.png")
end

function menu.start()
  audio.play(audio.menuMusic)
  for i,but in ipairs(menu.buttons) do
    but.x = menu.buttonXPos
    but.y = but.yPos
  end
  menu.isAnimating = false
  menu.pressionado = 1
end

function menu.update(dt)
  if menu.isAnimating then
    for i,b in ipairs(menu.buttons) do
      menu.timer = menu.timer - dt
      b.x = b.x + menu.vel*dt
      if menu.timer < 0 then
        audio.playMenuStart()
        game.goToStage()
      end
    end
  end
end

function menu.startAnimation()
  menu.isAnimating = true
  menu.timer = menu.time
  menu.goTo = menu.buttons[menu.pressionado].dir == 1 and love.graphics.getWidth() or -menu.buttonWidth
  menu.vel = (menu.goTo - menu.buttonXPos)/menu.time
end

function menu.keypressed(key)
  if(key == 'return') then
    if(menu.pressionado == 1) then
      audio.playMenuStart()
      menu.startAnimation()
      game.goToCutscene()
    elseif (menu.pressionado == 2) then
      instruction = true
    elseif menu.pressionado == 3 then
      audio.playMenuStart()
      love.event.push("quit")
    end
  elseif(key == "down") then
    menu.pressionado = menu.pressionado%#menu.buttons+1
  elseif(key == "up") then
    local q = #menu.buttons
    menu.pressionado = (menu.pressionado-2+q)%q+1
  end
end

function menu.draw()
  love.graphics.draw(title, 640, 200, 0, 1, 1, title:getWidth()/2, title:getHeight()/2)
  love.graphics.draw(start, 520, 400)
  love.graphics.draw(instructions, 520, 500)
  love.graphics.draw(quit, 520, 600)
  if menu.pressionado == 1 then
    love.graphics.draw(start_select, 520, 400)
  elseif menu.pressionado == 2 then
    love.graphics.draw(instructions_select, 520, 500)
  else
    love.graphics.draw(quit_select, 520, 600)
  end
  love.graphics.setColor(255,255,255)
  if instruction == true then
    love.graphics.draw(instructions_screen, 0,0)
  end
end