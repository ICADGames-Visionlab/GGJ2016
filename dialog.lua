dialog = {}

function dialog.load()
  dialog.sound = love.audio.newSource("typewriter.wav","static")
  dialog.soundTimer = 6
end

function dialog.newDialogText(string,x,y)
  local dText = {text = string, length = 0, speed = 20, finished = false, x=x, y=y, timer=0}
  --[[
  dText.text = string
  dText.length = 0
  dText.speed = 10
  dText.finished = false
  ]]
  return dText
end

function dialog.updateText(dt,dText)
  if not dText.finished then
    dText.length = dText.length+dt*dText.speed
    dText.timer = dText.length+dt*dText.speed
    if dText.timer>dialog.soundTimer then
      dText.timer = dText.timer - dialog.soundTimer
      love.audio.play(dialog.sound)
    end
    if dText.length>#dText.text then
      dText.finished = true
      dText.length = #dText.text
    end
  end
end

function dialog.drawText(dText)
  local msg = string.sub(dText.text, 1, math.floor(dText.length))
  love.graphics.print(msg,dText.x,dText.y)
end