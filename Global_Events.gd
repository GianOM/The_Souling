extends Node


@warning_ignore("unused_signal")
signal Player_Entered_Interactable_Range


@warning_ignore("unused_signal")
signal Player_Left_Interactable_Range


@warning_ignore("unused_signal")
signal Show_Dialogue_Event

@warning_ignore("unused_signal")
signal Activate_Player

@warning_ignore("unused_signal")
signal Deactivate_Player

@warning_ignore("unused_signal")
signal Play_Door_Bell_Sound

@warning_ignore("unused_signal")
signal Move_Monster_to_Location



#region Player Inventory Signals

@warning_ignore("unused_signal")
signal PLUS_One_Soul_Cake_Added

@warning_ignore("unused_signal")
signal MINUS_One_Soul_Cake_Added


@warning_ignore("unused_signal")
signal Add_Recipe_Item_to_Player


#endregion

@warning_ignore("unused_signal")
signal Player_is_Kill


@warning_ignore("unused_signal")
signal Show_Retry_Screen

@warning_ignore("unused_signal")
signal Reset_Itens_Positions



var Number_of_Soul_Cakes: int = 0

var Hour_of_Death: int = 18
var Minute_of_Death: int = 0
