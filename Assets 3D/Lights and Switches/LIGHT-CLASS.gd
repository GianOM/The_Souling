class_name Luz extends Node3D


@onready var omni_light_3d: OmniLight3D = $OmniLight3D

@export var does_light_starts_on:bool = true


#Usado para restaurar a luz
var Light_Toggled_on: bool 

func _ready() -> void:
	Energia.Event_Blackout_Energy.connect(_on_queda_de_energia)
	Energia.Total_Number_of_Lights += 1
	
	if does_light_starts_on:
		
		omni_light_3d.show()
		
		Light_Toggled_on = true
		
		Energia.Number_of_Lights_ON += 1
		
	else:
		
		Light_Toggled_on = false
		
		omni_light_3d.hide()
		

func _on_queda_de_energia():
	
	omni_light_3d.hide()
	
	Energia.Number_of_Lights_ON -= 1
	
	Energia.Light_Was_Interacted.emit()
	
	
func _on_Energia_Restaurada():
	if Light_Toggled_on:
		omni_light_3d.show()
	else:
		omni_light_3d.hide()
	
	
func Switch_Was_Hit():
	
	if omni_light_3d.visible:
		
		omni_light_3d.hide()
		
		Energia.Number_of_Lights_ON -= 1
		
		Light_Toggled_on = false
		
	else:
		
		omni_light_3d.show()
		
		Energia.Number_of_Lights_ON += 1
		
		Light_Toggled_on = true
		
		
	Energia.Light_Was_Interacted.emit()
		
	
