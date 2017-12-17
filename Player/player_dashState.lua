player_dashState = {}

function player_dashState.load()
  player_dashState.time = 0.2
end

function player_dashState.start()
  player_dashState.timer = player_dashState.time
  player_dashState.vel = player.dir*player.maxSpeed*4
  player.dashCooldownTimer = player.dashCooldown
end

function player_dashState.update(dt)
  player.speedx = player_dashState.vel
  player.speedy = 0
  player_dashState.timer = player_dashState.timer - dt
  if player_dashState.timer < 0 then
    player.endDash()
  end
end

function player_dashState.draw()
  
end

function player_dashState.exit()
  
end

function player_dashState.keypressed(key)
  
end