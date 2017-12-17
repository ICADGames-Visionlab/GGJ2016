require "MapManager/tile"
tile_oneway = {}

function tile_oneway.handleVerticalContact(player,block)
  if player.y<block.y and player.y+player.height<=block.y then
    tile.playerTouchedFloor(player)
    return false
  else
    return true
  end
end

function tile_oneway.handleHorizontalContact(player)
  return true
end