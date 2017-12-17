audio={}

function audio.load()
  audio.menuMusic = love.audio.newSource("/Assets/OST/Titulo.mp3")
  audio.stageMusic = love.audio.newSource("/Assets/OST/Distrito Pacifico.mp3")
  audio.bossMusic = love.audio.newSource("/Assets/OST/Distrito Destruido.mp3")
  audio.gameoverMusic = love.audio.newSource("/Assets/SFX/Game Over.mp3")
  audio.musicPlaying = nil
  audio.pJumpSound = love.audio.newSource("/Assets/SFX/Pulo.mp3")
  audio.pJumpSound:setVolume(0.3)
  audio.pPunchSound = love.audio.newSource("/Assets/SFX/Soco.mp3")
  audio.pPunchSound:setVolume(0.3)
  audio.pDamageSound = love.audio.newSource("/Assets/SFX/Dano.mp3")
  audio.pDamageSound:setVolume(0.3)
  audio.menuStartSound = love.audio.newSource("/Assets/SFX/Clique.mp3")
  audio.menuStartSound:setVolume(0.3)
  audio.powerupSound = love.audio.newSource("/Assets/SFX/Power Up.mp3")
  audio.powerupSound:setVolume(0.5)
  --etc
end

function audio.play(music)
  audio.musicPlaying = music
  if audio.musicPlaying ~= nil then
    love.audio.stop(audio.musicPlaying)
  end
	music:setLooping(true)
  music:setVolume(0.3)
	love.audio.play(music)
end

function audio.playPlayerJump()
  audio.playSfx(audio.pJumpSound)
end
function audio.playPlayerPunch()
  audio.playSfx(audio.pPunchSound)
end
function audio.playPlayerDamage()
  audio.playSfx(audio.pDamageSound)
end
function audio.playMenuStart()
  audio.playSfx(audio.menuStartSound)
end
function audio.playPowerup()
  audio.playSfx(audio.powerupSound)
end
function audio.playGameover()
  audio.playSfx(audio.gameoverMusic)
end
function audio.playBossMusic()
  audio.play(audio.bossMusic)
end
function audio.playSfx(sfx)
  if sfx:isPlaying() then
    love.audio.stop(sfx)
  end
  love.audio.play(sfx)
end
