Button = Object:extend()

function Button:new(img,x,y)
  self.x = x or 0
  self.width = 128
  self.y = y or 0
  self.backImage = love.graphics.newImage(img or "assets/button-color.png")
  self.frames = getAnimations(self.backImage,self.width,self.width)
  self.isPressed = false
  self.isSwitch = false
  self.pressCounter = 0
  self.action = function () print("action") end
  self.inaction = function() print("inaction") end
end

function Button:draw()
  if self.isPressed then
    love.graphics.draw(self.backImage,self.frames[2],self.x,self.y)
  else
    love.graphics.draw(self.backImage,self.frames[1],self.x,self.y)
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