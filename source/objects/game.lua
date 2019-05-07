Game = Object:extend()
function Game:new()
  self.map = Map()
  self.clock = Clock(love.graphics.getWidth()-124,-10,16,0,0)
  self.states = {
    map = 1,
    event = 2,
    place = 3,
  }
  self.places = {
    casa = Place()
  }
  self.timetable ={
    casa = {
      casa = 2,
      estudio = 5,
      badulaque = 8,
      mendez = 12,
      bocanord = 15
    },
    estudio = {
      casa = 5,
      estudio = 5,
      badulaque = 8,
      mendez = 12,
      bocanord = 15
    },
    badulaque = {
      casa = 5,
      estudio = 5,
      badulaque = 8,
      mendez = 12,
      bocanord = 15
    },
    mendez = {
      casa = 5,
      estudio = 5,
      badulaque = 8,
      mendez = 12,
      bocanord = 15
    },
    bocanord = {
      casa = 5,
      estudio = 5,
      badulaque = 8,
      mendez = 12,
      bocanord = 15
    },
  }
  self.currentState = self.states.place
  self.place = self.places.casa
  self.flags = {
    ducha = false,
    cafe = false
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
    self.map:checkMouseClick(x,y,button)
  elseif self.currentState == self.states.place then
    self.place:checkMouseClick(x,y,button)
  end
end
function Game:moveToPlace(place)
  self:addTime(self.place.id,place)
  self.place = self.places[place]
  self.currentState = self.states.place
end
function Game:addTime(from,to)
  game.clock:addSeconds(self.timetable[from][to]*60)
end