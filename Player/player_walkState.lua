require "mathUtils"
require "attack"

player_walkState = {}


function player_walkState.load()
  
end

function player_walkState.start()
  player.curr_sprite = player.walk
end

function player_walkState.exit()
  
end

function player_walkState.update(dt)
  timer_jump = timer_jump + dt
  --[[
  if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
    player.speedx = player.maxSpeed*math.absSign(player.speedx)*2
  end
  ]]
  if attack.ing then
    player.curr_sprite = player.punch
  elseif player.speedx ~= 0 then
    player.curr_sprite = player.walk
  else
    player.curr_sprite = player.idle
  end

    if (timer_jump >= 2.5) then    
    timer_jump = 0
    player.jump()
  end
  
  animationManager_update(dt,player.curr_sprite.aComp)
  attack.update(dt)
  attack.update_damage(dt)

end
function player_walkState.draw()
  
end

function player_walkState.keypressed(key)
  if (key=="lshift" or key=="rshift") and player.dashCooldownTimer<=0 then
    player.dash()
  end
end
function player_walkState.keyreleased(key)
  
end