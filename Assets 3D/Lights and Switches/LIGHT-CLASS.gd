class_name Luz extends Node3D


@onready var omni_light_3d: OmniLight3D = $OmniLight3D


func Switch_Was_Hit():
	
	if omni_light_3d.light_energy < 1:
		omni_light_3d.light_energy = 1
	else:
		omni_light_3d.light_energy = 0
		
