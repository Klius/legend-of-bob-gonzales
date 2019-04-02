Map = Object:extend()
function Map:new()
  self.x = 0
  self.y = 0
  self.background = love.graphics.newImage("assets/map-carmel.png")
  self.places = {
    [1] = Mapbutton(40,316,"  Casa","assets/home.png"),
    [2] = Mapbutton(170,326,"Estudio","assets/estudio.png"),
    [3] = Mapbutton(364,380,"Badulaque","assets/badulaque.png","bottom"),
    [4] = Mapbutton(294,120,"Mendez","assets/mendez.png","upper"),
    [5] = Mapbutton(404,70,"Bocanord","assets/boca.png","upper"),
  }
end
function Map:draw()
  love.graphics.draw(self.background,self.x,self.y)
  for i=1,#self.places,1 do
    self.places[i]:draw()
  end
end
function Map:update(dt)

end