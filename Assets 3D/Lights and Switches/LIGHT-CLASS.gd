class_name Luz extends Node3D


@onready var omni_light_3d: OmniLight3D = $OmniLight3D

@export var does_light_starts_on:bool = true

func _ready() -> void:
	
	if does_light_starts_on:
		
		omni_light_3d.show()
		
	else:
		
		omni_light_3d.hide()
		


func Switch_Was_Hit():
	
	if omni_light_3d.visible:
		
		omni_light_3d.hide()
		
	else:
		
		omni_light_3d.show()
		
