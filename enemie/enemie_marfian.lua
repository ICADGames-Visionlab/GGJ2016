require "enemie/enemie_jumpState"
require "enemie/enemie_walkState"
require "animations"
require "animationManager"

enemie_marfian = {}

enemie_marfian.list = {}


local entryState

function enemie_marfian.spawn(_x, _y, _maxSpeed, _dir_time, _jump_time)
  
  _var = 0.2
    
  if _maxSpeed == nil then
     _maxSpeed = enemie_marfian.maxSpeed * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  if _dir_time == nil then
     _dir_time =  enemie_marfian.dir_time * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  if _jump_time == nil then
     _jump_time =  enemie_marfian.jump_time * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  _sight = enemie_marfian.sight * (1 + (((2*_var) * love.math.random()) - _var))
  
 table.insert(enemie_marfian.list,{name =  enemie_marfian.name..table.getn(enemie_marfian.list), x = _x, y = _y, sight = _sight, jump_time = _jump_time, jumpForce = enemie_marfian.jumpForce, dir_time = _dir_time, maxSpeed = _maxSpeed, invTime = 2 , width = enemie_marfian.idle.sheet:getWidth()/5, height = enemie_marfian.idle.sheet:getHeight()/2, speedx = 0, speedy = 0, dir = 0, last_dir = -1,state = enemie_walkState, timer_jump = 0, timer_dir = 0, aComp = animationManager_new(8,1, true), reachFloor = enemie_marfian.reachFloor})
end

function enemie_marfian.load()
  
  enemie_marfian.idle = animations.loadSpriteData("/Assets/bandido_idle.png",8,8,1,true)
  
  --enemie_marfian.x = 800
  --enemie_marfian.y = 400
  enemie_marfian.sight = 500
  enemie_marfian.gravity = 1100
  
  enemie_marfian.name = "marfian"
  enemie_marfian.is_jumper = true
  
  enemie_jumpState.load()
  enemie_marfian.jumpForce = -500

  enemie_marfian.jump_time = 0.3
  enemie_marfian.dir_time = 0.8
  enemie_marfian.maxSpeed = 70
end

function enemie_marfian.start()

  for i, v in ipairs(enemie_marfian.list) do
    v.state = enemie_walkState
  end
end

function enemie_marfian.update(dt)
  
  for i, v in ipairs(enemie_marfian.list) do
    v.speedy = v.speedy + enemie_marfian.gravity*dt
    v.timer_dir = v.timer_dir + dt
    
    if math.abs(player.x - v.x) <= v.sight then
      
      if v.timer_dir > v.dir_time then
        v.timer_dir = 0
        
        if player.x > v.x then
          v.dir = 1
        else 
          v.dir = -1
        end
        
        v.last_dir = v.dir
      end
      
      if enemie_marfian.is_jumper then
        if (player.y + player.height + 20) < v.y + v.height then
           -- v.speedy = -700
          v.timer_jump = v.timer_jump + dt
          if v.timer_jump > v.jump_time then
            enemie_marfian.jump(v)
          end
        else
          v.timer_jump = 0.0
        end
      end

    else
      if v.timer_dir > v.dir_time then
        v.timer_dir = 0
        v.dir = 0
      end
    end
    
    if  v.dir == 1 then
      v.speedx = v.maxSpeed
    elseif  v.dir == -1 then 
      v.speedx = -v.maxSpeed
    else
      v.speedx = 0
    end

    v.state.update(enemie_dog, dt)
    animationManager_update(dt,v.aComp)
    end
end


function enemie_marfian.draw()
  local c = mapManager.camera

  for i, v in ipairs(enemie_marfian.list) do

    love.graphics.setColor(255,0,255)
    --love.graphics.rectangle("fill",v.x-c.pos_x,v.y-c.pos_y,v.width,v.height)
    love.graphics.setColor(255,255,255)
    local d = -v.last_dir
    local s = enemie_marfian.idle
    love.graphics.draw(s.sheet,s.quads[v.aComp.curr_frame],v.x-c.pos_x+v.width/2, v.y-c.pos_y+v.height/2,0,d,1,v.width/2,v.height/2)
    --love.graphics.print(enemie_marfian.name, (v.x + v.width/2) - c.pos_x, (v.y + v.height/2) - c.pos_y)
  end
end

function enemie_marfian.jump(v)
  --... do something maybe
  entryState(v, enemie_jumpState)
end

function enemie_marfian.reachFloor(v)
  v.speedy = 0
  if v.state ~= enemie_walkState then
    entryState(v, enemie_walkState)
  end
end


function entryState(v, state)
  v.state.exit(v)
  v.state = state
  v.state.start(v)

end