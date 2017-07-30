ViralsScoreboard = ViralsScoreboard or {} -- Don't Touch
ViralsScoreboard.GroupNames = {} -- Don't Touch
ViralsScoreboard.GroupColors = {} -- Don't Touch
ViralsScoreboard.GroupImmunity = {} -- Don't Touch
ViralsScoreboard.UserBackgroundColor = {} -- Don't Touch
ViralsScoreboard.UserNameColor = {} -- Don't Touch

--[[-------------------------------------------------------------------------
Hint:
- Config values that are indented means they are a sub-setting of the
  config that is above them and is not indented, meaning there is no
  point in configuring those if the main value is not on.

Example:

EnableThis = false
	AllowThat = true

'AllowThat' will not run because 'EnableThis' is false.
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
Display Config
---------------------------------------------------------------------------]]
ViralsScoreboard.DisplayAvatar = true -- Display the users avatar
ViralsScoreboard.DisplayGroups = true -- Display the users group
ViralsScoreboard.DisplayKills = true -- Display the users kills
ViralsScoreboard.DisplayDeaths = true -- Display the users deaths
ViralsScoreboard.DisplayPing = true -- Display the users ping

--[[-------------------------------------------------------------------------
Text Config
---------------------------------------------------------------------------]]
ViralsScoreboard.Title = "Your server name here!" -- If you leave this blank it will use the servers hostname as the title, Use a space for none
ViralsScoreboard.SubTitle = "www.example.com" -- Good place to put a website link, if you leave this blank it will use the servers current map, Use a space for none

ViralsScoreboard.DeadAppend = "(Dead)" -- Text that is added to the end of a players name when there dead, Leave blank for none

--[[-------------------------------------------------------------------------
Color Config
---------------------------------------------------------------------------]]
ViralsScoreboard.DeadColor = Color( 255, 200, 200 ) -- Name color when a user is dead
ViralsScoreboard.AliveColor = Color( 255, 255, 255 ) -- Name color when the user is alive

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

--[[-------------------------------------------------------------------------
User Config (Use this if you want certain users to have custom colors, Good option for donators)
---------------------------------------------------------------------------]]
ViralsScoreboard.EnableUserConfig = false -- True enables user config, False disables (Users not here will use the group color configs)
	-- Copy and paste the code below for adding custom user colors, just replace 'STEAM_0:00000000' with the users SteamID
	ViralsScoreboard.UserBackgroundColor["STEAM_0:00000000"] = Color( 100, 160, 61 ) -- Row backgroud color
	ViralsScoreboard.UserNameColor["STEAM_0:1:104283773"] = Color( 0, 255, 0 ) -- Row text color

--[[-------------------------------------------------------------------------
Sorting
---------------------------------------------------------------------------]]
ViralsScoreboard.AllowDragDrop = false -- This allows users to drag and drop player rows, this is completley clientside and resets when the scoreboard is closed (So its pretty much pointless)

-- ViralsScoreboard.ReverseOrder = false -- true for Decending order, false for Acending order

ViralsScoreboard.Sort = "immunity" -- immunity, ping, deaths, kills

--[[-------------------------------------------------------------------------
Font Config
---------------------------------------------------------------------------]]
ViralsScoreboard.TitleFont = "Helvetica" -- Custom Title Font, Default: Helvetica
ViralsScoreboard.SubTitleFont = "Helvetica" -- Custom Sub-Title Font, Default: Helvetica -- Custom Title Font, Default: Helvetica
ViralsScoreboard.PlayerRowFont = "Helvetica" -- Custom Player Row Font, Default: Helvetica