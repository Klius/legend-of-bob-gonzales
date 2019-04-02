gameStates = {}
gameStates.mainMenu = {
  bindings = {
    changeOptionUp = function() mainMenuScreen:changeOption(-1) end,
    changeOptionDown = function() mainMenuScreen:changeOption(1) end,
    selectOption = function() mainMenuScreen:selectOption() end,
    addSecond = function()mainMenuScreen.testclock:addSeconds(3600) end,
    quit       = function() love.event.quit() end,
  },
  keys = {
    space     = "selectOption",
    up         = "changeOptionUp",
    down       = "changeOptionDown",
    ["return"] = "selectOption",
    ["+"]          = "addSecond",
    escape = "quit"
  },
  keysReleased ={
  },
  buttons = {
    dpup = "changeOptionUp",
    dpdown ="changeOptionDown",
    a = "selectOption",
    y = "quit",
    start = "selectOption",
  },
  buttonsReleased = {
  }
}
gameStates.gameLoop = {
  bindings = {
    goBack = function()  end,
    moveUp = function()  end,
    moveDown = function()  end,
    assignControllers = function()  end,
  },
  keys = {
    space     = "assignControllers",
    ["return"] = "assignControllers",
    up = "moveUp",
    down = "moveDown", 
    escape = "goBack"
  },
  keysReleased = {},
  buttons = {
    dpup = "moveUp",
    dpdown = "moveDown",
    a = "assignControllers",
    start = "assignControllers"
  },
  buttonsReleased = {}
}
gameStates.dummy = {
  bindings = {
    goBack = function() state = gameStates.mainMenu end,
    moveUp = function() audiomanager:changeOption(-1) end,
    moveDown = function() audiomanager:changeOption(1) end,
    assignControllers = function() controllerScreen:assignControllers() end,
  },
  keys = {
    space     = "assignControllers",
    ["return"] = "assignControllers",
    up = "moveUp",
    down = "moveDown", 
    escape = "goBack"
  },
  keysReleased = {},
  buttons = {
    dpup = "moveUp",
    dpdown = "moveDown",
    a = "assignControllers",
    start = "assignControllers"
  },
  buttonsReleased = {}
}
gameStates.settingsScreen = {
  bindings = {
    changeOptionUp = function() settingsScreen:changeOption(-1) end,
    changeOptionDown = function() settingsScreen:changeOption(1) end,
    changeControlRight = function() settingsScreen:changeControl(1) end,
    changeControlLeft = function() settingsScreen:changeControl(-1) end,
    selectOption = function() settingsScreen:selectOption() end,
    back       = function() settingsScreen:back() end,
  },
  keys = {
    space     = "selectOption",
    up         = "changeOptionUp",
    down       = "changeOptionDown",
    left = "changeControlLeft",
    right =  "changeControlRight",
    ["return"] = "selectOption",
    escape = "back"
  },
  keysReleased ={
  },
  buttons = {
    dpup = "changeOptionUp",
    dpdown ="changeOptionDown",
    dpleft = "changeControlLeft",
    dpright =  "changeControlRight",
    a = "selectOption",
    y = "back",
    start = "selectOption",
  },
  buttonsReleased = {
  }
}
gameStates.pause = {
  bindings = {
    goBack = function() 
      pauseMenu.currentOption = 1
      pauseMenu:selectOption()
    end,
    moveUp = function()  pauseMenu:changeOption(-1) end,
    moveDown = function() pauseMenu:changeOption(1) end,
    changeControlRight = function() pauseMenu:changeControl(1) end,
    changeControlLeft = function() pauseMenu:changeControl(-1) end,
    confirm = function() pauseMenu:selectOption() end,
  },
  keys = {
    space     = "confirm",
    ["return"] = "confirm",
    up = "moveUp",
    down = "moveDown",
    left = "changeControlLeft",
    right = "changeControlRight",
    escape = "goBack"
  },
  keysReleased = {},
  buttons = {
    dpup = "moveUp",
    dpdown = "moveDown",
    dpleft = "changeControlLeft",
    dpright = "changeControlRight",
    a = "confirm",
    start = "confirm"
  },
  buttonsReleased = {}
}
--Stops the player from getting buttons stuck after pause
gameStates.checkInputs = function (player)
  if player.gamepad == "keyboard" then
    for k,v in pairs(state.keys) do
      if k ~= "escape" then
        local status = love.keyboard.isDown( k )
        if status then
          local binding = state.keys[k]
          inputHandler( binding ,"keyboard")
        else
          local binding = state.keysReleased[k]
          inputHandler( binding ,"keyboard")
        end
      end
    end
  else --gamepad
      local joysticks = love.joystick.getJoysticks()
      local joy = nil
      for i, joystick in ipairs(joysticks) do
        if joystick:getGUID() == player.gamepad then
          joy = joystick
        end
      end
    for k,v in pairs(state.buttons) do
      if string.find(k, "j") then
      else
        local status = joy:isGamepadDown( k )
        if status then
          local binding = state.buttons[k]
          inputHandler( binding ,player.gamepad)
        else
          local binding = state.buttonsReleased[k]
          inputHandler( binding ,player.gamepad)
        end
      end
    end
  end
end