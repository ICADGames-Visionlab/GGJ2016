require "Player/player_jumpState"
require "Player/player_walkState"
require "Player/player_dashState"
require "Player/player_deathState"
require "attack"
require "animations"
require "animationManager"
player = {}

local entryState, loadSpriteData

function player.load()
  player.maxSpeed = 200
  player.invTime = 2
  player.gravity = 1100
  player.width = 64
  player.height = 128
  player.jump_time = 5.0
  player.maxLife = 3
  player_jumpState.load()
  player_dashState.load()
  player_deathState.load()
  attack.load()
  player.walk = animations.loadSpriteData("/Assets/player_walk.png",8,8,1,true)
  player.jumpS = animations.loadSpriteData("/Assets/player_jump.png",5,5,0.7,false)
  player.idle = animations.loadSpriteData("/Assets/player_idle.png",8,3,1,true)
  player.hit = animations.loadSpriteData("/Assets/player_hit.png",1,1,0.4,false)
  player.death = animations.loadSpriteData("/Assets/player_death.png",9,9,0.5,false)
  player.punch = animations.loadSpriteData("/Assets/player_punch.png",10,5,0.5,false)
  player.dashCooldown = 3
end

function player.start()
  player.dashCooldownTimer = 0
  player.invTimer = 0
  player.beingHit = false
  player.life = player.maxLife
  player.speedx = 0
  player.speedy = 0
  player.dir = 1
  player.x = 100
  player.y = 100
  player.dir = 1
  player.state = player_walkState
  timer_jump = 0
player.offset = {
    x=19,
    y=6
  }
  player.hitbox = {
    width = 29,
    height = 123
  }
  player.curr_sprite = player.idle
  attack.start()
end

function player.update(dt)
  if player.dashCooldownTimer>0 then player.dashCooldownTimer = player.dashCooldownTimer-dt end
  --player.y = player.y + player.speedy*dt
  if player.invTimer>0 then
    if animationManager_update(dt,player.hit.aComp)==-1 then
      player.beingHit = false
    end
    player.invTimer = player.invTimer-dt
  end
  player.processMovement(dt)
  player.state.update(dt)
end

function player.processMovement(dt)
  player.speedy = player.speedy + player.gravity*dt
  if(love.keyboard.isDown("right")) then
    player.speedx = player.maxSpeed
  elseif(love.keyboard.isDown("left")) then
    player.speedx = -player.maxSpeed
  else
    player.speedx = 0
  end
end

function player.draw()
  local c = mapManager.camera
  local s = player.beingHit and player.hit or player.curr_sprite
  love.graphics.setColor(255,255,255)
  if player.speedx<0 then player.dir = -1
  elseif player.speedx>0 then player.dir = 1 end
  love.graphics.draw(s.sheet,s.quads[s.aComp.curr_frame],player.x-c.pos_x+player.width/2,player.y-c.pos_y--[[-(0.3*110)]]+player.height/2,0,player.dir,1,player.width/2,player.height/2)
  attack.draw()
  
  if player.y-c.pos_y+player.height/2 > 1600 then
      player.life = 0
       player.takeHit()
       game.goToGameOver()
  end
  attack.draw()
end

function player.jump()
  --... do something maybe
  entryState(player_jumpState)
end
function player.reachFloor()
  --print("chaozin")
  player.speedy = 0
  if player.state == player_jumpState then
    entryState(player_walkState)
  end
end

function player.dash()
  entryState(player_dashState)
end

function player.endDash()
  entryState(player_walkState)
end

function player.die()
  entryState(player_deathState)
end

function player.keypressed(key)
  if key == "a" then
    player.die()
  else
    player.state.keypressed(key)
  end
end

function player.keyreleased(key)
  
end

function player.takeHit()
  if player.invTimer <= 0 then
    player.invTimer = player.invTime
    player.life = player.life-1
    animationManager_restart(player.hit.aComp)
    if player.life == 0 then
      player.die()
    else
      player.beingHit = true
    end
  end
end

function entryState(state)
  player.state.exit()
  player.state = state
  player.state.start()
end

function player.reachAir()
  if player.state ~= player_jumpState then
    player_jumpState.startFall()
  end
end