require "enemie/enemie_jumpState"
require "enemie/enemie_walkState"
require "animations"
require "animationManager"

enemie_human = {}
enemie_human.list = {}


local entryState

function enemie_human.spawn(_x, _y, _maxSpeed, _dir_time, _jump_time)
  
  _var = 0.2
    
  if _maxSpeed == nil then
     _maxSpeed = enemie_human.maxSpeed * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  if _dir_time == nil then
     _dir_time =  enemie_human.dir_time * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  if _jump_time == nil then
     _jump_time =  enemie_human.jump_time * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  _sight = enemie_human.sight * (1 + (((2*_var) * love.math.random()) - _var))
  local idleComp = animationManager_new(5,1, true)
 table.insert(enemie_human.list,{name =  enemie_human.name..table.getn(enemie_human.list), x = _x, y = _y, sight = _sight, jump_time = _jump_time, jumpForce = enemie_human.jumpForce, dir_time = _dir_time, maxSpeed = _maxSpeed, invTime = 2 , width = enemie_human.idle.sheet:getWidth()/5, height = enemie_human.idle.sheet:getHeight(), speedx = 0, speedy = 0, dir = 0, last_dir = -1, state = enemie_walkState, timer_jump = 0, timer_dir = 0, aComp = idleComp, curr_sprite = enemie_human.idle,idleComp = idleComp, walkComp = animationManager_new(18,1.5,true), reachFloor = enemie_human.reachFloor})
end

function enemie_human.load()
  
  enemie_human.idle = animations.loadSpriteData("/Assets/valentaoIdle.png",5,5,1,true)
  enemie_human.walk = animations.loadSpriteData("/Assets/valentao_walk.png",18,5,1.5,true)
  
  --enemie_human.x = 800
  --enemie_human.y = 400
  enemie_human.sight = 180
  enemie_human.gravity = 1100
  
  enemie_human.name = "human"
  enemie_human.is_jumper = false
  
  enemie_jumpState.load()
  enemie_human.jumpForce = -500

  enemie_human.jump_time = 0.3
  enemie_human.dir_time = 0.8
  enemie_human.maxSpeed = 50
end

function enemie_human.start()

  for i, v in ipairs(enemie_human.list) do
    v.state = enemie_walkState
  end
end

function enemie_human.update(dt)
  
  for i, v in ipairs(enemie_human.list) do
    v.speedy = v.speedy + enemie_human.gravity*dt
    v.timer_dir = v.timer_dir + dt
    
    if math.abs(player.x - v.x) <= v.sight then
      v.curr_sprite = enemie_human.walk
      v.aComp = v.walkComp
      if v.timer_dir > v.dir_time then
        v.timer_dir = 0
        
        if player.x > v.x then
          v.dir = 1
        else 
          v.dir = -1
        end
        
        v.last_dir = v.dir
      end
      enemie_human.checkJump(v)
    else
      v.curr_sprite = enemie_human.idle
      v.aComp = v.idleComp
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

function enemie_human.checkJump(v)
  if enemie_human.is_jumper then
    if (player.y + player.height + 20) < v.y + v.height then
       -- v.speedy = -700
      v.timer_jump = v.timer_jump + dt
      if v.timer_jump > v.jump_time then
        enemie_human.jump(v)
      end
    else
      v.timer_jump = 0.0
    end
  end
end

function enemie_human.draw()
  local c = mapManager.camera

  for i, v in ipairs(enemie_human.list) do

    love.graphics.setColor(255,0,255)
    --love.graphics.rectangle("fill",v.x-c.pos_x,v.y-c.pos_y,v.width,v.height)
    love.graphics.setColor(255,255,255)
    local d = -v.last_dir
    local s = v.curr_sprite
    love.graphics.draw(s.sheet,s.quads[v.aComp.curr_frame],v.x-c.pos_x+v.width/2, v.y-c.pos_y+v.height/2,0,d,1,v.width/2,v.height/2)
   -- love.graphics.print(enemie_human.name, (v.x + v.width/2) - c.pos_x, (v.y + v.height/2) - c.pos_y)
  end
end

function enemie_human.jump(v)
  --... do something maybe
  entryState(v, enemie_jumpState)
end

function enemie_human.reachFloor(v)
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