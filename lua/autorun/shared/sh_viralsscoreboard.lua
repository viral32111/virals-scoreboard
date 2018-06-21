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

ViralsScoreboard = ViralsScoreboard or {} -- Don't Touch
ViralsScoreboard.GroupNames = {} -- Don't Touch
ViralsScoreboard.GroupColors = {} -- Don't Touch
ViralsScoreboard.GroupImmunity = {} -- Don't Touch
ViralsScoreboard.UserBackgroundColor = {} -- Don't Touch
ViralsScoreboard.UserNameColor = {} -- Don't Touch


--[[-------------------------------------------------------------------------
This is the config file for anything that doesn't work
in the menu at the moment.
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
Should the scoreboard use Group Configuration or Team Configuration?
Rank = 1
Team = 2
---------------------------------------------------------------------------]]
ViralsScoreboard.Mode = 1

--[[-------------------------------------------------------------------------
Group Config
---------------------------------------------------------------------------]]
-- Group Names (Makes group names prettier!)
ViralsScoreboard.GroupNames["user"] = "Guest"
ViralsScoreboard.GroupNames["operator"] = "Operator"
ViralsScoreboard.GroupNames["admin"] = "Admin"
ViralsScoreboard.GroupNames["superadmin"] = "Super Admin"

-- Group Colors (Add more variety!)
ViralsScoreboard.GroupColors["user"] = Color( 0, 209, 221 )
ViralsScoreboard.GroupColors["operator"] = Color( 29, 221, 0 )
ViralsScoreboard.GroupColors["admin"] = Color( 255, 35, 61 )
ViralsScoreboard.GroupColors["superadmin"] = Color( 255, 145, 30 )

-- Group Immunity (Ordering/Targeting of rows)
ViralsScoreboard.GroupImmunity["user"] = 1
ViralsScoreboard.GroupImmunity["operator"] = 2
ViralsScoreboard.GroupImmunity["admin"] = 3
ViralsScoreboard.GroupImmunity["superadmin"] = 4

ViralsScoreboard.AdminGroups = {
	"superadmin",
	"admin"
}

--[[-------------------------------------------------------------------------
Team Configuration
---------------------------------------------------------------------------]]


--[[-------------------------------------------------------------------------
User Config (Use this if you want certain users to have custom colors, Good option for donators)
---------------------------------------------------------------------------]]
ViralsScoreboard.EnableUserConfig = false -- True enables user config, False disables (Users not here will use the group color configs)
	-- Copy and paste the code below for adding custom user colors, just replace 'STEAM_0:00000000' with the users SteamID
	ViralsScoreboard.UserBackgroundColor["STEAM_0:00000000"] = Color( 100, 160, 61 ) -- Row backgroud color
	ViralsScoreboard.UserNameColor["STEAM_0:00000000"] = Color( 0, 255, 0 ) -- Row text color

--[[-------------------------------------------------------------------------
How should the scoreboard order players? (Immunity only works with Group Config Mode)
---------------------------------------------------------------------------]]
ViralsScoreboard.Sort = "immunity" -- immunity, ping, deaths, kills

--[[-------------------------------------------------------------------------
Font Config
---------------------------------------------------------------------------]]
ViralsScoreboard.TitleFont = "Helvetica" -- Custom Title Font, Default: Helvetica
ViralsScoreboard.SubTitleFont = "Helvetica" -- Custom Sub-Title Font, Default: Helvetica
ViralsScoreboard.PlayerRowFont = "Helvetica" -- Custom Player Row Font, Default: Helvetica