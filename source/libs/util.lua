function setColor(r,g,b,a)
  major = love.getVersion()
  if major < 11 then
    love.graphics.setColor(r,g,b,a)
  else
    love.graphics.setColor(r/255,g/255,b/255,a/255)
  end
end