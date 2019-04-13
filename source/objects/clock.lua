Clock = Object:extend()

function Clock:new(x,y,hours,minutes,seconds)
  self.font = love.graphics.newFont("assets/fonts/alarmclock.ttf",18)
  self.x = x or 0
  self.y = y or 0
  self.addedSeconds = 0
  self.seconds = seconds or 0
  self.minutes = minutes or 0
  self.hours = hours or 0
  self.timeString = "00:00:00"
  self:timeToString()
  self.back = love.graphics.newImage("assets/clock.png")
end

function Clock:draw()
  love.graphics.setFont(self.font)
  love.graphics.draw(self.back,self.x,self.y)
  love.graphics.setColor(232/255,242/255,162/255)
  love.graphics.rectangle("fill",self.x+24,self.y+50,80,20)
  love.graphics.setColor(0,0,0,1)
  love.graphics.print(self.timeString,self.x+27,self.y+50)
  love.graphics.setColor(255/255,255/255,255/255,1)
  love.graphics.setFont(love.graphics.newFont(18))
end
function Clock:update(dt)
  if self.addedSeconds > 0 then
    self.addedSeconds = self.addedSeconds -10
    self.seconds = self.seconds+10
    self:updateTime()
  end
end
function Clock:addMinutes(m)
  self.minutes = self.minutes+m
  self:updateTime()
end
function Clock:addSeconds(s)
  self.addedSeconds = self.addedSeconds + s
end
function Clock:addHours(h)
  self.hours = self.hours+h
  self:updateTime()
end


function Clock:updateTime()
  if self.seconds > 59 then
    self.seconds = 0
    self.minutes = self.minutes + 1
  end
  if self.minutes > 59 then 
    self.minutes = 0
    self.hours = self.hours +1
  end
  if self.hours > 23 then
    self.hours = 0
  end
  self:timeToString()
end
function Clock:timeToString()
  local str = ""
  if self.hours < 10 then
    str = "0"
  end
  str = str..self.hours..":"
  if self.minutes < 10 then
    str = str.."0"
  end
  str = str..self.minutes..":"
  if self.seconds < 10 then
    str = str.."0"
  end
  str = str..self.seconds
  self.timeString = str
end