class_name VHS_Player extends Objeto_Interagivel


func Interact():
	
	if Player_Reference.Player_has_Tape:
		
		Player_Reference.Remove_Tape_from_Player()
		
		GlobalEvents.Start_Monster_Hunt()
