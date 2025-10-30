extends Node

signal First_Kid_Encounter


func Start_First_Encounter():
	
	GlobalEvents.Play_Door_Bell_Sound.emit()
	
	First_Kid_Encounter.emit()
	
	
