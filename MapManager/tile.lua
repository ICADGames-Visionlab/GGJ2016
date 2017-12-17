tile = {}

function tile.playerTouchedFloor(player)
  --[[
  if tile.touchedFloorCallback ~= nil then
    tile.touchedFloorCallback()
  end]]
  player.reachFloor(player)
end

function tile.playerHitHazard(player)
  --[[
  if tile.hitHazardCallback ~= nil then
    tile.hitHazardCallback()
  end]]
  
end