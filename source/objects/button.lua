Button = Object:extend()

function Button:new(x,y,text,action)
  self.x = x or 0
  self.width = w or 128
  self.height = h or 32
  self.y = y or 0
  --self.backImage = love.graphics.newImage(img or "assets/button-color.png")
  --self.frames = getAnimations(self.backImage,self.width,self.width)
  self.isPressed = false
  self.isSwitch = false
  self.text = text or "??????"
  self.pressCounter = 0
  self.action = action or function () print("action") end
  self.inaction = function() print("inaction") end
end

function Button:draw()
  if self.isPressed then
    love.graphics.setColor(1,1,0.8,1)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
    love.graphics.printf(self.text,self.x,self.y+8,self.width,"center")
    love.graphics.setColor(1,1,1,1)
  else
    love.graphics.setColor(0.3,0.3,0.3,1)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
    love.graphics.printf(self.text,self.x,self.y+8,self.width,"center")
  end
end

function Button:update(dt)
  if not self.isSwitch and self.isPressed then
    self.pressCounter = self.pressCounter + dt
    if self.pressCounter > 0.1 then
      self.isPressed =false
      self.pressCounter = 0
    end
  end
end

function Button:click()
  if self.isPressed then
    self.isPressed = false
    self.inaction()
  else
    self.isPressed = true
    self.action()
  end
end