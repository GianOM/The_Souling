extends Node

@warning_ignore("unused_signal")
signal Event_Blackout_Energy

@warning_ignore("unused_signal")
signal Restore_Energy





signal Light_Was_Interacted

#Main Corridor, Basement, Kitchen, Dining Room
var Number_of_Lights_ON: int = 0

var Total_Number_of_Lights: int = 0


func _ready() -> void:
	
	Light_Was_Interacted.connect(Should_Power_Outaged)
	
	
func Should_Power_Outaged():
	
	if Number_of_Lights_ON >= 10:
		print("POWER OUTAGED !")
		Event_Blackout_Energy.emit()
		
		
	elif Number_of_Lights_ON < 0:
		Number_of_Lights_ON = 0
		
	print(Number_of_Lights_ON)
	
