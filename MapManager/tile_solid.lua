require "MapManager/tile"
tile_solid = {}

function tile_solid.handleHorizontalContact(player)
  return false
end

function tile_solid.handleVerticalContact(player)
  if player.speedy>0 then
    tile.playerTouchedFloor(player)
  end
  return false
end