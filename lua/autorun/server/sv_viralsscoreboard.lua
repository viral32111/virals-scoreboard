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

if ( CLIENT ) then return end

--[[-------------------------------------------------------------------------
Chat Command
---------------------------------------------------------------------------]]
hook.Add("PlayerSay", "ViralsScoreboardChatCommand", function( ply, text, team )
	local text = string.lower( text )

	if ( text == "!viralsscoreboard" ) then
		if ( ply:IsSuperAdmin() ) then
			net.Start( "ViralsScoreboardAdmin" )
				net.WriteTable( string.Explode( "\n", file.Read( "viralsscoreboard_config.txt" ) ) )
				net.WriteTable( string.Explode( ";", file.Read( "viralsscoreboard_displayconfig.txt" ) ) )
				net.WriteTable( string.Explode( "\n", file.Read( "viralsscoreboard_groupconfig.txt" ) ) )
				net.WriteTable( string.Explode( "\n", file.Read( "viralsscoreboard_userconfig.txt" ) ) )
			net.Send( ply )
		else
			ply:ChatPrint("You must be Super Admin or above to use this command!")
		end

		return ""
	end
end )

--[[-------------------------------------------------------------------------
Save new configs
---------------------------------------------------------------------------]]
net.Receive( "ViralsScoreboardAdmin", function()
	local Config = net.ReadString()
	local DisplayConfig = net.ReadString()
	local GroupConfig = net.ReadString()
	local UserConfig = net.ReadString()

	file.Write( "viralsscoreboard_config.txt", Config )
	file.Write( "viralsscoreboard_displayconfig.txt", DisplayConfig )
	file.Write( "viralsscoreboard_groupconfig.txt", GroupConfig )
	file.Write( "viralsscoreboard_userconfig.txt", UserConfig )
end )

--[[-------------------------------------------------------------------------
Return the request for files
---------------------------------------------------------------------------]]
hook.Add( "PlayerInitialSpawn", "ViralsScoreboardSendConfig", function( ply )
	net.Start( "ViralsScoreboardSendConfig" )
		net.WriteTable( string.Explode( "\n", file.Read( "viralsscoreboard_config.txt" ) ) )
		net.WriteTable( string.Explode( ";", file.Read( "viralsscoreboard_displayconfig.txt" ) ) )
		net.WriteTable( string.Explode( "\n", file.Read( "viralsscoreboard_groupconfig.txt" ) ) )
		net.WriteTable( string.Explode( "\n", file.Read( "viralsscoreboard_userconfig.txt" ) ) )
	net.Send( ply )
end )