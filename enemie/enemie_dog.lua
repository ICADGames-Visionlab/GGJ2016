require "enemie/enemie_jumpState"
require "enemie/enemie_walkState"
require "animations"
require "animationManager"

enemie_dog = {}

enemie_dog.list = {}


local entryState

function enemie_dog.spawn(_x, _y, _maxSpeed, _dir_time, _jump_time)
  
  _var = 0.2
    
  if _maxSpeed == nil then
     _maxSpeed = enemie_dog.maxSpeed * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  if _dir_time == nil then
     _dir_time =  enemie_dog.dir_time * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  if _jump_time == nil then
     _jump_time =  enemie_dog.jump_time * (1 + (((2*_var) * love.math.random()) - _var))
  end
  
  _sight = enemie_dog.sight * (1 + (((2*_var) * love.math.random()) - _var))
  local idleComp = animationManager_new(10,1, true)
 table.insert(enemie_dog.list,{name =  enemie_dog.name..table.getn(enemie_dog.list), x = _x, y = _y, sight = _sight, jump_time = _jump_time, jumpForce = enemie_dog.jumpForce, dir_time = _dir_time, maxSpeed = _maxSpeed, invTime = 2 , width = enemie_dog.idle.sheet:getWidth()/5, height = enemie_dog.idle.sheet:getHeight()/2, speedx = 0, speedy = 0, dir = 0, last_dir = -1,state = enemie_walkState, timer_jump = 0, timer_dir = 0, curr_sprite = enemie_dog.idle, animComp=idleComp, idleComp = idleComp, attackComp = animationManager_new(8,0.3, true), reachFloor = enemie_dog.reachFloor})
end

function enemie_dog.load()
  
  enemie_dog.idle = animations.loadSpriteData("/Assets/dog_idle.png",10,5,1,true)
  enemie_dog.attack = animations.loadSpriteData("/Assets/dog_attack.png",8,4,0.3,true)
  --enemie_dog.x = 800
  --enemie_dog.y = 400
  enemie_dog.sight = 500
  enemie_dog.gravity = 1100
  
  enemie_dog.name = "dog"
  enemie_dog.is_jumper = false
  
  enemie_jumpState.load()
  enemie_dog.jumpForce = -500

  enemie_dog.jump_time = 0.3
  enemie_dog.dir_time = 0.8
  enemie_dog.maxSpeed = 100
end

function enemie_dog.start()

  for i, v in ipairs(enemie_dog.list) do
    v.state = enemie_walkState
  end
end

function enemie_dog.update(dt)
  
  for i, v in ipairs(enemie_dog.list) do
    v.speedy = v.speedy + enemie_dog.gravity*dt
    v.timer_dir = v.timer_dir + dt
    
    if math.abs(player.x - v.x) <= v.sight then
      v.curr_sprite = enemie_dog.attack
      v.aComp = v.attackComp
      
      if v.timer_dir > v.dir_time then
        v.timer_dir = 0
        
        if player.x > v.x then
          v.dir = 1
        else 
          v.dir = -1
        end
        v.last_dir = v.dir
      end
      enemie_dog.checkJump()
      
    else
      v.curr_sprite = enemie_dog.idle
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

function enemie_dog.checkJump(v)
  if enemie_dog.is_jumper then
    if (player.y + player.height + 20) < v.y + v.height then
      -- v.speedy = -700
      v.timer_jump = v.timer_jump + dt
      if v.timer_jump > v.jump_time then
        enemie_dog.jump(v)
      end
    else
      v.timer_jump = 0.0
    end
  end
end


function enemie_dog.draw()
  local c = mapManager.camera

  for i, v in ipairs(enemie_dog.list) do

    love.graphics.setColor(255,0,255)
    --love.graphics.rectangle("fill",v.x-c.pos_x,v.y-c.pos_y,v.width,v.height)
    love.graphics.setColor(255,255,255)
    local d = -v.last_dir
    local s = v.curr_sprite
    love.graphics.draw(s.sheet,s.quads[v.aComp.curr_frame],v.x-c.pos_x+v.width/2, v.y-c.pos_y+v.height/2,0,d,1,v.width/2,v.height/2)
    --love.graphics.print(enemie_dog.name, (v.x + v.width/2) - c.pos_x, (v.y + v.height/2) - c.pos_y)
  end
end

function enemie_dog.jump(v)
  --... do something maybe
  entryState(v, enemie_jumpState)
end

function enemie_dog.reachFloor(v)
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