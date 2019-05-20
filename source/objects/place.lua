Place = Object:extend()

function Place:new()
  self.id = id or "casa"
  self.backImage= img or love.graphics.newImage("assets/home-interior.png")
  self.x = 0
  self.y = 0
  self.height = 480
  self.width = 640
  self.frames = getAnimations(self.backImage,self.width,self.height)
  self.currentFrame = 1
  self.time = 0
  self.frameTime = 0.8
  self.name = name or "Casa"
  self.options={
    [1] = Button(love.graphics.getWidth()/3-60,love.graphics.getHeight()/4*3,"Café",function() self.actions[1]() end),
    [2] = Button(love.graphics.getWidth()/3*2-60,love.graphics.getHeight()/4*3,"Ducha",function() self.actions[2]()  end),
    [3] = Button(love.graphics.getWidth()/2-60,love.graphics.getHeight()-love.graphics.getHeight()/8,"Salir",function() self.actions[3]() end),
  }
  self.actions = {
      [1] =function()
        game.clock:addSeconds(60*5)
        game.flags.cafe = true
      end,
      [2] =function()
        game.clock:addSeconds(60*20)
        game.flags.ducha = true
      end,
      [3] = function()
        if game.flags.ducha and game.flags then
          game.currentState = game.states.map
        end
      end,
  }
  self. message = "Que quieres hacer?"
end

function Place:draw()
  love.graphics.draw(self.backImage,self.frames[self.currentFrame],self.x,self.y)
  love.graphics.setColor(0.2,0.2,0.2,0.5)
  love.graphics.rectangle("fill",0,love.graphics.getHeight() - love.graphics.getHeight()/3 ,640,love.graphics.getHeight()/3)
  love.graphics.setColor(1,1,1,1)
  love.graphics.printf(self.message,0,love.graphics.getHeight()+4 - love.graphics.getHeight()/3,640,"center")
  for  i = 1,#self.options,1 do
    self.options[i]:draw()
  end
end
function Place:update(dt)
  self.time = self.time +dt
  if self.time >= self.frameTime then
    self:animationNextFrame()
    self.time = 0
  end
  for  i = 1,#self.options,1 do
    self.options[i]:update(dt)
  end
end

function Place:animationNextFrame()
  self.currentFrame = self.currentFrame+1
  if self.currentFrame > #self.frames then
    self.currentFrame = 1
  end
end

function Place:checkMouseClick(x,y,button)
  for i=#self.options,1,-1 do
      if x >self.options[i].x and
        x < self.options[i].x+self.options[i].width and
        y > self.options[i].y and
        y < self.options[i].y+self.options[i].height then
          self.options[i]:click()
          break
      end
    end
end