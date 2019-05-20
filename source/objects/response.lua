Response = Object:extend()
function Response:new(description,text,time,dialog,x,y)
  self.label = description or "VOID"
  self.text = text or "Respuesta generica de persona humana"
  self.time = time or 5*60
  self.dialog = dialog or 1
  self.hover = false
  self.x = x or 40
  self.y = y or love.graphics.getHeight() - 100
  self.width = 100
  self.height = math.ceil(love.graphics.getFont():getWidth(self.label) / self.width) * (love.graphics.getFont():getHeight()+love.graphics.getFont():getAscent()+love.graphics.getFont():getDescent() )
  self.hOffset = 6
end

function Response:draw()
  if self.hover then
    setColor(0,255,51,255)
  end
  love.graphics.printf(self.label,self.x,self.y,self.width ,"center")
  --love.graphics.print(love.graphics.getFont():getWidth(self.label) / self.width,self.x,self.y)
  love.graphics.rectangle("line",self.x,self.y,self.width ,self.height)
  setColor(255,255,255,255)
end
function Response:update(dt)
  x, y = love.mouse.getPosition( )
  if (x >= self.x) and (y >=self.y) and
    ( x <= self.x+self.width ) and (y <= self.y+self.height) then
    self.hover = true
  else
    self.hover = false
  end
end