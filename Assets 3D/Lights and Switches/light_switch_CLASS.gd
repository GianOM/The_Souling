class_name Interruptor extends Objeto_Interagivel


@export var Lights_to_Affect: Array[Luz]

@onready var light_switch_sound: AudioStreamPlayer3D = $Light_Switch_Sound

@onready var single_light_switch: MeshInstance3D = $"Single Switch/Single_Light_Switch"

func Interact():
	
	
	light_switch_sound.play()
	
	
	for Luz_N in Lights_to_Affect:
		Luz_N.Switch_Was_Hit()
		
		
	if single_light_switch.get_blend_shape_value(0) > 0:
		single_light_switch.set_blend_shape_value(0,0)
	else:
		single_light_switch.set_blend_shape_value(0,1)
	
