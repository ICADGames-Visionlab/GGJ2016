viscont = {}

function viscont.load()
  viscont.font = love.graphics.newFont("ComicBook.otf", 20)
end

function viscont.update(dt)
end

function viscont.draw()
  love.graphics.setFont(viscont.font)
  
    -- Contator Pulo
  love.graphics.setColor(255,0,0)
  love.graphics.circle("fill", 1020, 100, 40, 200)
  love.graphics.setColor(128,55,128)
  love.graphics.arc("fill", 1020, 100, 40, 0, 0.8*math.pi*timer_jump, 200)
  love.graphics.setColor(255,255,255)
  love.graphics.circle("line", 1020, 100, 40, 2000)
  love.graphics.setColor(0,0,255)
  love.graphics.print(" JUMP", 980, 145)
  
  -- Contator Soco
  love.graphics.setColor(255,0,0)
  love.graphics.circle("fill", 1150, 100, 40, 200)
  love.graphics.setColor(128,55,128)
  love.graphics.arc("fill", 1150, 100, 40, 0, 2/3.5*math.pi*timer_punch, 200)
  love.graphics.setColor(255,255,255)
  love.graphics.circle("line", 1150, 100, 40, 2000)
  love.graphics.setColor(0,0,255)
  love.graphics.print("PUNCH", 1110, 145)
  
  -- Vida player
  local w,h = 100,35
  local stress = player.maxLife - player.life
  for i=1,player.maxLife do
    local p = 10+(i-1)*w
    if i<=stress then
      love.graphics.setColor(255,0,0)
      love.graphics.rectangle("fill",p,10,w,h)
    end
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",p,10,w,h)
  end
  love.graphics.setColor(255,255,255)
end