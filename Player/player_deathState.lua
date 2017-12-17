player_deathState = {}

local updateDeath, updateTimeout

function player_deathState.load()
  
end

function player_deathState.start()
  player_deathState.step = updateDeath
  player.curr_sprite = player.death
  animationManager_restart(player.curr_sprite.aComp)
end

function player_deathState.update(dt)
  player.speedx = 0
  player.speedy = 0
  player_deathState.step(dt)
end

function updateDeath(dt)
  if animationManager_update(dt,player.curr_sprite.aComp) == -1 then
    player_deathState.step = updateTimeout
    player_deathState.timer = 1
  end
end

function updateTimeout(dt)
  player_deathState.timer = player_deathState.timer - dt
  if player_deathState.timer < 0 then
    game.goToGameOver()
  end
end

function player_deathState.exit()
  
end

function player_deathState.draw()
  
end

function player_deathState.keypressed()
  
end