--[[
RPG Logo animation (based on 1280x720)
Load with the time for each animation and an optional callback:
 - t1: logo fadeIn time
 - t2: logo wait time
 - t3: logo fadeOut
 - callback: a function to be called when logo presentation is over
 
 This script calls the callback when the animation ends or when the ENTER key is pressed
 To know when it is finished from other script you can access GGJ_Logo.finish
 ]]
 
GGJ_Logo={}
local logoDist = 0.9
local letterDist = 0.03
local fadeMax = 240
local endLogo

local getScale, fadeIn, wait, fadeOut, step

function GGJ_Logo.load(t1,t2,t3,callback)
  GGJ_Logo.logo=love.graphics.newImage("/GGJ_Logo/logo.png")
  GGJ_Logo.width=GGJ_Logo.logo:getWidth()
  GGJ_Logo.height=GGJ_Logo.logo:getHeight()
  GGJ_Logo.scale = getScale(GGJ_Logo.width,GGJ_Logo.height,1,1)
  GGJ_Logo.width = GGJ_Logo.scale*GGJ_Logo.width
  GGJ_Logo.height = GGJ_Logo.scale*GGJ_Logo.height
  
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  
  GGJ_Logo.pos={
    x=(w-GGJ_Logo.width)/2,
    y=(h-GGJ_Logo.height)/2
  }
  
  GGJ_Logo.a1=t1
  GGJ_Logo.a2=t2
  GGJ_Logo.a3=t3
  GGJ_Logo.a4=t4
  GGJ_Logo.fadeOut = fadeMax
  GGJ_Logo.finish=false
  GGJ_Logo.callback = callback

  GGJ_Logo.vel1 = fadeMax/t1
  GGJ_Logo.vel2 = fadeMax/t3
  GGJ_Logo.fade = 0
  step = fadeIn
end

function getScale(width,height,s1,s2)
  if s2 == nil then s2 = s1 end
  local w = love.graphics.getWidth()*s1
  local h = love.graphics.getHeight()*s2
  local sw,sh = w/width, h/height
  local s = sw < sh and sw or sh
  return s
end

function getBiScale(w1,w2,h1,h2,scale1,scale2)
  if scale2 == nil then scale2 = scale1 end
  local w = love.graphics.getWidth()*scale1
  local h = love.graphics.getHeight()*scale2
  local s1,s2 = w/w1, w/w2
  local tot = s1*h1+s2*h2
  if tot>h then
    s1 = s1*h/tot
    s2 = s2*h/tot
  end
  return {s1=s1,s2=s2}
end

function GGJ_Logo.start()
end

function GGJ_Logo.update(dt)
  
  step(dt)
  
end

function fadeIn(dt)
  GGJ_Logo.a1 = GGJ_Logo.a1-dt
  if GGJ_Logo.a1<0 then
    GGJ_Logo.fade = fadeMax
    step = wait
  else
    GGJ_Logo.fade = GGJ_Logo.fade + dt*GGJ_Logo.vel1
  end
end
function wait(dt)
  GGJ_Logo.a2 = GGJ_Logo.a2-dt
  if GGJ_Logo.a2<0 then
    step = fadeOut
  end
end
function fadeOut(dt)
  GGJ_Logo.a3 = GGJ_Logo.a3-dt
  if GGJ_Logo.a3<0 then
    GGJ_Logo.fade = 0
    endLogo()
  else    
    GGJ_Logo.fade = GGJ_Logo.fade - dt*GGJ_Logo.vel1
  end
end

function GGJ_Logo.draw()
  love.graphics.setColor(255,255,255,GGJ_Logo.fade)
  love.graphics.draw(GGJ_Logo.logo,GGJ_Logo.pos.x,GGJ_Logo.pos.y,0,GGJ_Logo.scale,GGJ_Logo.scale)
end

function GGJ_Logo.keypressed(key)
  if key=="return" then
    endLogo()
  end
end

function endLogo()
  GGJ_Logo.finish = true
  if GGJ_Logo.callback ~= nil then
	GGJ_Logo.callback()
	end
end