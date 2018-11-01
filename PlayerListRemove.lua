function Entered(player)
	wait()

	if player:findFirstChild("leaderstats") ~= nil then
		player.leaderstats:remove()
	end

	stats = Instance.new("IntValue")
	stats.Parent = player
	stats.Name = "leaderstats"

	-----> World Data <-----
	bool = Instance.new("BoolValue")
	bool.Parent = stats
	bool.Name = "Hidden"
	bool.Value = true

end


game.Players.PlayerAdded:connect(Entered)
	c = game.Players:GetChildren()
	for i=1, #c do
	Entered(c[i])
end 
