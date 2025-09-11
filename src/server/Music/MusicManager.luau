local MusicManager = {}
MusicManager.Tracks = {}
MusicManager.Index = 1

function MusicManager.LoadMusic()
	local tracks = game.Workspace.Music:GetChildren()
	for i, track: Sound in ipairs(tracks) do
		MusicManager.Tracks[tonumber(track.Name)] = track
		track.Ended:Connect(function()
			MusicManager.Index += 1
			MusicManager.PlaySong()
		end)
	end
	MusicManager.PlaySong()
end

function MusicManager.PlaySong()
	if MusicManager.Index > #MusicManager.Tracks then MusicManager.Index = 1 end
	local track: Sound = MusicManager.Tracks[MusicManager.Index]
	track:Play()
end

return MusicManager
