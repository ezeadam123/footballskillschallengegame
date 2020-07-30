

function givePlayerData(player)
	
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"
	
	local dataFolder = Instance.new("Folder", player)
	dataFolder.Name = "DataFolder"	
	
	local score = Instance.new("IntValue", dataFolder)
	score.Name = "Score"
	
	local allTimeScore = Instance.new("IntValue", leaderstats)
	allTimeScore.Name = "All-Time Score"
	
	local hoopsMade = Instance.new("IntValue", dataFolder)
	hoopsMade.Name = "HoopsMade"
	
	local hitObject = Instance.new("BoolValue", dataFolder)
	hitObject.Name = "HitObject"
	
	--remoteClient variables
	
	local remoteClientStartGameEvent = Instance.new("RemoteEvent", player)
	remoteClientStartGameEvent.Name = "RemoteClientStartGameEvent"
	
	local remoteClientEndGameEvent = Instance.new("RemoteEvent", player)
	remoteClientEndGameEvent.Name = "RemoteClientEndGameEvent"
	
	local remoteClientTimeUpEvent = Instance.new("RemoteEvent", player)
	remoteClientTimeUpEvent.Name = "RemoteClientTimeUpEvent"
	
	player.CharacterAdded:Connect(function(char)
		char.Humanoid.WalkSpeed = 20
	end)

end


game.Players.PlayerAdded:Connect(givePlayerData)
