require "MapManager/tile"
tile_hazard = {}

function tile_hazard.handleHorizontalContact(player)
  tile.playerHitHazard(player)
  return true
end

function tile_hazard.handleVerticalContact(player)
  tile.playerHitHazard(player)
  return true
end