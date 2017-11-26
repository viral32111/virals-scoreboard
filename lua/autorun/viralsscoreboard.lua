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

local Version = "1.0.4"

if ( SERVER ) then
	print("[Viral's Scoreboard] Loaded Version: " .. Version )

	util.AddNetworkString("ViralsScoreboardAdmin")
	util.AddNetworkString("ViralsScoreboardSendConfig")

	include("autorun/server/sv_viralsscoreboard.lua")

	AddCSLuaFile("autorun/shared/sh_viralsscoreboard.lua")
	include("autorun/shared/sh_viralsscoreboard.lua")

	AddCSLuaFile("autorun/client/cl_viralsscoreboard.lua")
	include("autorun/client/cl_viralsscoreboard.lua")
	AddCSLuaFile("autorun/client/cl_viralsscoreboard_admin.lua")
	include("autorun/client/cl_viralsscoreboard_admin.lua")

	if not ( file.Exists( "viralsscoreboard_config.txt", "DATA" ) ) then
		file.Write( "viralsscoreboard_config.txt", "{Hostname};{Map}\n(Dead);255 200 200 255;255 255 255 255\nimmunity\nHelvetica;Helvetica;Helvetica" )
	end

	if not ( file.Exists( "viralsscoreboard_displayconfig.txt", "DATA" ) ) then
		file.Write( "viralsscoreboard_displayconfig.txt", "1;1;1;1;1" )
	end

	if not ( file.Exists( "viralsscoreboard_groupconfig.txt", "DATA" ) ) then
		file.Write( "viralsscoreboard_groupconfig.txt", "superadmin;admin;operator;user\nSuper Admin;Admin;Operator;Guest\nColor( 255, 145, 30 );Color( 255, 35, 61 );Color( 29, 221, 0 );Color( 0, 209, 221 )\n4;3;2;1" )
	end

	if not ( file.Exists( "viralsscoreboard_userconfig.txt", "DATA" ) ) then
		file.Write( "viralsscoreboard_userconfig.txt", "false;\nSTEAM_0:1:104283773;Color( 100, 160, 61 );STEAM_0:1:104283773;Color( 0, 255, 0 )" )
	end
end

if ( CLIENT ) then
	print("Thanks for using Viral's Scoreboard, Created by viral32111!")
end

hook.Add( "PlayerConnect", "ViralsScoreboardVersionCheck", function()
	http.Fetch( "https://raw.githubusercontent.com/viral32111/virals-scoreboard/master/VERSION.txt", function( body, len, headers, code )
		local body = string.gsub( body, "\n", "" )
		if ( body == Version ) then
			print( "[Viral's Scoreboard] You are running the most recent version of Viral's Scoreboard!" )
		elseif ( body == "404: Not Found" ) then
			print( "[Viral's Scoreboard] Version page does not exist")
		else
			print( "[Viral's Scoreboard] You are using outdated version of Viral's Scoreboard! (Latest: " .. body .. ", Current: " .. Version .. ")" )
		end
	end,
	function( error )
		print( "[Viral's Scoreboard] Failed to get addon version! (" .. error .. ")" )
	end )
	hook.Remove( "PlayerConnect", "ViralsScoreboardVersionCheck" )
end )