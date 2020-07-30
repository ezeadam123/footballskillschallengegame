

local player = game.Players.LocalPlayer
local scoreData = player.DataFolder.Score
local scoreLabel = player.PlayerGui.ScreenGui.PassingFrame:WaitForChild("ScoreLabelOne")

local status = game:GetService("ReplicatedStorage"):WaitForChild("Status")
local timeLabel = script.Parent.PassingFrame:WaitForChild("TimeLabel")



local playerLabel = script.Parent.PassingFrame:WaitForChild("PlayerOneLabel")
playerLabel.Text = "Player Name: "..player.Name


status.Changed:Connect(function()
	timeLabel.Text = status.Value
end)


scoreData.Changed:Connect(function()
	print(scoreData.Value)
	scoreLabel.Text = "Score: "..scoreData.Value
end)
