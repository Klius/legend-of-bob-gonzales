--moonshine = require "libs/moonshine"
Object = require "libs/classic"
require "objects/animations"
require "objects/audio-engine"
require "objects/gamestates"
require "objects/config"
require "objects/clock"
require "objects/mapbutton"
require "objects/button"
require "objects/map"
require "objects/game"
require "objects/audioControl"
require "objects/mainMenuScreen"
require "objects/settingsScreen"
function love.load()
  cheat = ""
  state = gameStates.mainMenu
  game = Game()
  --play music
  audiomanager = Audio(config.music,config.sfx)
end

function love.update(dt)
   -- Update world
    if state == gameStates.mainMenu then
      mainMenuScreen:update(dt)
    end
    if state == gameStates.gameLoop then
      game:update(dt)
    end
    if state == gameStates.settingsScreen then
      settingsScreen:update(dt)
    end
end

function love.draw()
  --if defTransition.started == false then
    
    if state == gameStates.gameLoop then
      game:draw()
    elseif state == gameStates.mainMenu then
      mainMenuScreen:draw()
    elseif state == gameStates.settingsScreen  then
      settingsScreen:draw()
    end
    if state == gameStates.multiplayerScreen then
      controllerScreen:draw(dt)
    end
  --end
  love.graphics.print(cheat,0,0)
end



--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Drawing functions
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
]]
function drawMenuBackground()
  love.graphics.setColor(223/255,113/255,38/255,1)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
  love.graphics.setColor(1,1,1,1)
end
--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@
  CHEATS
@@@@@@@@@@@@@@@@@@@@@@@@@@
]]
function checkForCheats()
  local cheats = {
    weiner = function() 
              for i=1,3 do
                race:nextLap(player)
              end
             end,
    cls = function()
            cheat = ""
          end,
    changetrack = function()
      audiomanager:changeTrack(self.audios.race[1])
    end
  }
  for i,v in pairs(cheats) do
    if string.find(cheat,i) then
      cheats[i]()
      cheat =""
    end
  end
  if cheat:len() > 20  then
    cheat = ""
  end
end

--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  
  HANDLING
  
@@@@@@@@@@@@@@@@@@@@@@@@@@]]

function inputHandler( input , id)
    local action = state.bindings[input]
    if action then  return action( id )  end
end

function love.keypressed( k )
    -- you might want to keep track of this to change display prompts
    INPUTMETHOD = "keyboard"
    cheat = cheat .. k
    local binding = state.keys[k]
    return inputHandler( binding ,"keyboard")
end
function love.keyreleased( k )
    local binding = state.keysReleased[k]
    return inputHandler( binding , "keyboard" )
end
function love.gamepadpressed( gamepad, button )
    -- you might want to keep track of this to change display prompts
    INPUTMETHOD = "gamepad"
    local binding = state.buttons[button]
    return inputHandler( binding , gamepad:getGUID())
end
function love.gamepadreleased( gamepad, button )
    local binding = state.buttonsReleased[button]
    return inputHandler( binding , gamepad:getGUID() )
end

function love.touchpressed( id, x, y, dx, dy, pressure )
  local binding = state.buttons[phoneUI:checkButtonTouched(x,y,10,10,id)]
  touchdebug = {x = x,y = y, dx = 10, dy = 10, id= id}
  return inputHandler( binding )
end
function love.touchreleased( id, x, y, dx, dy, pressure )
  local binding = state.buttonsReleased[phoneUI:checkButtonTouched(x,y,10,10,id)]
  touchdebug = {x = dx,y = dy, dx = 10, dy = 10 ,id= id}
  return inputHandler( binding )
end
function love.gamepadaxis( gamepad, axis, value )
  INPUTMETHOD = "gamepad"
  local direction = gamepad:getGamepadAxis("leftx")
  local button = ""
  local binding = ""
  if direction > config.joy_sen then
    button = "jright"
    binding = state.buttons[button]
    inputHandler( binding ,gamepad:getGUID())
    --stop rotating left
    button = "jleft"
    binding = state.buttonsReleased[button]
    inputHandler( binding , gamepad:getGUID())
  elseif direction < -config.joy_sen then
    button = "jleft"
    binding = state.buttons[button]
    inputHandler( binding, gamepad:getGUID() )
    --stop rotating right
    button = "jright"
    binding = state.buttonsReleased[button]
    inputHandler( binding, gamepad:getGUID() )
  else
    button = "jright"
    local button2="jleft"
    binding = state.buttonsReleased[button]
    inputHandler( binding, gamepad:getGUID() )
    binding = state.buttonsReleased[button2]
    inputHandler( binding, gamepad:getGUID() )
  end
end
  function love.mousepressed(x,y,button,istouch,presses)
    if state == gameStates.mainMenu then
      mainMenuScreen:checkMouseClick(x,y,button)
    end
    cheat = "x:"..x.." y:"..y
  end
