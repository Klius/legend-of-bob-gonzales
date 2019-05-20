Dialog = Object:extend()
function Dialog:new(text,responses)
  self.text = text or "Cosa de color Rosa"
  self.responses =  responses 
  self.x = x or 40
  self.y = y or 40
  self.displaying = true
  self.speed = 0.04
  self.position = 0
  self.index = 0
  self.count = 0
  self.dtext =""
  self.l = self.text:len()
end

function Dialog:draw()
   love.graphics.printf(self.dtext,40,40,200,"left")
end
function Dialog:update(dt)
  if self.displaying then
    self.count = self.count + dt
    if self.count > self.speed then
      self.index = self.index + 2
      self.dtext = string.sub(self.text,1,self.index)
      self.count = 0
      if self.index >= self.l then
        --stop animating text
        self.displaying = false
      end
    end
  end
end