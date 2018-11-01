wait(1)
local Player = script.Parent.Parent.Parent
local ChatGui = Player.PlayerGui.ChatGui
local Template = game.Lighting.ChatTemplate
local ChatActivated = workspace.ChatActivated
local PChatStats = Player.ChatStats

function SizeFont(Gui)
	local enum = 9
	repeat 
		Gui.FontSize = enum
		if enum > 1 then
			enum = enum - 1
		end
	until Gui.TextBounds.Y <= Gui.AbsoluteSize.Y
end

function SizeGui(Gui)
	x = 0
	repeat wait(.005) 
		x = x + .01
		Gui.Size = UDim2.new(x,0,1,0)
	until Gui.TextFits == true 
end

function CreateFrame(Chatter,Message)
	if Chatter ~= "" then
		local ChattingPlayer = game.Players:FindFirstChild(Chatter)
		if ChattingPlayer == nil or PChatStats.ChatStyleDefault.Value == true then ChattingPlayer = ChatActivated.ChatStats end
		local ChatStats = ChattingPlayer.ChatStats
		local ChatFrame = Template:clone()
		local Chat = ChatFrame.Chat
		local Speaker = ChatFrame.Speaker
		Chat.Text = Message
		Speaker.Text = Chatter..": "
		Chat.BackgroundColor3 = ChatStats.BackgroundColor.Value -- coloring
		Speaker.BackgroundColor3 = ChatStats.BackgroundColor.Value
		Chat.TextColor3 = ChatStats.ChatColor.Value
		Speaker.TextColor3 = ChatStats.NameColor.Value
		Chat.TextStrokeColor3 = ChatStats.ChatOutlineColor.Value
		Speaker.TextStrokeColor3 = ChatStats.NameOutlineColor.Value -- end coloring
		ChatFrame.Parent = ChatGui.MainFrame
		wait()
		--------------------------------------------------------------------------Start Framing Size/Font---------
		SizeFont(Chat)
		SizeFont(Speaker)
		SizeGui(Speaker)
		Chat.Position = UDim2.new(Speaker.Size.X.Scale,0,0,0)
		SizeGui(Chat)
		ChatFrame:TweenPosition(UDim2.new(0, 0,(1 - (ChatFrame.Order.Value * (1/7))) , 0), "Out", "Linear", .5, true)
	end
end

function CreateSpawnFrame(Chatter,Message,Order)
	if Message ~= "" then
		local ChattingPlayer = game.Players:FindFirstChild(Chatter)
		if ChattingPlayer == nil or PChatStats.ChatStyleDefault.Value == true then ChattingPlayer = ChatActivated.ChatStats end
		local ChatStats = ChattingPlayer.ChatStats
		local ChatFrame = Template:clone()
		local Chat = ChatFrame.Chat
		local Speaker = ChatFrame.Speaker
		Chat.Text = Message
		Speaker.Text = Chatter..": "
		Chat.BackgroundColor3 = ChatStats.BackgroundColor.Value -- coloring
		Speaker.BackgroundColor3 = ChatStats.BackgroundColor.Value
		Chat.TextColor3 = ChatStats.ChatColor.Value
		Speaker.TextColor3 = ChatStats.NameColor.Value
		Chat.TextStrokeColor3 = ChatStats.ChatOutlineColor.Value
		Speaker.TextStrokeColor3 = ChatStats.NameOutlineColor.Value -- end coloring
		ChatFrame.Parent = ChatGui.MainFrame
		ChatFrame.Order.Value = Order
		wait()
		--------------------------------------------------------------------------Start Framing Size/Font---------
		SizeFont(Chat)
		SizeFont(Speaker)
		SizeGui(Speaker)
		Chat.Position = UDim2.new(Speaker.Size.X.Scale,0,0,0)
		SizeGui(Chat)
		ChatFrame:TweenPosition(UDim2.new(0, 0,(1 - (Order * (1/7))) , 0), "Out", "Linear", .1, true)
	end
end

function MoveFrames()
	local Frames = ChatGui.MainFrame:GetChildren()
	for i=1,#Frames do
		Frames[i].Order.Value = Frames[i].Order.Value + 1
		if Frames[i].Order.Value >= 8 then
			Frames[i]:TweenPosition(UDim2.new(-1, 0, 0 , 0), "Out", "Bounce", 1.5, false,

			function(status)
				 if status == Enum.TweenStatus.Canceled then
					  print("")
				 else
					  Frames[i]:remove()
				 end
			end) 
		else 
			Frames[i]:TweenPosition(UDim2.new(0,0,(1 - (Frames[i].Order.Value * (1/7)) ) , 0), "Out", "Linear", .5, true)
		end 
	end 
end

for i=1,7 do 
	CreateSpawnFrame(ChatActivated["Chat"..i].Speaker.Value,ChatActivated["Chat"..i].Chat.Value,i)
end

function Changed(Value)
	wait(.001)
	script.Click:play()
	MoveFrames()
	CreateFrame(ChatActivated.Chat1.Speaker.Value,ChatActivated.Chat1.Chat.Value)
end 

ChatActivated.Changed:connect(Changed)

