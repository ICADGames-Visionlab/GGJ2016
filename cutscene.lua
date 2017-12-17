cutscene = {}

function cutscene.load()
  video = love.graphics.newVideo("Animatic-Tic-Toc-Man_.ogv", true)
end

function cutscene.start()
  love.audio.stop(audio.menuMusic)
  video:play()
end

function cutscene.keypressed(key)
  if key == "escape" then
    endvideo()
  end
end

function cutscene.update(dt)
  if video:isPlaying() == false then
    endvideo()
  end
end

function cutscene.draw()
  love.graphics.draw(video, 0, 0)
end

function endvideo()
  video:pause() 
  game.goToStage()
end