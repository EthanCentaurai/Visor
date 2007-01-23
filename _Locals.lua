VisorLocals = {}

--<< ================================================= >>--
--    Core - Chat Options & Help                         --
--<< ================================================= >>--

VisorLocals.ChatCmd = {"/visor2", "/vz"}

--<< ================================================= >>--
--    Core - Keybindings                                 --
--<< ================================================= >>--

BINDING_HEADER_VISOR			= "Visor2"
BINDING_NAME_VISOR_TOCURSOR		= "Move to Cursor"
BINDING_NAME_VISOR_NUDGEUP		= "Nudge Up"
BINDING_NAME_VISOR_NUDGEDOWN		= "Nudge Down"
BINDING_NAME_VISOR_NUDGELEFT		= "Nudge Left"
BINDING_NAME_VISOR_NUDGERIGHT		= "Nudge Right"

--<< ================================================= >>--
--    Core - Main Variables                              --
--<< ================================================= >>--

VisorLocals.Title = "Visor2"
VisorLocals.Version = "Z01"
VisorLocals.Desc = "Filter your view of the UI."

VisorLocals.chatResetYes = "All settings have been reset to their defaults." -- ACEGLOBAL_CHAT_RESET_YES
VisorLocals.txtEnabled = " enabled." -- ACE_MSG_ENABLED
VisorLocals.txtDisabled = " disabled." -- ACE_MSG_DISABLED
VisorLocals.mapOnOff = {[0]="|cffff5050Disabled|r",[1]="|cff00ff00Enabled|r"} -- ACEG_MAP_ONOFF

--<< ================================================= >>--
--    Core - Chat Option Variables                       --
--<< ================================================= >>--

VisorLocals.Chat_GlobalScale = "The global UI-scale has now been set to %s."
VisorLocals.Chat_NoSuchFrame = "The frame [%s] is not a valid UI frame."
VisorLocals.Chat_ActiveFrame = "The frame [%s] is now active."
VisorLocals.Chat_Default = "Default"
VisorLocals.Chat_FrameDeleted = "The frame [%s] has been removed from Visor2's database."
VisorLocals.Chat_NotInDB = "The frame [%s] could not be found within Visor2's database."
VisorLocals.Report_Frame = "Frame"
VisorLocals.Report_Standard = "DEFAULT"

--<< ================================================= >>--
--    Core - Miscellaneous Function Variables            --
--<< ================================================= >>--

VisorLocals.Misc_DoReload = "Your frame positions will be reset after a UI reload."
VisorLocals.Misc_NotHappening = "You can't use the 'Move to Cursor' functionality whilst trying to set a relative parent or second anchor (first is okay)."
VisorLocals.Misc_NoScale = "This frame does not support being independantly scaled."
VisorLocals.Misc_ReloadUI = "Providing you deleted the appropriate frames from the database, they'll be normalized as soon as you've performed a ReloadUI."

--<< ================================================= >>--
--    Core - Debug Variables                             --
--<< ================================================= >>--

VisorLocals.Debug_Frame = "This frame is being used by Visor2 [%s]."
VisorLocals.Debug_ObjType = "The object type (fdb) found by Visor2 is [%s]."

--<< ================================================= >>--
--    Basics - Variables                                 --
--<< ================================================= >>--

VisorLocals.Chat_DepthSet = "Options set on frame [%s]: s [%s], ht [%s], wd [%s], x [%s] and y [%s], c [%s], pr [%s], p1 [%s], p2 [%s]."
VisorLocals.Report_Scale = "Scale"
VisorLocals.Report_Height = "Height"
VisorLocals.Report_Width = "Width"
VisorLocals.Report_Relative = "Relative Parent"
VisorLocals.Report_PointA = "Self Anchor"
VisorLocals.Report_PointB = "Parent Anchor"
VisorLocals.Report_OffSetX = "Offset X"
VisorLocals.Report_OffSetY = "Offset Y"
VisorLocals.Debug_Scaling = "Visor2 is scaling frame [%s]."
VisorLocals.Debug_Height = "Visor2 is setting height to frame [%s]."
VisorLocals.Debug_Width = "Visor2 is setting width to frame [%s]."
VisorLocals.Debug_Moving = "Visor2 is moving frame [%s]."

--<< ================================================= >>--
--    Nudge - Variables                                  --
--<< ================================================= >>--

VisorLocals.Chat_NudgeSet = "Nudge set to [%s]."
VisorLocals.Chat_CannotBeMoved = "This frame cannot be moved any further in that direction."
VisorLocals.Chat_NoMove = "This frame cannot be moved."

--<< ================================================= >>--
--    Hide - Variables                                   --
--<< ================================================= >>--

VisorLocals.Chat_HideSet = "Hidden [%s] set on frame [%s]."
VisorLocals.Report_Hidden = "Hidden"
VisorLocals.Debug_Hiding = "Visor2 is hiding frame [%s]."
VisorLocals.Debug_Showing = "Visor2 is showing frame [%s]."

--<< ================================================= >>--
--    Parent - Variables                                 --
--<< ================================================= >>--

VisorLocals.Chat_ParentSet = "The parent of [%s] is now [%s]."
VisorLocals.Report_Parent = "Parent"
VisorLocals.Debug_Parent = "Visor2 is setting parent for frame [%s]."

--<< ================================================= >>--
--    Alpha - Variables                                  --
--<< ================================================= >>--

VisorLocals.Chat_AlphaSet = "Alpha [%s] set on frame [%s]."
VisorLocals.Report_Alpha = "Alpha"
VisorLocals.Debug_Alpha = "Visor2 is setting alpha for frame [%s]."

--<< ================================================= >>--
--    Strata - Variables                                 --
--<< ================================================= >>--

VisorLocals.Chat_StrataSet = "Strata [%s] set on frame [%s]."
VisorLocals.Chat_LevelSet = "Level [%s] set on frame [%s]."
VisorLocals.Report_Strata = "Strata"
VisorLocals.Report_Level = "Level"
VisorLocals.Debug_Strata = "Visor2 is setting strata on frame [%s]."
VisorLocals.Debug_Level = "Visor2 is setting level on frame [%s]."
