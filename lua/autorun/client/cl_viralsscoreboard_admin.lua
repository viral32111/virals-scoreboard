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

ViralsScoreboard.UserGroups = {
	"superadmin",
	"admin",
	"operator",
	"user"
}

--[[-------------------------------------------------------------------------
Menu
---------------------------------------------------------------------------]]
net.Receive( "ViralsScoreboardAdmin", function()
	local Config = net.ReadTable()
	local DisplayConfig = net.ReadTable()
	local GroupConfig = net.ReadTable()
	local UserConfig = net.ReadTable()

	local ViralsScoreboardSpecialsBase = vgui.Create( "DFrame" ) -- Create it before the main menu so it can be closed

	--[[-------------------------------------------------------------------------
	Admin
	---------------------------------------------------------------------------]]
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

	--[[-------------------------------------------------------------------------
	Specials
	---------------------------------------------------------------------------]]
	ViralsScoreboardSpecialsBase:SetSize( 200, 280 )
	ViralsScoreboardSpecialsBase:SetPos( ScrW()/2+220, ScrH()/2-140 )
	ViralsScoreboardSpecialsBase:SetTitle( "Specials & Information" )
	ViralsScoreboardSpecialsBase:SetDraggable( false )
	ViralsScoreboardSpecialsBase:SetSizable( false )
	ViralsScoreboardSpecialsBase:ShowCloseButton( false )
	ViralsScoreboardSpecialsBase:MakePopup()
	
	local ViralsScoreboardSpecialsLabel = vgui.Create( "DLabel", ViralsScoreboardSpecialsBase )
	ViralsScoreboardSpecialsLabel:SetPos( 10, 30 )
	ViralsScoreboardSpecialsLabel:SetText( "{Hostname} - Gets the server name\n{Map} - Gets the current map name\n{IP} - Gets the server IP\n{MaxPlayers} - Gets server slots\n{Players} - Gets player count\n{Gamemode} - Gets the gamemode\n\nMisc config isn't working.\nGroups config isn't working.\nPer-User config isn't working.\n\nFor font changes to be applied the\nserver needs to reboot.\n\nFor Group and Per-User configs use\nthe main config file." )
	ViralsScoreboardSpecialsLabel:SizeToContents()

	--[[-------------------------------------------------------------------------
	Admin Tabs
	---------------------------------------------------------------------------]]
	local ViralsScoreboardAdminTabs = vgui.Create( "DPropertySheet", ViralsScoreboardAdminBase )
	ViralsScoreboardAdminTabs:Dock( FILL )

	local TextConfigTab = vgui.Create( "DPanel", ViralsScoreboardAdminTabs )
	function TextConfigTab:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 157, 160, 165 ) )
	end
	ViralsScoreboardAdminTabs:AddSheet( "Text", TextConfigTab, "icon16/textfield_rename.png" )

	local ColorsConfigTab = vgui.Create( "DPanel", ViralsScoreboardAdminTabs )
	function ColorsConfigTab:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 157, 160, 165 ) )
	end
	ViralsScoreboardAdminTabs:AddSheet( "Colors", ColorsConfigTab, "icon16/palette.png" )

	local GroupsConfigTab = vgui.Create( "DPanel", ViralsScoreboardAdminTabs )
	function GroupsConfigTab:Paint( w, h )
		draw.RoundedBox( 0, 0, 0,w, h, Color( 157, 160, 165 ) )
	end
	ViralsScoreboardAdminTabs:AddSheet( "Groups", GroupsConfigTab, "icon16/user.png" )

	local PerUserConfigTab = vgui.Create( "DPanel", ViralsScoreboardAdminTabs )
	function PerUserConfigTab:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 157, 160, 165 ) )
	end
	ViralsScoreboardAdminTabs:AddSheet( "Per-User", PerUserConfigTab, "icon16/user_edit.png" )

	local DisplayConfigTab = vgui.Create( "DPanel", ViralsScoreboardAdminTabs )
	function DisplayConfigTab:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 157, 160, 165 ) )
	end
	ViralsScoreboardAdminTabs:AddSheet( "Display", DisplayConfigTab, "icon16/eye.png" )

	local MiscConfigTab = vgui.Create( "DPanel", ViralsScoreboardAdminTabs )
	function MiscConfigTab:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 157, 160, 165 ) )
	end
	ViralsScoreboardAdminTabs:AddSheet( "Misc", MiscConfigTab, "icon16/cog.png" )

	--[[-------------------------------------------------------------------------
	Text Config
	---------------------------------------------------------------------------]]
	-- Title
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", TextConfigTab )
	ViralsScoreboardAdminLabel:SetPos( 10, 0 ) -- +45
	ViralsScoreboardAdminLabel:SetText( "Title (Specials can be used)" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminTitleTextEntry = vgui.Create( "DTextEntry", TextConfigTab )
	ViralsScoreboardAdminTitleTextEntry:SetPos( 10, 17 )
	ViralsScoreboardAdminTitleTextEntry:SetSize( 350, 20 )
	ViralsScoreboardAdminTitleTextEntry:SetText( string.Explode( ";", Config[1] )[1] )

	-- Sub Title
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", TextConfigTab )
	ViralsScoreboardAdminLabel:SetPos( 10, 45 )
	ViralsScoreboardAdminLabel:SetText( "Sub Title (Specials can be used)" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminSubtitleTextEntry = vgui.Create( "DTextEntry", TextConfigTab )
	ViralsScoreboardAdminSubtitleTextEntry:SetPos( 10, 62 )
	ViralsScoreboardAdminSubtitleTextEntry:SetSize( 350, 20 )
	ViralsScoreboardAdminSubtitleTextEntry:SetText( string.Explode( ";", Config[1] )[2] )

	-- Dead Append
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", TextConfigTab )
	ViralsScoreboardAdminLabel:SetPos( 10, 90 )
	ViralsScoreboardAdminLabel:SetText( "Dead Append Text" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminDeadAppendTextEntry = vgui.Create( "DTextEntry", TextConfigTab )
	ViralsScoreboardAdminDeadAppendTextEntry:SetPos( 10, 107 )
	ViralsScoreboardAdminDeadAppendTextEntry:SetSize( 350, 20 )
	ViralsScoreboardAdminDeadAppendTextEntry:SetText( string.Explode( ";", Config[2] )[1] )

	--[[-------------------------------------------------------------------------
	Color Config
	---------------------------------------------------------------------------]]
	-- Dead Color
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", ColorsConfigTab )
	ViralsScoreboardAdminLabel:SetPos( 10, 0 )
	ViralsScoreboardAdminLabel:SetText( "Dead Append Text Color" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminDeadColorMixer = vgui.Create( "DColorMixer", ColorsConfigTab )
	ViralsScoreboardAdminDeadColorMixer:SetPos( 10, 20 )
	ViralsScoreboardAdminDeadColorMixer:SetSize( 350, 68 )
	ViralsScoreboardAdminDeadColorMixer:SetPalette( false )
	ViralsScoreboardAdminDeadColorMixer:SetAlphaBar( false )
	ViralsScoreboardAdminDeadColorMixer:SetWangs( true )
	ViralsScoreboardAdminDeadColorMixer:SetColor( string.ToColor( string.Explode( ";", Config[2] )[2] ) )

	-- Alive Color
	local ViralsScoreboardAdminLabel = vgui.Create( "DLabel", ColorsConfigTab )
	ViralsScoreboardAdminLabel:SetPos( 10, 100 )
	ViralsScoreboardAdminLabel:SetText( "Alive Text Color" )
	ViralsScoreboardAdminLabel:SizeToContents()
	local ViralsScoreboardAdminAliveColorMixer = vgui.Create( "DColorMixer", ColorsConfigTab )
	ViralsScoreboardAdminAliveColorMixer:SetPos( 10, 120 )
	ViralsScoreboardAdminAliveColorMixer:SetSize( 350, 68 )
	ViralsScoreboardAdminAliveColorMixer:SetPalette( false )
	ViralsScoreboardAdminAliveColorMixer:SetAlphaBar( false )
	ViralsScoreboardAdminAliveColorMixer:SetWangs( true )
	ViralsScoreboardAdminAliveColorMixer:SetColor( string.ToColor( string.Explode( ";", Config[2] )[3] ) )

	--[[-------------------------------------------------------------------------
	Groups Config
	---------------------------------------------------------------------------]]
	local ViralsScoreboardAdminRanksLabel = vgui.Create( "DLabel", GroupsConfigTab )
	ViralsScoreboardAdminRanksLabel:SetPos( 10, 0 )
	ViralsScoreboardAdminRanksLabel:SetText( "Rank Ordering and Configuration" )
	ViralsScoreboardAdminRanksLabel:SizeToContents()

	local ViralsScoreboardAdminScroll = vgui.Create( "DScrollPanel", GroupsConfigTab )
	ViralsScoreboardAdminScroll:SetPos( 20, 20 )
	ViralsScoreboardAdminScroll:SetSize( 170, 155 )

	local ViralsScoreboardAdminLayout = vgui.Create( "DListLayout", GroupsConfigTab )
	ViralsScoreboardAdminLayout:Dock( FILL )
	ViralsScoreboardAdminLayout:SetPaintBackground( false )
	ViralsScoreboardAdminLayout:SetBackgroundColor( Color( 0, 100, 100 ) )
	ViralsScoreboardAdminLayout:MakeDroppable( "ViralsScoreboardAdminLayout" )

	for k, v in pairs( ViralsScoreboard.UserGroups ) do
		ViralsScoreboardAdminLayout:Add( Label( v .. " [" .. k .. "]" ) )
	end

	--[[-------------------------------------------------------------------------
	Per-User Config
	---------------------------------------------------------------------------]]


	--[[-------------------------------------------------------------------------
	Display Config
	---------------------------------------------------------------------------]]
	local DisplayAvatar = vgui.Create( "DCheckBoxLabel", DisplayConfigTab )
	DisplayAvatar:SetPos( 10, 10 )
	DisplayAvatar:SetText( "Display Avatars?" )
	DisplayAvatar:SetValue( tonumber( DisplayConfig[1] ) )
	DisplayAvatar:SizeToContents()

	local DisplayGroups = vgui.Create( "DCheckBoxLabel", DisplayConfigTab )
	DisplayGroups:SetPos( 10, 30 )
	DisplayGroups:SetText( "Display Groups?" )
	DisplayGroups:SetValue( tonumber( DisplayConfig[2] ) )
	DisplayGroups:SizeToContents()

	local DisplayKills = vgui.Create( "DCheckBoxLabel", DisplayConfigTab )
	DisplayKills:SetPos( 10, 50 )
	DisplayKills:SetText( "Display Kills?" )
	DisplayKills:SetValue( tonumber( DisplayConfig[3] ) )
	DisplayKills:SizeToContents()

	local DisplayDeaths = vgui.Create( "DCheckBoxLabel", DisplayConfigTab )
	DisplayDeaths:SetPos( 10, 70 )
	DisplayDeaths:SetText( "Display Deaths?" )
	DisplayDeaths:SetValue( tonumber( DisplayConfig[4] ) )
	DisplayDeaths:SizeToContents()

	local DisplayPing = vgui.Create( "DCheckBoxLabel", DisplayConfigTab )
	DisplayPing:SetPos( 10, 90 )
	DisplayPing:SetText( "Display Ping?" )
	DisplayPing:SetValue( tonumber( DisplayConfig[5] ) )
	DisplayPing:SizeToContents()

	--[[-------------------------------------------------------------------------
	Misc Config
	---------------------------------------------------------------------------]]
	-- Title
	local TitleFont = vgui.Create( "DLabel", MiscConfigTab )
	TitleFont:SetPos( 10, 0 )
	TitleFont:SetText( "Title Font (Reboot required for change)" )
	TitleFont:SizeToContents()
	local TitleFontText = vgui.Create( "DTextEntry", MiscConfigTab )
	TitleFontText:SetPos( 10, 17 )
	TitleFontText:SetSize( 350, 20 )
	TitleFontText:SetText( string.Explode( ";", Config[4] )[1] )

	-- Sub Title
	local SubTitleFont = vgui.Create( "DLabel", MiscConfigTab )
	SubTitleFont:SetPos( 10, 45 )
	SubTitleFont:SetText( "Sub Title Font (Reboot required for change)" )
	SubTitleFont:SizeToContents()
	local SubTitleFontText = vgui.Create( "DTextEntry", MiscConfigTab )
	SubTitleFontText:SetPos( 10, 62 )
	SubTitleFontText:SetSize( 350, 20 )
	SubTitleFontText:SetText( string.Explode( ";", Config[4] )[2] )

	-- Player Row Font
	local PlayerRowFont = vgui.Create( "DLabel", MiscConfigTab )
	PlayerRowFont:SetPos( 10, 90 )
	PlayerRowFont:SetText( "Player Row Font (Reboot required for change)" )
	PlayerRowFont:SizeToContents()
	local PlayerRowFontText = vgui.Create( "DTextEntry", MiscConfigTab )
	PlayerRowFontText:SetPos( 10, 107 )
	PlayerRowFontText:SetSize( 350, 20 )
	PlayerRowFontText:SetText( string.Explode( ";", Config[4] )[3] )

	--[[-------------------------------------------------------------------------
	Save Button
	---------------------------------------------------------------------------]]
	local ViralsScoreboardAdminSaveButton = vgui.Create( "DButton", ViralsScoreboardAdminBase )
	ViralsScoreboardAdminSaveButton:Dock( BOTTOM )
	ViralsScoreboardAdminSaveButton:DockMargin( 0, 5, 0, 0 )
	ViralsScoreboardAdminSaveButton:SetText( "Save" )
	function ViralsScoreboardAdminSaveButton:DoClick()
		local DisplayConfigOptions = string.Replace( tostring( DisplayAvatar:GetChecked() ) .. ";" .. tostring( DisplayGroups:GetChecked() ) .. ";" .. tostring( DisplayKills:GetChecked() ) .. ";" .. tostring( DisplayDeaths:GetChecked() ) .. ";" .. tostring( DisplayPing:GetChecked() ), "true", "1" )
		local DisplayConfigOptions = string.Replace( DisplayConfigOptions, "false", "0" )

		net.Start("ViralsScoreboardAdmin")
			net.WriteString( ViralsScoreboardAdminTitleTextEntry:GetValue() .. ";" .. ViralsScoreboardAdminSubtitleTextEntry:GetValue() .. "\n" .. ViralsScoreboardAdminDeadAppendTextEntry:GetValue() .. ";" .. tostring( Color( ViralsScoreboardAdminDeadColorMixer:GetColor().r, ViralsScoreboardAdminDeadColorMixer:GetColor().g, ViralsScoreboardAdminDeadColorMixer:GetColor().b ) ) .. ";" .. tostring( Color( ViralsScoreboardAdminAliveColorMixer:GetColor().r, ViralsScoreboardAdminAliveColorMixer:GetColor().g, ViralsScoreboardAdminAliveColorMixer:GetColor().b ) ) .. "\nimmunity\n" .. TitleFontText:GetValue() .. ";" .. SubTitleFontText:GetValue() .. ";" .. PlayerRowFontText:GetValue() )
			net.WriteString( DisplayConfigOptions )
			net.WriteString( "superadmin;admin;operator;user\nSuper Admin;Admin;Operator;Guest\nColor( 255, 145, 30 );Color( 255, 35, 61 );Color( 29, 221, 0 );Color( 0, 209, 221 )\n4;3;2;1" )
			net.WriteString( "false;\nSTEAM_0:1:104283773;Color( 100, 160, 61 );STEAM_0:1:104283773;Color( 0, 255, 0 )" )
		net.SendToServer()
		ViralsScoreboardAdminBase:Close()
	end
end )