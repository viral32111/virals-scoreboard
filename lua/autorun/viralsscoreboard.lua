--[[-------------------------------------------------------------------------
Copyright 2017-2018 viral32111

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

ViralsScoreboard = {}
ViralsScoreboard.Version = 106
ViralsScoreboard.Name = "Viral's Scoreboard"

AddCSLuaFile("autorun/shared/sh_viralsscoreboard.lua")
AddCSLuaFile("autorun/client/cl_viralsscoreboard.lua")
AddCSLuaFile("autorun/client/cl_viralsscoreboard_admin.lua")

if ( SERVER ) then
	util.AddNetworkString("ViralsScoreboardAdmin")
	util.AddNetworkString("ViralsScoreboardSendConfig")

	if not ( file.Exists( "viralsscoreboard_config.txt", "DATA" ) ) then
		file.Write( "viralsscoreboard_config.txt", "{Hostname};{Map}\n(Dead);255 200 200 255;255 255 255 255\nimmunity\nHelvetica;Helvetica;Helvetica" )
	end

	if not ( file.Exists( "viralsscoreboard_displayconfig.txt", "DATA" ) ) then
		file.Write( "viralsscoreboard_displayconfig.txt", "1;1;1;1;1" )
	end

	--[[if not ( file.Exists( "viralsscoreboard_groupconfig.txt", "DATA" ) ) then
		file.Write( "viralsscoreboard_groupconfig.txt", "superadmin;admin;operator;user\nSuper Admin;Admin;Operator;Guest\nColor( 255, 145, 30 );Color( 255, 35, 61 );Color( 29, 221, 0 );Color( 0, 209, 221 )\n4;3;2;1" )
	end

	if not ( file.Exists( "viralsscoreboard_userconfig.txt", "DATA" ) ) then
		file.Write( "viralsscoreboard_userconfig.txt", "false;\nSTEAM_0:1:104283773;Color( 100, 160, 61 );STEAM_0:1:104283773;Color( 0, 255, 0 )" )
	end]]
end

hook.Add("PlayerConnect", ViralsScoreboard.Name .. "VersionCheck", function()
	http.Fetch("https://raw.githubusercontent.com/viral32111/virals-scoreboard/master/README.md", function( LatestVersion )
		local LatestVersion = tonumber( string.sub( LatestVersion, string.len( ViralsScoreboard.Name )+18, string.len( ViralsScoreboard.Name )+21 ) )
		if ( LatestVersion == ViralsScoreboard.Version ) then
			print("[" .. ViralsScoreboard.Name .. "] You are running the latest version!")
		elseif ( LatestVersion > ViralsScoreboard.Version ) then
			print("[" .. ViralsScoreboard.Name .. "] You are running an outdated version! (Latest: " .. LatestVersion .. ", Current: " .. ViralsScoreboard.Version .. ")")
		elseif ( LatestVersion < ViralsScoreboard.Version ) then
			print("[" .. ViralsScoreboard.Name .. "] You are running a future version, Please reinstall the addon. (Latest: " .. LatestVersion .. ", Current: " .. ViralsScoreboard.Version .. ")")
		else
			print("[" .. ViralsScoreboard.Name .. "] Failed to parse addon version! (Latest: " .. LatestVersion .. ", Current: " .. ViralsScoreboard.Version .. ")")
		end
	end, function( error )
		print("[" .. ViralsScoreboard.Name .. "] Failed to get addon version! (" .. error .. ")")
	end )

	hook.Remove("PlayerConnect", ViralsScoreboard.Name .. "VersionCheck")
end )

print("[" .. ViralsScoreboard.Name .. "] Loaded Version: " .. ViralsScoreboard.Version)