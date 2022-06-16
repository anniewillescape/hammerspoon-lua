hs.window.animationDuration = 0
units = {
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  right30       = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
  left70        = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  topright50    = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  botright50    = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  topleft50     = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  botleft50     = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

mash = { 'ctrl', 'option' }
hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():move(units.right50, nil, true) end)
hs.hotkey.bind(mash, 'left', function() hs.window.focusedWindow():move(units.left50, nil, true) end)
hs.hotkey.bind(mash, 'up', function() hs.window.focusedWindow():move(units.top50, nil, true) end)
hs.hotkey.bind(mash, 'down', function() hs.window.focusedWindow():move(units.bot50, nil, true) end)

hs.hotkey.bind(mash, 'e', function() hs.window.focusedWindow():move(units.left70, nil, true) end)
hs.hotkey.bind(mash, 't', function() hs.window.focusedWindow():move(units.right30, nil, true) end)

hs.hotkey.bind(mash, 'i', function() hs.window.focusedWindow():move(units.topright50, nil, true) end)
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():move(units.botright50, nil, true) end)
hs.hotkey.bind(mash, 'u', function() hs.window.focusedWindow():move(units.topleft50, nil, true) end)
hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():move(units.botleft50, nil, true) end)

hs.hotkey.bind(mash, 'return', function() hs.window.focusedWindow():move(units.maximum, nil, true) end)

-- leftCmdで英入力 rightCmdで
local simpleCmd = false
local map = hs.keycodes.map
local function eikanaEvent(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if event:getType() == hs.eventtap.event.types.keyDown then
        if f['cmd'] then
            simpleCmd = true
        end
    elseif event:getType() == hs.eventtap.event.types.flagsChanged then
        if not f['cmd'] then
            if simpleCmd == false then
                if c == map['cmd'] then
                    hs.keycodes.setMethod('Alphanumeric (Google)')
                elseif c == map['rightcmd'] then
                    hs.keycodes.setMethod('Hiragana (Google)')
                end
            end
            simpleCmd = false
        end
    end
end

eikana = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged}, eikanaEvent)
eikana:start()

-- leftCmdダブルクリックで日→英 変換
firstCmd = false
secondCmd = false

local function cancelCmd()
    firstCmd = false
    secondCmd = false
end

local function conversion(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if event:getType() == hs.eventtap.event.types.flagsChanged then
        if c == map['cmd']then
            if firstCmd then
                secondCmd = true
            end
            firstCmd = true
            hs.timer.doAfter(0.1, function()
                cancelCmd()
            end)
            if firstCmd and secondCmd then
                cancelCmd()
                -- hs.application.launchOrFocusByBundleID('com.apple.Terminal')
                hs.eventtap.keyStroke({'fn'}, 'f10')
            end
        else
            cancelCmd()
        end
    end
end
kanatoei = hs.eventtap.new({hs.eventtap.event.types.flagsChanged},conversion)
kanatoei:start()
