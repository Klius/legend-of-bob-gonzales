mainMenuScreen = {  
  bigFont = love.graphics.newFont(30),
  defaultFont = love.graphics.newFont(18),
  currentOption = 1,
  buttons = {
    [1] = Button(love.graphics.getWidth()/2-60,love.graphics.getHeight()/2,"Empezar",function() state=gameStates.gameLoop end),
    [2] = Button(love.graphics.getWidth()/2-60,love.graphics.getHeight()/2+128,
                  "Ajustes",
                  function ()
                    state = gameStates.settingsScreen
                  end),
  },
  options = {
    [1] = { 
      accessible = true,
      changeState = function ()
        
      end
    },
    [2] = {
      text = "Ajustes",
      description = "Ajusta el juego a tu gustirrico",
      accessible = true,
      x = love.graphics.getWidth()/2-60,
      y = love.graphics.getHeight()/2+60,
      changeState = function ()
        state = gameStates.settingsScreen
      end
    }
  }
}
mainMenuScreen.update = function (self,dt)
  for k,v in ipairs(self.buttons) do
    v:update(dt)
  end
end
mainMenuScreen.draw = function (self)
  love.graphics.setColor(223/255,113/255,38/255,1)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
  love.graphics.setColor(1,1,1,1)
  for k,v in ipairs(self.buttons) do
    v:draw()
  end
  love.graphics.setColor(1,1,1,1)
end

mainMenuScreen.changeOption = function(self, increment)
  self.currentOption = self.currentOption+increment
  if self.currentOption < 1 then
    self.currentOption = #self.options
  elseif self.currentOption > #self.options then
    self.currentOption = 1
  end
  if self.options[self.currentOption].accessible == false then
    self:changeOption(increment)
  end
  audiomanager:playSFX(audiomanager.audios.selectFX)
end
mainMenuScreen.selectOption = function(self)
  if self.options[self.currentOption].accessible then
    self.options[self.currentOption].changeState()
  end
end
mainMenuScreen.checkMouseClick = function (self,x,y,button)
    --check if click is inside buttons
    for i=#self.buttons,1,-1 do
      if x >self.buttons[i].x and
        x < self.buttons[i].x+self.buttons[i].width and
        y > self.buttons[i].y and
        y < self.buttons[i].y+self.buttons[i].height then
          self.buttons[i]:click()
          break
      end
    end
    
end