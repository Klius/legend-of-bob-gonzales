Game = Object:extend()
function Game:new()
  self.map = Map()
  self.clock = Clock(love.graphics.getWidth()-124,-10)
  self.states = {
    map = 1,
    event = 2,
    place = 3,
  }
  self.currentState = self.states.map
end
function Game:draw()
  if self.currentState == self.states.map then
    self.map:draw()
  end
  self.clock:draw()
end
function Game:update(dt)
  if self.currentState == self.states.map then
    self.map:update(dt)
  end
  self.clock:update(dt)
end