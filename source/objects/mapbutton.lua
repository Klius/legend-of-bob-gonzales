Mapbutton = Object:extend()

function Mapbutton:new(x,y,text,img,dir,action)
  self.x = x or 0
  self.width = w or 64
  self.height = h or 64
  self.y = y or 0
  self.direction = dir or "upper"
  self.backImage = love.graphics.newImage(img or "assets/home.png")
  self.frames = getAnimations(self.backImage,self.width,self.height)
  self.isPressed = false
  self.isSwitch = false
  self.text = text or "??????"
  self.pressCounter = 0
  self.action = action or function () print("action") end
  self.inaction = function() print("inaction") end
end

function Mapbutton:draw()
  if self.isPressed then
    love.graphics.draw(self.backImage,self.frames[2],self.x,self.y)
  else
    love.graphics.draw(self.backImage,self.frames[1],self.x,self.y)
  end
  if self.direction == "upper" then
    love.graphics.print(self.text,self.x,self.y-self.height/3)
  elseif self.direction == "bottom" then
    love.graphics.print(self.text,self.x,self.y+self.height)
  end
end

function Mapbutton:update(dt)
  if not self.isSwitch and self.isPressed then
    self.pressCounter = self.pressCounter + dt
    if self.pressCounter > 0.1 then
      self.isPressed =false
      self.pressCounter = 0
    end
  end
end

function Mapbutton:click()
  if self.isPressed then
    self.isPressed = false
    self.inaction()
  else
    self.isPressed = true
    self.action()
  end
end