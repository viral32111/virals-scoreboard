--[[-------------------------------------------------------------------------
Copyright 2017 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]
local ViralsScoreboardVersion = "1.0.0"
local ViralsScoreboardVersionChecked = false

if ( SERVER ) then
	print("[Viral's Scoreboard] Loaded! (Author: viral32111) (Version: " .. ViralsScoreboardVersion .. ")")

	AddCSLuaFile("viralsscoreboard_config.lua")
	include("viralsscoreboard_config.lua")

	AddCSLuaFile("autorun/client/cl_scoreboard.lua")
	include("autorun/client/cl_scoreboard.lua")
end

if ( CLIENT ) then
	print("This server is running Viral's Scoreboard, Created by viral32111! (www.github.com/viral32111)")
end

hook.Add("PlayerConnect", "ViralsScoreboardVersionCheck", function( name, ip )
	if not ( ViralsScoreboardVersionChecked ) then
		ViralsScoreboardVersionChecked = true
		http.Fetch("https://raw.githubusercontent.com/viral32111/virals-scoreboard/master/VERSION.md",
		function( body, len, headers, code )
			local formattedBody = string.gsub( body, "\n", "")
			if ( formattedBody == ViralsScoreboardVersion ) then
				MsgC( Color( 0, 255, 0 ), "[Viral's Scoreboard] You are running the most recent version of Car Keys!\n")
			elseif ( formattedBody == "404: Not Found" ) then
				MsgC( Color( 255, 0, 0 ), "[Viral's Scoreboard] Version page does not exist\n")
			else
				MsgC( Color( 255, 255, 0 ), "[Viral's Scoreboard] You are using outdated version of Car Keys! (Latest: " .. formattedBody .. ", Yours: " .. CarKeysVersion .. ")\n" )
			end
		end,
		function( error )
			MsgC( Color( 255, 0, 0 ), "[Viral's Scoreboard] Failed to get addon version\n")
		end
		)
	end
end )