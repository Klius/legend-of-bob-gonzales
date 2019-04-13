Game = Object:extend()
function Game:new()
  self.map = Map()
  self.clock = Clock(love.graphics.getWidth()-124,-10,16,0,0)
  self.states = {
    map = 1,
    event = 2,
    place = 3,
  }
  self.currentState = self.states.place
  self.place = Place()
  self.flags = {
    ducha = false,
  }
end
function Game:draw()
  if self.currentState == self.states.map then
    self.map:draw()
  elseif self.currentState == self.states.place then
    self.place:draw()
  end
  love.graphics.print("CurrentState:"..self.currentState,0,460)
  self.clock:draw()
end
function Game:update(dt)
  if self.currentState == self.states.map then
    self.map:update(dt)
  elseif self.currentState == self.states.place then
    self.place:update(dt)
  end
  self.clock:update(dt)
end
function Game:checkMouseClick(x,y,button)
  if self.currentState == self.states.map then
   -- self.map:update(dt)
  elseif self.currentState == self.states.place then
    self.place:checkMouseClick(x,y,button)
  end
end