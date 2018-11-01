wait(1)
local Player = game.Players.LocalPlayer
local Spam = Player.ChatStats.Spam
local debounce = true

function onChange()
if not debounce then return end
debounce = false
wait(7.5)
Spam.Value = 0
debounce = true
Player.ChatStats.Spamming.Value = false
end

Spam.Changed:connect(onChange)
