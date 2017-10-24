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

--[[-------------------------------------------------------------------------
Menu
---------------------------------------------------------------------------]]
net.Receive( "ViralsScoreboardAdmin", function()
	local Config = net.ReadTable()
	local GroupConfig = net.ReadTable()
	local UserConfig = net.ReadTable()

	local ViralsScoreboardSpecialsBase = vgui.Create( "DFrame" ) -- Create it before the main menu so it can be closed

	-- Admin Base
	local ViralsScoreboardAdminBase = vgui.Create( "DFrame" )
	ViralsScoreboardAdminBase:SetSize( 400, 300 )
	ViralsScoreboardAdminBase:SetTitle( "Viral's Scoreboard Admin" )
	ViralsScoreboardAdminBase:SetDraggable( false )
	ViralsScoreboardAdminBase:SetSizable( false )
	ViralsScoreboardAdminBase:ShowCloseButton( true )
	ViralsScoreboardAdminBase:Center()
	ViralsScoreboardAdminBase:MakePopup()
	function ViralsScoreboardAdminBase:OnClose()
		ViralsScoreboardSpecialsBase:Remove()
	end

	local ViralsScoreboardAdminScroll = vgui.Create( "DScrollPanel", ViralsScoreboardAdminBase )
	ViralsScoreboardAdminScroll:Dock( FILL )

	-- Specials Base
	ViralsScoreboardSpecialsBase:SetSize( 200, 280 )
	ViralsScoreboardSpecialsBase:SetPos( ScrW()/2+220, ScrH()/2-140 )
	ViralsScoreboardSpecialsBase:SetTitle( "Specials" )
	ViralsScoreboardSpecialsBase:SetDraggable( false )
	ViralsScoreboardSpecialsBase:SetSizable( false )
	ViralsScoreboardSpecialsBase:ShowCloseButton( false )
	ViralsScoreboardSpecialsBase:MakePopup()

	-- Special Text
	local ViralsScoreboardSpecialsLabel = vgui.Create( "DLabel", ViralsScoreboardSpecialsBase )
	ViralsScoreboardSpecialsLabel:SetPos( 10, 30 )
	ViralsScoreboardSpecialsLabel:SetText( "{Hostname} - Gets the server name\n{Map} - Gets the current map name\n{IP} - Gets the server IP\n{MaxPlayers} - Gets server slots\n{Players} - Gets player count\n{Gamemode} - Gets the gamemode" )
	ViralsScoreboardSpecialsLabel:SizeToContents()

	-- Title
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminLabel:SetPos( 10, 0 ) -- +45
	ViralsScoreboardAdminLabel:SetText( "Title (Specials can be used)" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminTitleTextEntry = vgui.Create( "DTextEntry", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminTitleTextEntry:SetPos( 10, 17 )
	ViralsScoreboardAdminTitleTextEntry:SetSize( 350, 20 )
	ViralsScoreboardAdminTitleTextEntry:SetText( string.Explode( ";", Config[1] )[1] )

	-- Sub Title
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminLabel:SetPos( 10, 45 )
	ViralsScoreboardAdminLabel:SetText( "Sub Title (Specials can be used)" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminSubtitleTextEntry = vgui.Create( "DTextEntry", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminSubtitleTextEntry:SetPos( 10, 62 )
	ViralsScoreboardAdminSubtitleTextEntry:SetSize( 350, 20 )
	ViralsScoreboardAdminSubtitleTextEntry:SetText( string.Explode( ";", Config[1] )[2] )

	-- Dead Append
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminLabel:SetPos( 10, 90 )
	ViralsScoreboardAdminLabel:SetText( "Dead Append Text" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminDeadAppendTextEntry = vgui.Create( "DTextEntry", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminDeadAppendTextEntry:SetPos( 10, 107 )
	ViralsScoreboardAdminDeadAppendTextEntry:SetSize( 350, 20 )
	ViralsScoreboardAdminDeadAppendTextEntry:SetText( string.Explode( ";", Config[2] )[1] )

	-- Dead Color
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminLabel:SetPos( 10, 135 )
	ViralsScoreboardAdminLabel:SetText( "Dead Append Text Color" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminDeadColorMixer = vgui.Create( "DColorMixer", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminDeadColorMixer:SetPos( 10, 152 )
	ViralsScoreboardAdminDeadColorMixer:SetSize( 350, 68 )
	ViralsScoreboardAdminDeadColorMixer:SetPalette( false )
	ViralsScoreboardAdminDeadColorMixer:SetAlphaBar( false )
	ViralsScoreboardAdminDeadColorMixer:SetWangs( true )
	ViralsScoreboardAdminDeadColorMixer:SetColor( string.ToColor( string.Explode( ";", Config[2] )[2] ) )

	-- Alive Color
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminLabel:SetPos( 10, 228 )
	ViralsScoreboardAdminLabel:SetText( "Alive Text Color" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminAliveColorMixer = vgui.Create( "DColorMixer", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminAliveColorMixer:SetPos( 10, 245 )
	ViralsScoreboardAdminAliveColorMixer:SetSize( 350, 68 )
	ViralsScoreboardAdminAliveColorMixer:SetPalette( false )
	ViralsScoreboardAdminAliveColorMixer:SetAlphaBar( false )
	ViralsScoreboardAdminAliveColorMixer:SetWangs( true )
	ViralsScoreboardAdminAliveColorMixer:SetColor( string.ToColor( string.Explode( ";", Config[2] )[3] ) )

	--[[local ViralsScoreboardAdminRanksLabel = vgui.Create( "DLabel", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminRanksLabel:SetPos( 10, 115 )
	ViralsScoreboardAdminRanksLabel:SetText( "Rank Ordering and Configuration" )
	ViralsScoreboardAdminRanksLabel:SizeToContents()

	local ViralsScoreboardAdminScroll = vgui.Create( "DScrollPanel", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminScroll:SetPos( 20, 135 )
	ViralsScoreboardAdminScroll:SetSize( 170, 155 )

	local ViralsScoreboardAdminLayout = vgui.Create( "DListLayout", ViralsScoreboardAdminScroll )
	ViralsScoreboardAdminLayout:Dock( FILL )
	ViralsScoreboardAdminLayout:SetPaintBackground( false )
	ViralsScoreboardAdminLayout:SetBackgroundColor( Color( 0, 100, 100 ) )
	ViralsScoreboardAdminLayout:MakeDroppable( "ViralsScoreboardAdminLayout" )

	for k, v in pairs( ViralsScoreboard.UserGroups ) do
		ViralsScoreboardAdminLayout:Add( Label( v .. " [" .. k .. "]" ) )
	end]]

	-- Save Button
	local ViralsScoreboardAdminSaveButton = vgui.Create( "DButton", ViralsScoreboardAdminBase )
	ViralsScoreboardAdminSaveButton:Dock( BOTTOM )
	ViralsScoreboardAdminSaveButton:SetText( "Save" )
	function ViralsScoreboardAdminSaveButton:DoClick()
		net.Start("ViralsScoreboardAdmin")
			net.WriteString( ViralsScoreboardAdminTitleTextEntry:GetValue() .. ";" .. ViralsScoreboardAdminSubtitleTextEntry:GetValue() .. "\n" .. ViralsScoreboardAdminDeadAppendTextEntry:GetValue() .. ";" .. tostring( Color( ViralsScoreboardAdminDeadColorMixer:GetColor().r, ViralsScoreboardAdminDeadColorMixer:GetColor().g, ViralsScoreboardAdminDeadColorMixer:GetColor().b ) ) .. ";" .. tostring( Color( ViralsScoreboardAdminAliveColorMixer:GetColor().r, ViralsScoreboardAdminAliveColorMixer:GetColor().g, ViralsScoreboardAdminAliveColorMixer:GetColor().b ) ) .. "\nimmunity\nHelvetica;Helvetica;Helvetica" )
			net.WriteString( "superadmin;admin;operator;user\nSuper Admin;Admin;Operator;Guest\nColor( 255, 145, 30 );Color( 255, 35, 61 );Color( 29, 221, 0 );Color( 0, 209, 221 )\n4;3;2;1" )
			net.WriteString( "false;\nSTEAM_0:1:104283773;Color( 100, 160, 61 );STEAM_0:1:104283773;Color( 0, 255, 0 )" )
		net.SendToServer()
		ViralsScoreboardAdminBase:Close()
	end
end )