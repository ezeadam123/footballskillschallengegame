

--created by mostly_adam


--round length to score as many points is 60 seconds

local roundLength = 45
local intermissionLength = 3
local inRound = game:GetService("ReplicatedStorage"):WaitForChild("InRound")
local status = game:GetService("ReplicatedStorage"):WaitForChild("Status")
print(status:GetFullName())
local lobbySpawn = game:GetService("Workspace").Lobby

local maps = game:GetService("ServerStorage"):WaitForChild("Maps"):GetChildren()


--pathfinding service variables
local pathfindingService = game:GetService("PathfindingService")
local path = pathfindingService:CreatePath()



function cleanFootballs()
	
	local gameworkspace = workspace:GetChildren()
	local footballs = {}
	
	for _, football in pairs(gameworkspace)do
		if football then
			if football.Name == "Football" then
				if football.ClassName == "Part" then
					wait()
					table.insert(footballs, football)
					
				end
			end
						
		end
	end
	
	return footballs
end



function getplayer()
	
	for _,plr in pairs(game.Players:GetPlayers())do
		if plr then
			return plr
		end
	end
end

function gethumanoid()

	for _, plr in pairs(game.Players:GetPlayers())do
		if plr then
			local humanoid = plr.Character.Humanoid
			if humanoid then
				return humanoid
			end 
		end
	end
end


function gettorso()
	
	local torsos = {}
	
	for _, plr in pairs(game.Players:GetPlayers())do
		if plr then
			local torso = plr.Character:WaitForChild("LowerTorso")
			if torso then
				return torso
			end 
		end
	end
	
	
end



