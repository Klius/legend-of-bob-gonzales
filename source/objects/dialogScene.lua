DialogScene = Object:extend()

function DialogScene:new() 
  self.background = love.graphics.newImage("assets/dialogdummy.png")
  --self.char
  self.dialogs = {
    [1] = Dialog("Blablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla",{
        [1] = Response("repite el dialogo 1","Repitemelo majete",5,1),
        [2] = Response("Salta al dialogo 2","Vamos a seguir la conversacion no?",5,1,200),
        [3] = Response(),
        [4] = Response(),
        }),
  }
  self.currentDialog = 1
  self.totalTime = 0
end

function DialogScene:draw() 
  love.graphics.draw(self.background)
  setColor(0,0,0,128)
  love.graphics.rectangle("fill",0,love.graphics.getHeight() - love.graphics.getHeight()/3 ,640,love.graphics.getHeight()/3)
  setColor(255,255,255,255)
  self.dialogs[self.currentDialog]:draw()
  if not self.dialogs[self.currentDialog].displaying then
    for i,r in pairs(self.dialogs[self.currentDialog].responses) do
      r:draw()
    end
  end
end

function DialogScene:update(dt) 
  self.dialogs[self.currentDialog]:update(dt)
  if not self.dialogs[self.currentDialog].displaying then
    for i,r in pairs(self.dialogs[self.currentDialog].responses) do
        r:update(dt)
    end
  end
end