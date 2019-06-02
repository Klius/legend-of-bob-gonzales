DialogScene = Object:extend()

function DialogScene:new() 
  self.background = love.graphics.newImage("assets/dialogdummy.png")
  --self.char
  self.dialogs = {
    [1] = Dialog("Blablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla",{
        [1] = Response("repite el dialogo 1","Repitemelo majete",5,1),
        [2] = Response("Salta al dialogo 2","Vamos a seguir la conversacion no?",5,2,love.graphics.getWidth()/2-love.graphics.getWidth()/16,love.graphics.getHeight()/2+100),
        [3] = Response("Salta al dialogo 3", "Adelantamos un poquico el tema",5,3,love.graphics.getWidth()-140),
        [4] = Response("Salta al final", "Adelantamos un poquico el tema",5,4,love.graphics.getWidth()/2-love.graphics.getWidth()/16,
            love.graphics.getHeight()-love.graphics.getHeight()/8),
        }),
    [2] = Dialog("bleblebleble"),
    [3] = Dialog("bliblibli"),
    [4] = Dialog("blobloblo"),
  }
  self.currentDialog = 1
  self.totalTime = 0
  self.endDialog = "Click to exit conversation"
end

function DialogScene:draw() 
  love.graphics.draw(self.background)
  setColor(0,0,0,128)
  love.graphics.rectangle("fill",0,love.graphics.getHeight() - love.graphics.getHeight()/3 ,640,love.graphics.getHeight()/3)
  setColor(255,255,255,255)
  self.dialogs[self.currentDialog]:draw()
  if not self.dialogs[self.currentDialog].displaying and self.currentDialog < #self.dialogs then
    for i,r in pairs(self.dialogs[self.currentDialog].responses) do
      r:draw()
    end
  elseif self.currentDialog >= #self.dialogs then
    love.graphics.print(self.endDialog,40,love.graphics.getHeight()-100)
  end
end

function DialogScene:update(dt) 
  self.dialogs[self.currentDialog]:update(dt)
  if not self.dialogs[self.currentDialog].displaying and self.currentDialog <= #self.dialogs then
    for i,r in pairs(self.dialogs[self.currentDialog].responses) do
        r:update(dt)
    end
  end
end

function DialogScene:checkMouseClick(x,y,button)
  if self.currentDialog < #self.dialogs then 
    local responses = self.dialogs[self.currentDialog].responses
    for i,r in pairs(responses) do
      if r.hover == true then
        r.hover = false
        self:jumpToDialog(r.dialog,r.time)
      end
    end
  else
    --todo implement logic
    game.clock:addSeconds(self.totalTime)
    game.currentState = game.states.map
    
  end
end
function DialogScene:jumpToDialog(dialog,time)
  self.dialogs[self.currentDialog]:reset()
  self.currentDialog = dialog
  self.totalTime = self.totalTime+time
end