function selectMap()
	
	--select a random map
	local randomMap = maps[math.random(1, #maps)]
	--cloning the map
	local clonedMap = randomMap:Clone()
	clonedMap.Parent = game.Workspace
	
	if maps then
		if randomMap then
			print(randomMap.Name)
			if clonedMap then
				clonedMap.Parent = game.Workspace
				
				
				return clonedMap
				
			end
		end	
	end
 end

--local inGameSpawn = game:GetService("Workspace").TeleportPart

function roundTimer()
	
	
	
	while wait()do
	
		wait(1)
		
		repeat 
			wait()
			print("Need one player")
			game.Players:GetPlayers() -- repeatedly gets the number of players till it reaches over 0
		until #game.Players:GetPlayers() == 1
			
		local counter = 0

		for i = intermissionLength, 1, -1 do
			print(i)
			inRound.Value = false
			wait(1)
			status.Value = "Intermission: ".. i
			
		end
		
		--round starting
		
		
			
		
		local players = {}
		
		print("number of players in game.."..#game.Players:GetPlayers())
		
		for _,player in pairs(game:WaitForChild("Players"):GetPlayers())do
			wait()
			table.insert(players, player)
		end
		
		wait(0.5)
		
		
		local b, r = pcall(function()
			for _,player in pairs(players)do
				if player then
					print("AWFASFAWF")
					counter = counter + 1
					print(counter)
					player.Character.Humanoid.WalkSpeed = 0
				else
					table.remove(players, _)				
				end	
			end
		end)
		
		
		print("how many players we got from the count...".. counter)
		wait(.45)
		
		
		
		
		--local bool, result = pcall(function()
			
			
			
		local clonedMap = selectMap()
		
		print(clonedMap:GetFullName())
		
		local spawnParts = clonedMap.SpawnParts:GetChildren()
		
		
			
		if counter == 0 then
			print("no players in game")
			
		elseif counter == 1 then
			print("only one player in game")
			if players[1] then
				players[1].Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[2].CFrame.X + 3, spawnParts[2].CFrame.Y + 1.2, spawnParts[2].CFrame.Z)* CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
 				print("teleported")
			else
				print("player not present")
			end
		end
			--[[
			elseif counter == 2 then
				
				if players[1] and players[2] then
					
					players[1].Character.HumanoidRootPart.CFrame = CFrame.new(spawns[1].CFrame.X + 3, spawns[1].CFrame.Y + 1.2, spawns[1].CFrame.Z)* CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
					players[2].Character.HumanoidRootPart.CFrame = CFrame.new(spawns[2].CFrame.X + 3, spawns[2].CFrame.Y + 1.2, spawns[2].CFrame.Z)* CFrame.fromEulerAnglesXYZ(0, math.rad(90), 0)
					
			end
			--]]
				--print("only two players in game")
				
			
			--]]
			
			--end) 
	
	
	
		
		--going to fire an remote client event that will display 3, 2, 1 BEGIN!

		for _, player in pairs(players)do
			if inRound then
				if player then
					if player.Character.Humanoid.Health > 0 then
						local remoteClientStartGameEvent = player:WaitForChild("RemoteClientStartGameEvent")
						if remoteClientStartGameEvent then
							remoteClientStartGameEvent:FireClient(player, status)
						end
					end
				end
			end
		end
		
		
		wait(8)
		inRound.Value = true
		
		
		local humanoid = gethumanoid()
		local torso = gettorso()
		local getplayer = getplayer()
		
		local distance = 0
		
		
		print(humanoid:GetFullName())
		print(torso)
		 
		
		for i = roundLength, 1, -1 do
			wait(0.8)
			status.Value = "Time: "..i
			
			if i == 30 then
				print("30 reached")
				if torso and humanoid then
					print("30 reached #2")
					if pathfindingService and path then
						print("30 reached #3")
						if spawnParts[1] then
							print("30 reached #4")
							if distance ~= nil and getplayer ~= nil then
								print("30 reached #5")
								local remoteClientTimeUpEvent = getplayer:WaitForChild("RemoteClientTimeUpEvent")
								if remoteClientTimeUpEvent then
									
									print("worked baby")
									remoteClientTimeUpEvent:FireClient(getplayer)
									
									wait(0.5)
									
									path:ComputeAsync(torso.Position, spawnParts[1].Position)
									local waypoints = path:GetWaypoints()
									
									--[[
									for i, waypoint in pairs(waypoints)do
										
										wait()
										
										local part = Instance.new("Part", game.Workspace)
										part.Anchored = true
										part.CanCollide = false
										part.Size = Vector3.new(1, 1, 1)
										part.Position = waypoint.Position
										
										
									end
									--]]
									
									for i, waypoint in pairs(waypoints)do
										
										humanoid:MoveTo(waypoint.Position)
										
										repeat
											distance = (waypoint.Position - torso.Position).magnitude
											wait()
											print(distance)
										until distance <= 8
									end
								
									humanoid:MoveTo(spawnParts[1].Position)
									wait(1)
									local newCFrame = CFrame.new(torso.CFrame.X,torso.CFrame.Y,torso.CFrame.Z)* CFrame.fromEulerAnglesXYZ(0, math.rad(120), 0)
									humanoid.Parent.HumanoidRootPart.CFrame = newCFrame
								end	
							end	
						end	
					end	
				end
				--player.Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[1].CFrame.X + 4, spawnParts[1].CFrame.Y + 1.2, spawnParts[1].CFrame.Z + 5)* CFrame.fromEulerAnglesXYZ(0, math.rad(125), 0)
			end	
			
			if i == 15 then
				if torso and humanoid then
					if pathfindingService and path then
						if spawnParts[3] then
							if distance ~= nil and getplayer ~= nil then
								print("30 reached #5")
								local remoteClientTimeUpEvent = getplayer:WaitForChild("RemoteClientTimeUpEvent")
								if remoteClientTimeUpEvent then
									
									print("worked baby")
									remoteClientTimeUpEvent:FireClient(getplayer)
									
									path:ComputeAsync(torso.Position, spawnParts[3].Position)
									local waypoints = path:GetWaypoints()
									
									--[[
									for i, waypoint in pairs(waypoints)do
										
										wait()
										
										local part = Instance.new("Part", game.Workspace)
										part.Anchored = true
										part.CanCollide = false
										part.Size = Vector3.new(1, 1, 1)
										part.Position = waypoint.Position
										
										
									end
									
									--]]
									for i, waypoint in pairs(waypoints)do
										
										humanoid:MoveTo(waypoint.Position)
										
										repeat
											distance = (waypoint.Position - torso.Position).magnitude
											wait()
											print(distance)
										until distance <= 8
									end
								
									humanoid:MoveTo(spawnParts[3].Position)
									wait(1)
									local newCFrame = CFrame.new(torso.CFrame.X,torso.CFrame.Y,torso.CFrame.Z)* CFrame.fromEulerAnglesXYZ(0, math.rad(165), 0)
									humanoid.Parent.HumanoidRootPart.CFrame = newCFrame
								end
							end	
						end	
					end	
				end
				--player.Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[1].CFrame.X + 4, spawnParts[1].CFrame.Y + 1.2, spawnParts[1].CFrame.Z + 5)* CFrame.fromEulerAnglesXYZ(0, math.rad(125), 0)
			end	
				--for _,player in pairs(players)do
					--player.Character.HumanoidRootPart.CFrame = CFrame.new(spawnParts[3].CFrame.X + 4, spawnParts[3].CFrame.Y + 1.2, spawnParts[3].CFrame.Z + 5)* CFrame.fromEulerAnglesXYZ(0, math.rad(50), 0)
						
				--end
				
			print("continue")
		end
			
		
		
		
		
		--end game coding 
		
		inRound.Value = false
		
		for _,player in pairs(players)do
			if player then
				local plrScore = player.DataFolder.Score
				if plrScore then
					local alltimeScore = player:WaitForChild("leaderstats")["All-Time Score"]
					if alltimeScore then
						alltimeScore.Value += plrScore.Value
						local remoteClientEndGameEvent = player:WaitForChild("RemoteClientEndGameEvent")
						if remoteClientEndGameEvent then
							remoteClientEndGameEvent:FireClient(player, plrScore, alltimeScore)
							
							--[[
							
								AN IDEA FOR STORING HIGH SCORES IS TO PUT THE PLRSCORE INTO A TABLE
								AND DTERMINE IN THE TABLE, WHICH SCORE IS THE HIGHEST
							--]]
						end	
					end
				end
			end		
		end
		
		
		
		for _,player in pairs(players)do
			if player then
				local plrScore = player.DataFolder.Score
				if plrScore then
					local allTimeScore = player.leaderstats["All-Time Score"]
					if allTimeScore then
						wait(1)
						plrScore.Value = 0
					end
				end
			end
		end	
		
		
		local footballs = cleanFootballs()
		
		for footballTable in pairs(footballs)do
			
			footballs[footballTable]:Destroy()
			
		end
		
		clonedMap:Destroy()
	end
end

roundTimer()







