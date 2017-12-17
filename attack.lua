attack = {}

function attack.load()
  attack.width = 50
  attack.height = 50
  attack.damage = false
  attack.ing = false
  timer_punch = 0
  
  attack.timer_damage = 0
  damage_time = 0.5
end
function attack.start()
  attack.x = player.x
  attack.y = player.y
  attack.width = player.width
  attack.height = player.height
  attack.damage = false
  attack.ing = false
  timer_punch = 0
  player.curr_sprite = player.punch
  animationManager_restart(player.curr_sprite)
end

function attack.update_damage(dt)
  attack.x = player.x --+ player.width/2
  attack.y = player.y --+ player.height/2
  
  if attack.damage and attack.timer_damage > damage_time then
      attack.damage = false
      attack.timer_damage = 0
  elseif attack.damage then
       attack.timer_damage = attack.timer_damage + dt
  end

  for i_enemie, v_enemie in ipairs(enemies.list) do
    for i, enemie in ipairs(v_enemie.list) do
      if(CheckBoxCollision(attack.x,attack.y,attack.width,attack.height,enemie.x,enemie.y,enemie.width, enemie.height))
      --and attack.ing 
      then
          audio.playPlayerDamage()
          attack.damage = true 
          attack.timer_damage = 0
          if attack.ing then
            table.remove(v_enemie.list, i)
          else
            player.takeHit()
          end
      end
    end
  end
end

function attack.update(dt)
  attack.x = player.x --+ player.width/2
  attack.y = player.y --+ player.height/2
  
  -- soca em 3.5 segundos e desfaz após 0.5 segundos
  timer_punch = timer_punch + dt
  if (timer_punch >= 4.0) then
    attack.ing = false
    timer_punch = 0
  elseif (timer_punch >= 3.5  and not attack.ing) then
    attack.ing = true
    animationManager_restart(player.punch.aComp)
    audio.playPlayerPunch()
  end
end

function attack.draw()
  local c = mapManager.camera
  
  --[[if attack.damage then
    
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line", attack.x-c.pos_x, attack.y-c.pos_y, attack.width, attack.height)
    
  end]]
  
  
  if attack.ing then
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line", attack.x-c.pos_x, attack.y-c.pos_y, attack.width, attack.height)
  end

end
function attack.keypressed(key)
  
end

function attack.keyreleased(key)
  
end
function CheckBoxCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return (x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1)
end 
