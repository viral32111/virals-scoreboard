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

if ( SERVER ) then return end
include("viralsscoreboard_config.lua")

--[[-------------------------------------------------------------------------
Fonts
---------------------------------------------------------------------------]]
surface.CreateFont("ViralsScoreboardTitle", {
	font = ViralsScoreboard.TitleFont or "Helvetica",
	size = 40,
	weight = 600,
})

surface.CreateFont("ViralsScoreboardSubTitle", {
	font = ViralsScoreboard.SubTitleFont or "Helvetica",
	size = 32,
	weight = 600,
})

surface.CreateFont("ViralsScoreboardPlayerRowText", {
	font = ViralsScoreboard.PlayerRowFont or "Helvetica",
	size = 24,
	weight = 600,
})

surface.CreateFont("ViralsScoreboardAuthor", {
	font = "Helvetica",
	size = 15,
	weight = 600,
})

--[[-------------------------------------------------------------------------
Scoreboard
---------------------------------------------------------------------------]]
local DefaultRowColor = Color( 165, 165, 165 )
local ColorDifference = 30

function ViralsScoreboard:show()
	gui.EnableScreenClicker( true )

	local Players = player.GetAll()

	-- Ordering
	if ( ViralsScoreboard.Sort == "immunity" ) then -- Sort by Immunity
		table.sort( Players, function( a, b )
			if ( a != nil and b != nil and ViralsScoreboard.GroupImmunity[ a:GetUserGroup() ] != nil and ViralsScoreboard.GroupImmunity[ b:GetUserGroup() ] != nil ) then
				return ViralsScoreboard.GroupImmunity[ a:GetUserGroup() ] > ViralsScoreboard.GroupImmunity[ b:GetUserGroup() ]
			else
				return a:Frags() > b:Frags() -- Fallback to Kills if Group Immunity is invalid
			end
		end )
	elseif ( ViralsScoreboard.Sort == "ping" ) then -- Sort by Ping
		table.sort( Players, function( a, b )
			return a:Ping() < b:Ping()
		end )
	elseif ( ViralsScoreboard.Sort == "deaths" ) then -- Sort by Deaths
		table.sort( Players, function( a, b )
			return a:Deaths() > b:Deaths()
		end )
	elseif ( ViralsScoreboard.Sort == "kills" ) then -- Sort by Kills
		table.sort( Players, function( a, b )
			return a:Frags() > b:Frags()
		end )
	else -- Default Sort is Immunity
		table.sort( Players, function( a, b )
			if ( a != nil and b != nil and ViralsScoreboard.GroupImmunity[ a:GetUserGroup() ] != nil and ViralsScoreboard.GroupImmunity[ b:GetUserGroup() ] != nil ) then
				return ViralsScoreboard.GroupImmunity[ a:GetUserGroup() ] > ViralsScoreboard.GroupImmunity[ b:GetUserGroup() ]
			else
				return a:Frags() > b:Frags() -- Fallback to Kills if Group Immunity is invalid
			end
		end )
	end

	-- Title
	if ( ViralsScoreboard.Title == "" or ViralsScoreboard.Title == nil ) then
		ScoreboardTitle = GetHostName()
	else
		ScoreboardTitle = ViralsScoreboard.Title
	end

	-- Sub-Title
	if ( ViralsScoreboard.SubTitle == "" or ViralsScoreboard.SubTitle == nil ) then
		ScoreboardSubTitle = game.GetMap()
	else
		ScoreboardSubTitle = ViralsScoreboard.SubTitle
	end

	--[[-------------------------------------------------------------------------
	Scoreboard Title
	---------------------------------------------------------------------------]]
	local ScoreboardTitleBase = vgui.Create( "DPanel" )
	ScoreboardTitleBase:SetSize( 700, 80 )
	ScoreboardTitleBase:SetPos( ScrW()/2-(700/2), 10 )
	function ScoreboardTitleBase:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 0 ) )

		draw.DrawText( ScoreboardTitle, "ViralsScoreboardTitle", w/2+1, 12, Color( 50, 50, 50, 200 ), TEXT_ALIGN_CENTER )
		draw.DrawText( ScoreboardTitle, "ViralsScoreboardTitle", w/2, 11, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )

		draw.DrawText( ScoreboardSubTitle, "ViralsScoreboardSubTitle", w/2+16, 48, Color( 50, 50, 50, 200 ), TEXT_ALIGN_CENTER )
		draw.DrawText( ScoreboardSubTitle, "ViralsScoreboardSubTitle", w/2+15, 47, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end

	--[[-------------------------------------------------------------------------
	Scoreboard Main
	---------------------------------------------------------------------------]]
	local ScoreboardMainBase = vgui.Create( "DPanel" )
	ScoreboardMainBase:SetSize( 700, 800 )
	ScoreboardMainBase:SetPos( ScrW()/2-(700/2), 110 )
	-- ScoreboardMainBase:MakePopup()
	function ScoreboardMainBase:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 0 ) )
	end

	local ScoreboardMainScroll = vgui.Create( "DScrollPanel", ScoreboardMainBase )
	ScoreboardMainScroll:Dock( FILL )

	local ScoreboardMainRows = vgui.Create( "DListLayout", ScoreboardMainScroll )
	--[[ScoreboardMainRows:SetDrawBackground( true )
	ScoreboardMainRows:SetBackgroundColor( Color( 240, 240, 240, 100 ) ) ]]
	ScoreboardMainRows:Dock( FILL )

	if ( ViralsScoreboard.AllowDragDrop ) then
		ScoreboardMainRows:MakeDroppable( "ViralsScoreboardPlayerRows", false )
	end

	for k, v in pairs( Players ) do
		local ScoreboardMainRowsPlayerPanel = ScoreboardMainRows:Add( "DPanel" )
		ScoreboardMainRowsPlayerPanel:SetSize( ScoreboardMainRows:GetWide(), 45 )
		ScoreboardMainRowsPlayerPanel:Dock( TOP )
		ScoreboardMainRowsPlayerPanel:DockMargin( 0, 0, 0, 10 )
		function ScoreboardMainRowsPlayerPanel:Paint( w, h )
			if ( ViralsScoreboard.EnableUserConfig ) then
				if ( ViralsScoreboard.UserBackgroundColor[ v:SteamID() ] == nil ) then
					BackgroundColor = ViralsScoreboard.GroupColors[ v:GetUserGroup() ]
					BackgroundColorBase = Color( ViralsScoreboard.GroupColors[ v:GetUserGroup() ].r - ColorDifference, ViralsScoreboard.GroupColors[ v:GetUserGroup() ].g - ColorDifference, ViralsScoreboard.GroupColors[ v:GetUserGroup() ].b - ColorDifference )
				else
					BackgroundColor = ViralsScoreboard.UserBackgroundColor[ v:SteamID() ]
					BackgroundColorBase = Color( ViralsScoreboard.UserBackgroundColor[ v:SteamID() ].r - ColorDifference, ViralsScoreboard.UserBackgroundColor[ v:SteamID() ].g - ColorDifference, ViralsScoreboard.UserBackgroundColor[ v:SteamID() ].b - ColorDifference )
				end
			else
				if ( ViralsScoreboard.GroupColors[ v:GetUserGroup() ] != nil ) then
					BackgroundColor = ViralsScoreboard.GroupColors[ v:GetUserGroup() ]
					BackgroundColorBase = Color( ViralsScoreboard.GroupColors[ v:GetUserGroup() ].r - ColorDifference, ViralsScoreboard.GroupColors[ v:GetUserGroup() ].g - ColorDifference, ViralsScoreboard.GroupColors[ v:GetUserGroup() ].b - ColorDifference )
				else
					BackgroundColor = DefaultRowColor
					BackgroundColorBase = Color( DefaultRowColor.r - 30, DefaultRowColor.g - 30, DefaultRowColor.b - 30 )
				end
			end

			draw.RoundedBoxEx( 4, 0, 40, w, 5, BackgroundColorBase, false, false, true, true )
			draw.RoundedBoxEx( 4, 0, 0, w, 40, BackgroundColor, true, true, false, false )

			if ( v:Alive() ) then
				NameColor = ViralsScoreboard.AliveColor or Color( 255, 255, 255 )
				NameText = v:Nick()
			else
				NameColor = ViralsScoreboard.DeadColor or Color( 255, 200, 200 )
				NameText = v:Nick() .. " " .. ( ViralsScoreboard.DeadAppend or "(Dead)" )
			end
			
			-- ViralsScoreboard.UserNameColor[ v:SteamID() ] or Color( 255, 255, 255 )
			-- ( Color( ViralsScoreboard.UserTextColor[ v:SteamID() ].r - ColorDifference, ViralsScoreboard.UserTextColor[ v:SteamID() ].g - ColorDifference, ViralsScoreboard.UserTextColor[ v:SteamID() ].b - ColorDifference ) ) or Color( 70, 70, 70, 200 )

			-- Name
			draw.DrawText( NameText, "ViralsScoreboardPlayerRowText", 51, 9, Color( 50, 50, 50, 200 ), TEXT_ALIGN_LEFT )
			draw.DrawText( NameText, "ViralsScoreboardPlayerRowText", 50, 8, NameColor, TEXT_ALIGN_LEFT )
		
			-- Group
			if ( ViralsScoreboard.DisplayGroups ) then
				if ( ViralsScoreboard.GroupNames[ v:GetUserGroup() ] == nil ) then
					UserGroupName = string.upper( string.sub( v:GetUserGroup(), 0, 1 ) ) .. string.sub( v:GetUserGroup(), 2 )
				else
					UserGroupName = ViralsScoreboard.GroupNames[ v:GetUserGroup() ]
				end

				draw.DrawText( UserGroupName, "ViralsScoreboardPlayerRowText", 536, 9, Color( 70, 70, 70, 200 ), TEXT_ALIGN_RIGHT )
				draw.DrawText( UserGroupName, "ViralsScoreboardPlayerRowText", 535, 8, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT )
			end
			
			-- Kills
			if ( ViralsScoreboard.DisplayKills ) then
				draw.DrawText( tostring( v:Frags() ), "ViralsScoreboardPlayerRowText", 571, 9, Color( 70, 70, 70, 200 ), TEXT_ALIGN_CENTER )
				draw.DrawText( tostring( v:Frags() ), "ViralsScoreboardPlayerRowText", 570, 8, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
			end

			-- Deaths
			if ( ViralsScoreboard.DisplayDeaths ) then
				draw.DrawText( tostring( v:Deaths() ), "ViralsScoreboardPlayerRowText", 621, 9, Color( 70, 70, 70, 200 ), TEXT_ALIGN_CENTER )
				draw.DrawText( tostring( v:Deaths() ), "ViralsScoreboardPlayerRowText", 620, 8, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
			end

			-- Ping
			if ( ViralsScoreboard.DisplayPing ) then
				draw.DrawText( tostring( v:Ping() ), "ViralsScoreboardPlayerRowText", 671, 9, Color( 70, 70, 70, 200 ), TEXT_ALIGN_CENTER )
				draw.DrawText( tostring( v:Ping() ), "ViralsScoreboardPlayerRowText", 670, 8, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
			end
		end

		if ( ViralsScoreboard.DisplayAvatar ) then
			ScoreboardMainRowsPlayerPanelAvatarButton = ScoreboardMainRows:Add( "DButton" )
			ScoreboardMainRowsPlayerPanelAvatarButton:SetParent( ScoreboardMainRowsPlayerPanel )
			ScoreboardMainRowsPlayerPanelAvatarButton:Dock( NODOCK )
			ScoreboardMainRowsPlayerPanelAvatarButton:SetPos( 2, 2 )
			ScoreboardMainRowsPlayerPanelAvatarButton:SetSize( 36, 36 )
			function ScoreboardMainRowsPlayerPanelAvatarButton:DoClick()
				v:ShowProfile()
			end

			ScoreboardMainRowsPlayerPanelAvatar = vgui.Create( "AvatarImage", ScoreboardMainRowsPlayerPanelAvatarButton )
			ScoreboardMainRowsPlayerPanelAvatar:Dock( FILL )
			ScoreboardMainRowsPlayerPanelAvatar:SetMouseInputEnabled( false )
			ScoreboardMainRowsPlayerPanelAvatar:SetPlayer( v )
		end
	end

	--[[-------------------------------------------------------------------------
	Author
	---------------------------------------------------------------------------]]
	local ScoreboardAuthor = vgui.Create( "DPanel" )
	ScoreboardAuthor:SetSize( 310, 20 )
	ScoreboardAuthor:SetPos( ScrW()-178, ScrH()-20 )
	function ScoreboardAuthor:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 0 ) )

		draw.DrawText( "Copyright 2017 viral32111", "ViralsScoreboardAuthor", w/2+16, 0, Color( 50, 50, 50, 200 ), TEXT_ALIGN_RIGHT )
		draw.DrawText( "Copyright 2017 viral32111", "ViralsScoreboardAuthor", w/2+15, 0, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT )
	end
	--[[-------------------------------------------------------------------------
	Scoreboard Hide Function
	---------------------------------------------------------------------------]]
	function ViralsScoreboard:hide()
		gui.EnableScreenClicker( false )
		ScoreboardMainBase:Remove()
		ScoreboardTitleBase:Remove()
		ScoreboardAuthor:Remove()
	end
end

--[[-------------------------------------------------------------------------
Scoreboard Toggle
---------------------------------------------------------------------------]]
hook.Add("ScoreboardShow", "ViralsScoreboardShow", function()
	ViralsScoreboard:show()
	return false
end )

hook.Add("ScoreboardHide", "ViralsScoreboardHide", function()
	ViralsScoreboard:hide()
	return false
end )